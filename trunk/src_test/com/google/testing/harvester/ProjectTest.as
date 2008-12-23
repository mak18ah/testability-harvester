/*
 * Copyright 2008 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
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