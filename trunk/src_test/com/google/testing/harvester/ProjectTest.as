package com.google.testing.harvester {
	import flexunit.framework.TestCase;
	
	public class ProjectTest extends TestCase {
		
		public function testToRawString():void {
			var project:Project = new Project();
			project.name = "Harvester";
			project.path = "http://localhost";
			project.developers = "Davlid,Isaac";
			
			var raw:String ="===\n" + 
							"developers:Davlid,Isaac\n" +
							"name:Harvester\n" + 
							"path:http://localhost\n";
				
			assertEquals(raw, project.toRawString());
		}
	}
}