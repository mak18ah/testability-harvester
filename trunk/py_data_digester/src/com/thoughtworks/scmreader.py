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
    

class SCMReaderStub(SCMReader):
    
    def changeSets(self, proPath):
        return []
    
    def cat(self, projectPath, filePath, revision):
        return ''
    
    def diff(self, projectPath, filePath, sourceRevisionNumber, targetRevisionNumber):
        return ''
