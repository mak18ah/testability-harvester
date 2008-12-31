from com.thoughtworks.application import *
from com.thoughtworks.scmreader import *

################################################
# Mock SCMReader for testing
################################################
class MockSCMReader(SCMReader):
    def changeSets(self, proPath):
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


scmreader = MockSCMReader()
#scmreader = SVNReader()
application = Application(scmreader)

id = -1
projectString1 = """===
developers:dev1,dev2
name:harvester
path:http://testability-harvester.googlecode.com/svn"""

projectString11 = """===
developers:dev1,dev2
name:T-H
path:http://testability-harvester.googlecode.com/svn"""


projectString2 = """===
developers:dev3,dev4
name:svn-digester
path:http://svn-digester.googlecode.com/svn"""

hId = application.saveProject(projectString1)
svdId = application.saveProject(projectString2)

logger.info('Two projects have been saved.')
logger.info('    Project 1 named: ' + application.find(0).name)
logger.info('    Project 2 named: ' + application.find(1).name)

logger.info('==========Get All Projects Information:============')
logger.info(application.projects())
logger.info('===================================================')

logger.info('Update first project name to T-H')
application.updateProject(projectString11, hId)

logger.info('======Get Updated All Projects Information:========')
logger.info(application.projects())
logger.info('===================================================')

logger.info('!!!!!Get CSV of Harvester!!!!!')
logger.info(application.toCSV(hId))

logger.info('!!!!!Get CSV of svn-digester!!!!!')
logger.info(application.toCSV(svdId))


