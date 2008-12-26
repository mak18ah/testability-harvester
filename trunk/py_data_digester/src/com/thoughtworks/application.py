from com.thoughtworks.core import *

class Application:
    
    def __init__(self, scmReader=None):
        self.scmReader = scmReader
        self.map = {}
    
    def find(self, id):
        if id in self.map:
            return serialized(self.map[id])
    
    def projects(self):
        str = ""
        for p in self.map.values():
            str += serialize(p)
        return str
    
    def saveProject(self, projectString):
        project = deserialize(projectString)
        project.scmReader = self.scmReader
        project.fetchChangeSets()
        
        if project.id in self.map:    # Create New Project
            projectFound = self.map[project.id]
            projectFound.name = project.name
            projectFound.developers = project.developers
            projectFound.path = project.path
        else:           # Update Existing Project
            self.map[project.id] = project
        return project.id
        
    def toCSV(self, id):
        project = self.find(id) 
        return project.toCSV()
    
