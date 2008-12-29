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
    
class AddedFileTest(unittest.TestCase):        
    
    def test_fetch(self):
        scm = SCMReader()
        scm.cat = lambda projectPath, filePath, revision : 'content of source file'
        cs = ChangeSet(1, 'Isaac', date='2008-03-01 14:25:28', files=[])
        cs.path = ''
        
        file = AddedFile('')
        file.fetch(cs, scm)
        
        self.assertEqual('content of source file', file.content)
    
    def test_affected_lines(self):
        file = AddedFile('')
        self.assertEqual(0, file.countAddedLines())
        self.assertEqual(0, file.countDeletedLines())
        self.assertEqual(0, file.countModifiedLines())
        
        file.content = 'line1\nline2\nline3'
        self.assertEqual(3, file.countAddedLines())
        self.assertEqual(0, file.countDeletedLines())
        self.assertEqual(0, file.countModifiedLines())
    

class DeletedFileTest(unittest.TestCase):
    
    def test_fetch(self):
        scm = SCMReader()
        scm.cat = lambda projectPath, filePath, revision : 'content of source file'
        cs = ChangeSet(1, 'Isaac', date='2008-03-01 14:25:28', files=[])
        cs.path = ''
        
        file = DeletedFile('')
        file.fetch(cs, scm)
        
        self.assertEqual('content of source file', file.content)
    
    def test_affected_lines(self):
        file = DeletedFile('')
        self.assertEqual(0, file.countAddedLines())
        self.assertEqual(0, file.countDeletedLines())
        self.assertEqual(0, file.countModifiedLines())
        
        file.content = 'line1\nline2\nline3'
        self.assertEqual(0, file.countAddedLines())
        self.assertEqual(3, file.countDeletedLines())
        self.assertEqual(0, file.countModifiedLines())
    
    
class ModifiedFileTest(unittest.TestCase):
    
    def test_affected_line(self):
        file = ModifiedFile('')
        diff = Diff()
        diff.countAddedLines = lambda : 1
        diff.countDeletedLines = lambda : 2
        diff.countModifiedLines = lambda : 3
        file.diff = diff
        
        self.assertEqual(1, file.countAddedLines())
        self.assertEqual(2, file.countDeletedLines())
        self.assertEqual(3, file.countModifiedLines())
        

class DiffTest(unittest.TestCase):
    
    def setUp(self):   
        self.diff = Diff()
        self.assertEqual(0, self.diff.countAddedLines())
        self.assertEqual(0, self.diff.countDeletedLines())
        self.assertEqual(0, self.diff.countModifiedLines())
        
    def test_added_and_deleted_lines(self):    
        self.diff.content = diff_with_add_delete
        self.diff.analyse()
        
        self.assertEqual(2, self.diff.countAddedLines())
        self.assertEqual(2, self.diff.countDeletedLines())
        self.assertEqual(0, self.diff.countModifiedLines())
        
    def test_modified_lines(self):
        self.diff.content = diff_with_modified
        self.diff.analyse()
        
        self.assertEqual(0, self.diff.countAddedLines())
        self.assertEqual(0, self.diff.countDeletedLines())
        self.assertEqual(3, self.diff.countModifiedLines())
    
    def test_affected_lines(self):
        self.diff.content = diff_content
        self.diff.analyse()
        
        self.assertEqual(2, self.diff.countAddedLines())
        self.assertEqual(2, self.diff.countDeletedLines())
        self.assertEqual(3, self.diff.countModifiedLines())
        
        
diff_with_add_delete='''Index: src_test/JUnitTestRunner.as
===================================================================
--- src_test/JUnitTestRunner.as    (revision 0)
+++ src_test/JUnitTestRunner.as    (revision 14)
@@ -0,0 +1,399 @@
+package
+{
    import flash.events.DataEvent;
-    import flash.net.XMLSocket;
-    import flash.utils.describeType;
    
    import flexunit.framework.Test;
    import flexunit.framework.TestListener;
    import flexunit.framework.TestResult;
        }
    }
}
'''
             
             
diff_with_modified='''Index: src_test/JUnitTestRunner.as
===================================================================
--- src_test/JUnitTestRunner.as    (revision 0)
+++ src_test/JUnitTestRunner.as    (revision 14)
@@ -0,0 +1,399 @@
-package
+package com.thoughtworks
{
    import flash.events.DataEvent;
-    import flash.net.XMLSocket;
+    import flash.utils.describeType;
    
    import flexunit.framework.Test;
    import flexunit.framework.TestListener;
    import flexunit.framework.TestResult;
        }
    }
}
@@ -0,0 +1,399 @@
package
{
    import flash.events.DataEvent;
-    import flash.net.XMLSocket;
+    import flash.utils.describeType;
    
    import flexunit.framework.Test;
    import flexunit.framework.TestListener;
    import flexunit.framework.TestResult;
        }
    }
}'''      
        
             
diff_content='''Index: src_test/JUnitTestRunner.as
===================================================================
--- src_test/JUnitTestRunner.as    (revision 0)
+++ src_test/JUnitTestRunner.as    (revision 14)
@@ -0,0 +1,399 @@
-package
+package com.thoughtworks
{
    import flash.events.DataEvent;
-    import flash.net.XMLSocket;
+    import flash.utils.describeType;
    
    import flexunit.framework.Test;
-    import flexunit.framework.TestListener;
-    import flexunit.framework.TestResult;
        }
    }
}
@@ -0,0 +1,399 @@
package
{
+    import flash.events.DataEvent;
-    import flash.net.XMLSocket;
+    import flash.utils.describeType;
    
    import flexunit.framework.Test;
+    import flexunit.framework.TestListener;
    import flexunit.framework.TestResult;
        }
    }
}'''      
        
        
        
        
        
        