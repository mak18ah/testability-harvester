from com.thoughtworks.core import *

class SCMReader:
    
    # Return Value: List of ChangeSet
    def changeSets(self, proPath):
        pass
    
    # Return Value: String
    def cat(self, projectPath, filePath, revision):
        pass
    
    # Return Value: Diff
    def diff(self, projectPath, filePath, sourceRevisionNumber, targetRevisionNumber):
        pass
    

class MockReader(SCMReader):
    
    def changeSets(self, proPath):
        
        #def __init__(self, number, author, date, files):
        files = []
        files.append(AddedFile('src/TestCase.java'))
        files.append(DeletedFile('src/TestCase.java'))
        
        changeSet = ChangeSet(1, 'isaachanStar', '2008-12-12 12:09:12', files)
        return [changeSet]
    
    def cat(self, projectPath, filePath, revision):
        return '''class
but sdfsd
sdf
sdfsdaf
sadfsdaf
dsd
ssdfsdf'''
    
    def diff(self, projectPath, filePath, sourceRevisionNumber, targetRevisionNumber):
        return '''+ public class
-public static class
  public void f() {
+  xxxx   
  }
+'''
    
