import unittest
from com.thoughtworks.core import *
from com.thoughtworks.scmreader import *

class CoreTest(unittest.TestCase):
    
    def setUp(self):
        self.p = Project( developer='Dev1', name='Harvester', path='http://localhost')
        self.str = '===\ndevelopers:Dev1\nname:Harvester\npath:http://localhost\n'
        
    def test_serialize(self):
        self.assertEqual(self.str, serialize(self.p))
        
    def test_deserialize(self):
        p = deserialize(self.str)
        self.assertEqual(self.p.developers, p.developers)
        self.assertEqual(self.p.name, p.name)
        self.assertEqual(self.p.path, p.path)


class ProjectTest(unittest.TestCase):
    
    def test_fetchChangeSets(self):
        cs1 = ChangeSet(1, 'Isaac', '2008-01-12', [])
        cs1.fetchFiles = lambda scmReader: {}
        cs2 = ChangeSet(2, 'Isaac', '2008-01-13', [])
        cs2.fetchFiles = lambda scmReader: {}
        
        scm = SCMReader()
        scm.changeSets = lambda proPath: [cs1, cs2]
        
        p = Project(scmReader=scm, developer='Dev1', name='Harvester', path='http://localhost')

        p.fetchChangeSets()
        
        for cs in p.changeSets:
            self.assertEqual(p.path, cs.path)
            
        
class ChangeSetTest(unittest.TestCase):
    
    def test_toCSV(self):
        cs = ChangeSet(number=1, author='Isaac', date='2008-03-01 14:25:28', files=[])
        cs.csvLanguage = lambda : 'Java'
        cs.csvAffectedLines = lambda : '1,2,3,4,5,6'
        
        self.assertEqual('1,Isaac,Java,2008-03-01 14:25:28,null,1,2,3,4,5,6', \
                         cs.toCSV())

    def test_csv_language(self):
        files = []
        files.append(File('src/Add.java'))
        files.append(File('src/Add.py'))
        cs = ChangeSet(number=1, author='Isaac', date='2008-03-01 14:25:28', files=files)
    
        self.assertEqual('Java;Python', cs.csvLanguage())
    
    def test_csv_language_ignore_duplicate_type(self):
        files = []
        files.append(File('src/Add.java'))
        files.append(File('src/Server.py'))
        files.append(File('src/Application.py'))
        cs = ChangeSet(number=1, author='Isaac', date='2008-03-01 14:25:28', files=files)

        self.assertEqual('Java;Python', cs.csvLanguage())
        
    def test_csv_language_identify_unknown_type(self):    
        files = []
        files.append(File('src/Add.xyz'))
        files.append(File('src/Server.java'))
        files.append(File('src/Application.py'))
        cs = ChangeSet(number=1, author='Isaac', date='2008-03-01 14:25:28', files=files)

        self.assertEqual('Other;Java;Python', cs.csvLanguage())
        
    def test_csv_affected_lines(self):
        files = []
        files.append(self.__createFileByAffectedLines('P', 1,2,3))
        files.append(self.__createFileByAffectedLines('P', 1,2,3))
        files.append(self.__createFileByAffectedLines('T', 4,5,6))
        files.append(self.__createFileByAffectedLines('O', 1,1,1))
        
        cs = ChangeSet(number=1, author='Isaac', date='2008-03-01 14:25:28', files=files)
        self.assertEqual('2,6,4,4,6,5', cs.csvAffectedLines())
    
    def __createFileByAffectedLines(self, type, added, deleted, modified):
        file = File('')
        file.type = type
        file.countAddedLines = lambda : added
        file.countDeletedLines = lambda : deleted
        file.countModifiedLines = lambda : modified
        return file
    
    def test_set_language_and_type(self):
        file = File('src/Server.java')
        self.assertEqual('Java', file.language)
        
        file = File('src/Server.py')
        self.assertEqual('Python', file.language)
        
        file = File('src/Server.rb')
        self.assertEqual('Ruby', file.language)
    
        file = File('src/Server.as')
        self.assertEqual('ActionScript', file.language)
    
        file = File('src/Server.xyz')
        self.assertEqual('Other', file.language)
    
        
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    