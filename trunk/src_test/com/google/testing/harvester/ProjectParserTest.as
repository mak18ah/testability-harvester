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