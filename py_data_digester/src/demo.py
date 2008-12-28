from com.thoughtworks.application import *
from com.thoughtworks.scmreader import *

scmreader = MockReader()
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

hId = application.saveProject(projectString1, id)
svdId = application.saveProject(projectString2, id)

print 'Two projects have been saved.'
print '    Project 1 named: ' + application.find(0).name
print '    Project 2 named: ' + application.find(0).name

print '==========Get All Projects Information:============'
print application.projects()
print '==================================================='

print 'Update first project name to T-H'
application.saveProject(projectString11, hId)

print '======Get Updated All Projects Information:========'
print application.projects()
print '==================================================='

print '!!!!!Get CSV of Harvester!!!!!'
print application.toCSV(hId)

#
#print '!!!!!Get CSV of svn-digester!!!!!'
#print application.changeSetWithCSVFormat(svdId)




