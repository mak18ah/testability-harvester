import os
#from com.thoughtworks.logger import *

class Project:
    
    def __init__(self, scmReader=None, developer='', id=-1, name='', path=''):
        self.scmReader = scmReader
        self.developers = developer
        self.id = id
        self.name = name
        self.path = path
        self.changeSets = []
        
        #logger.info("Project Initialize - id: " + str(self.id))
        #logger.info("Project Initialize - name: " + self.name)
        #logger.info("Project Initialize - path: " + self.path)
        #logger.info("Project Initialize - developersL: " + self.developers)
        
    def fetchChangeSets(self):
        changeSets = self.scmReader.changeSets(self.path)
        for cs in changeSets:
            cs.fetchFiles(self.scmReader)
            cs.path = self.path
            #logger.info("Project.fetchChangeSet - path: " + cs.path)
        self.changeSets = changeSets
        
    def toCSV(self):
        csv = ''
        for cs in self.changeSets:
            csv += cs.toCSV() + '\n'
        
        #logger.info("Project.toCSV - csv: " + csv)
        return csv
    
    
class ChangeSet:
    
    def __init__(self, number, author, date, files):
        self.number = number
        self.author = author
        self.date = date # String for easy implement
        self.files = files
        self.path = ''
        
        #logger.info("ChangeSet Initialize - number: " + str(self.number))
        #logger.info("ChangeSet Initialize - author: " + self.author)
        #logger.info("ChangeSet Initialize - date: " + self.date)
        #logger.info("ChangeSet Initialize - files: " + str(self.files))
    
    def fetchFiles(self, scmReader):
        for file in self.files:
            if shouldStatistics(file):
                file.fetch(self, scmReader)

    def toCSV(self):
        csv = str(self.number) + ',' + self.author + ',' + \
               self.csvLanguage() + ',' + self.csvDate() + ',' + \
               'null' + ',' + self.csvAffectedLines()
        #logger.info("ChangeSet.toCSV - csv: " + csv)
        return csv
    
    def csvLanguage(self):
        lang = ''
        for f in self.files:
            if lang.find(f.language) == -1:
                lang += ';' + f.language
        return lang[1:]
    
    def csvDate(self):
        return self.date[0:len('yyyy-MM-dd hh:mm:ss')]
    
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
        statistics = str(pA) + ',' + str(pM) + ',' + str(pD) + ',' + str(tA) + ',' + str(tM) + ',' + str(tD)
        #logger.info("ChangeSet.csvAffectedLines - statistics: " + statistics)
        return statistics
         

class File:
    
    def __init__(self, path):
        self.path = path
        self.setLanguage(path)
        self.setType(path) # P-Production, T-Test, O-Other
        
    def fetch(self, changeSet, scmReader):
        pass
    def countAddedLines(self):
        return 0
    def countDeletedLines(self):
        return 0
    def countModifiedLines(self):
        return 0
    
    def setType(self, path):
        if self.language == 'Other':
            self.type = 'O'
        for pat in testPats:
            if pat.match(path):
                self.type = 'T'
                return
        self.type = 'P'
        
    def setLanguage(self, path):
        ext = os.path.splitext(path)[1][1:].lower()
        if not ext in langMap:
            self.language = 'Other'
            return
        self.language = langMap[ext]
       

class AddedFile(File):
    
    def __init__(self, path):
        File.__init__(self, path)
        self.content = ''
        
        #logger.info("AddedFile Initialize - path: " + self.path)
        #logger.info("AddedFile Initialize - type: " + self.type)
        #logger.info("AddedFile Initialize - language: " + self.language)
    
    def fetch(self, changeSet, scmReader):
        content = scmReader.cat(changeSet.path, self.path, changeSet.number)
        self.content = content

    def countAddedLines(self):
        return len(self.content.splitlines())
    

class DeletedFile(File):

    def __init__(self, path):
        File.__init__(self, path)
        self.content = ''
        
        #logger.info("DeletedFile Initialize - path: " + self.path)
        #logger.info("DeletedFile Initialize - type: " + self.type)
        #logger.info("DeletedFile Initialize - language: " + self.language)
    
    def fetch(self, changeSet, scmReader):
        content = scmReader.cat(changeSet.path, self.path, changeSet.number - 1)
        self.content = content

    def countDeletedLines(self):
        return len(self.content.splitlines())


class ModifiedFile(File):
    
    def __init__(self, path):
        File.__init__(self, path)
        self.diff = None
    
        #logger.info("ModifiedFile Initialize - path: " + self.path)
        #logger.info("ModifiedFile Initialize - type: " + self.type)
        #logger.info("ModifiedFile Initialize - language: " + self.language)
        
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
            if prefix.startswith('---'): continue
            if prefix.startswith('+++'): continue
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
        #logger.info("Diff.countAddedLines - added lines: " + str(self.__added))
        return self.__added
    
    def countDeletedLines(self):
        #logger.info("Diff.countDeletedLines - deleted lines: " + str(self.__deleted))
        return self.__deleted
    
    def countModifiedLines(self):
        #logger.info("Diff.countModifiedLines - modified lines: " + str(self.__modified))
        return self.__modified    


langMap = {'java': 'Java',
           'py':   'Python',
           'rb':   'Ruby',
           'as':   'ActionScript' }   

testPats_without_compile = [] # Patterns for match test code
testPats = [re.compile(pat) for pat in testPats_without_compile]

def serialize(project):
    return '===\n' + \
           'developers:' + project.developers + '\n' + \
           'name:' + project.name + '\n' + \
           'path:' + project.path + '\n'

def deserialize(projectString):
    project = Project()
    lines = projectString.split('\n')
    project.developers = lines[1][len('developers:'):]
    project.name = lines[2][len('name:'):]
    project.path = lines[3][len('path:'):]
    return project

def shouldStatistics(file):
    return file.language != 'Other'
