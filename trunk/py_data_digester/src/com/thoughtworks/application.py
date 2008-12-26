from com.thoughtworks.core import *

class Application:
    
    def __init__(self, scmReader=None):
        self.scmReader = scmReader
        self.map = {}
        self.id = -1
    
    def find(self, id):
        if id in self.map:
            return self.map[id]
    
    def projects(self):
        str = ""
        for p in self.map.values():
            str += serialize(p)
        return str
    
    def saveProject(self, projectString, id=-1):
        project = deserialize(projectString)
        project.scmReader = self.scmReader
        project.fetchChangeSets()
        
        if id == -1:    # Create New Project
            self.id += 1
            project.id = self.id
            self.map[self.id] = project
            return self.id
        else:           # Update Existing Project
            projectFound = self.map[id]
            projectFound.name = project.name
            projectFound.developers = project.developers
            projectFound.path = project.path
            return projectFound.id  
        
    def toCSV(self, id):
        project = self.find(id) 
        return project.toCSV()
    
