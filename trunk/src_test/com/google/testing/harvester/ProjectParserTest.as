package com.google.testing.harvester {
	import flexunit.framework.TestCase;
	
	import mx.collections.ArrayCollection;
	
	public class ProjectParserTest extends TestCase {
		private var projectParser:ProjectParser = null;
		
		public override function setUp():void {
		  projectParser = new ProjectParser(); 	
		}
		
		public function testParseEmptyProjects():void {
      var projects:ArrayCollection = projectParser.parseProjects("");
      assertEquals(0, projects.length);
    }
	    
    public function testParseKindOfEmptyProjects():void {
      var projects:ArrayCollection = projectParser.parseProjects("\n\r");
      assertEquals(projects.toString(), 0, projects.length);
    }
    
    public function testParseProject():void {
      var projects:ArrayCollection = projectParser.parseProjects(
        "===\nname:A\npath:B\ndevelopers:C\n===\nname:D");
      assertEquals(projects.toString(), 2, projects.length);
      var project:Project = projects[0];
      assertEquals("A", project.name);
      assertEquals("B", project.path);
      assertEquals("C", project.developers);
      project = projects[1];
      assertEquals("D", project.name);
    }		
	}
}