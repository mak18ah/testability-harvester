import web
from com.thoughtworks.application import *
from com.thoughtworks.scmreader import *

urls = (
    '/csv', 'csv', '/projects', 'projects', '/save', 'save'
)

app = web.application(urls, globals())

scmReader = SVNReader()
application = Application(scmReader)

class csv:        
    def GET(self):
        proID = web.input().id
        return application.toCSV(proID)
        
    def POST(self):
        self.GET()

class projects:        
    def GET(self):
        if len(web.input()) == 0:
            return application.projects()
        else:
            proID = web.input().id
            return application.find(proID)

    def POST(self):
         self.GET()


class save:
    def GET(self):
        input = web.input()
        proID = input.id
        proString = input.projectString
        return application.saveProject(proString, proID)
    
    def POST(self):
        self.GET()

if __name__ == "__main__":
    app.run()