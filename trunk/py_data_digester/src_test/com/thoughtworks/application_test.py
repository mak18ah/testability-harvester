import unittest
from com.thoughtworks.scmreader import *
from com.thoughtworks.application import *

class ApplicationTest(unittest.TestCase):
    
    def test_application_initialization(self):
        scm = SCMReaderStub()
        app = Application(scm)
        self.assertEqual(scm, app.scmReader)
        self.assertEqual(0, len(app.map))
        
         
      
