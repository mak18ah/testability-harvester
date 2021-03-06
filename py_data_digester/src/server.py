import web
from com.thoughtworks.application import *
from com.thoughtworks.scmreader import *

urls = (
    '/csv', 'csv', '/projects', 'projects', '/save', 'save'
)

app = web.application(urls, globals())

scmReader = SVNReader()
application = Application(scmReader)

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

hId = application.submitProject(projectString1, id)
svdId = application.submitProject(projectString2, id)


class csv:        
    def GET(self):
        proPath = web.input().path
        return application.changeSetWithCSVFormat(proPath)
        
    def POST(self):
        proPath = web.input().path
        return application.changeSetWithCSVFormat(proPath)
    

class projects:        
    def GET(self):
         return application.projects() 

    def POST(self):
         return application.projects() 


class save:
    def GET(self):
        input = web.input()
        proID = input.id
        proString = input.projectString
        return application.submitProject(id, projectString)
    
    def POST(self):
        self.GET()

if __name__ == "__main__":
    app.run()