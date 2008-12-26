import os

class Project:
    id = -1
    def __init__(self, scmReader=None, developer='', name='', path=''):
        self.scmReader = scmReader
        self.developers = developer
        self.name = name
        self.path = path
        self.changeSets = []
        Project.id += 1
        self.id = Project.id
        
    def fetchChangeSets(self):
        changeSets = self.scmReader.changeSets(self.path)
        for cs in changeSets:
            cs.fetchFiles(self.scmReader)
            cs.path = self.path
        
        self.changeSets = changeSets
        
    def toCSV(self):
        csv = ""
        for cs in self.changeSets:
            csv += cs.toCSV() + '\n'
        return csv
    
    
class ChangeSet:
    
    def __init__(self, number, author, date, files, path):
        self.number = number
        self.author = author
        self.date = date # String for easy implement
        self.files = files
        self.path = path
    
    def fetchFiles(self, scmReader):
        for file in self.files:
            if shouldStatistics(file):
                file.fetch(self, scmReader)

    def toCSV(self):
        return str(self.number) + "," + self.author + "," + \
               self.csvLanguage() + "," + self.csvDate() + "," + \
               "null" + "," + self.csvAffectedLines()
    
    def csvLanguage(self):
        lang = ""
        for f in self.files:
            if lang.find(f.language) == -1:
                lang += ";" + f.language
        return lang[1:]
    
    def csvDate(self):
        return self.date[0:len("yyyy-MM-dd hh:mm:ss")]
    
    def csvAffectedLines(self):
        pA = pD = pM = 0
        tA = tD = tM = 0
        
        for f in self.files:
            if f.type == 'P':
                pA += f.countAddedLines()
                pD += f.countDeletedLines()
                pM += f.countModifiedLines()
            elif f.type == 'T':
                tA += f.countAddedLines()
                tD += f.countDeletedLines()
                tM += f.countModifiedLines()
                
        return str(pA) + "," + str(pM) + "," + str(pD) + "," + str(tA) + "," + str(tM) + "," + str(tD)
         

class File:
    
    def __init__(self, path):
        self.path = path
        self.language = self.getLanguage(path)
        self.type = self.getType(path) # P-Production, T-Test, O-Other
    
    def fetch(self, changeSet, scmReader):
        pass
    def countAddedLines(self):
        return 0
    def countDeletedLines(self):
        return 0
    def countModifiedLines(self):
        return 0
    
    def getType(self, path):
        if self.language == 'Other':
            return 'O'
        for pat in testPats:
            if pat.match(path):
                return 'T'
        return 'P'
        
    def getLanguage(self, path):
        ext = os.path.splitext(path)[1][1:].lower()
        if not ext in langMap:
            return 'Other'
        return langMap[ext]
       

class AddedFile(File):
    
    def __init__(self, path):
        File.__init__(self, path)
    
    def fetch(self, changeSet, scmReader):
        if self.language == 'Other':
            content = ''
        else:
            content = scmReader.cat(changeSet.path, self.path, changeSet.number)
        self.content = content

    def countAddedLines(self):
        return len(self.content.splitlines())
    

class DeletedFile(File):
    
    def __init__(self, path):
        File.__init__(self, path)
        self.content = ''
    
    def fetch(self, changeSet, scmReader):
        if self.language == 'Other':
            content = ''
        else:
            content = scmReader.cat(changeSet.path, self.path, changeSet.number - 1)
        self.content = content

    def countDeletedLines(self):
        return len(self.content.splitlines())


class ModifiedFile(File):
    
    def __init__(self, path):
        File.__init__(self, path)
        self.diff = None
    
    def fetch(self, changeSet, scmReader):
        self.diff = scmReader.diff(changeSet.path, self.path, changeSet.number- 1, changeSet.number)
        self.diff.analyse()

    def countAddedLines(self):
        return self.diff.countAddedLines()
    
    def countDeletedLines(self):
        return self.diff.countDeletedLines()
    
    def countModifiedLines(self):
        return self.diff.countModifiedLines()   


class Diff:
    
    def __init__(self, content=''):
        self.content = content
        self.__added    = 0
        self.__deleted  = 0
        self.__modified = 0

    def analyse(self):
        suspicion = False
        for prefix in self.content.split('\n'):
            if prefix.startswith('-'):
                self.__deleted += 1
                suspicion = True
            elif prefix.startswith('+'):
                if suspicion :
                    self.__modified += 1
                    self.__deleted -= 1
                    suspicion = False
                else: 
                    self.__added += 1
            else:
                suspicion = False 
        
    def countAddedLines(self):
        return self.__added
    
    def countDeletedLines(self):
        return self.__deleted
    
    def countModifiedLines(self):
        return self.__modified    


langMap = {"java": 'Java',
           "py":   'Python',
           "rb":   'Ruby',
           "as":   'ActionScript' }   

testPats_without_compile = [] # Patterns for match test code
testPats = [re.compile(pat) for pat in testPats_without_compile]

def serialize(project):
    return "===\n" + \
           "developers:" + project.developers + "\n" + \
           "id:" + project.id + "\n" + \
           "name:" + project.name + "\n" + \
           "path:" + project.path + '\n'

def deserialize(projectString):
    project = Project()
    lines = projectString.split('\n')
    project.developers = lines[1][len('developers:'):]
    if lines[2].startswith('id'):
        project.id = int(lines[2][len('id:'):])
        project.name = lines[3][len('name:'):]
        project.path = lines[4][len('path:'):]
    else:
        project.name = lines[2][len('name:'):]
        project.path = lines[3][len('path:'):]
    return project

def shouldStatistics(file):
    return file.language != 'Other'
