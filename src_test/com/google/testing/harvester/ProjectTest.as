package com.google.testing.harvester {
	import flexunit.framework.TestCase;
	
	public class ProjectTest extends TestCase {
		
		private var project1:Project = null;
		private var project2:Project = null;
		private var project3:Project = null;
		private var project4:Project = null;
		
		public override function setUp():void{
			project1 = createProject("Harvester","http://localhost","David,Isaac");	
			project2 = createProject("Harvester2","http://localhost","David,Isaac");	
			project3 = createProject("Gmal","mail.google.com","Tom");	
			project4 = createProject("Harvester","http://localhost","David");	
		}
		
		public function createProject(name:String, path:String, developers:String):Project {
			var project:Project = new Project();
			project = new Project();
			
			project.name = name;
			project.path = path;
			project.developers = developers;
			
			return project; 
		}
		
		public function testToRawString():void {
			var raw:String ="===\n" + 
							"developers:David,Isaac\n" +
							"name:Harvester\n" + 
							"path:http://localhost\n";
				
			assertEquals(raw, project1.toRawString());
		}
		
		public function testEquals():void {
			assertTrue(project1.equals(project1));
			
			assertTrue(project1.equals(project2));
			assertTrue(project1.equals(project4));
			assertTrue(project2.equals(project4));
			
			assertFalse(project1.equals(project3));
		}
	}
}