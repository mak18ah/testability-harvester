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

  public class ProjectEditControllerTest extends TestCase {
    
    private var controller:ProjectEditController = null;
    
    public override function setUp():void {
    	 controller = new ProjectEditController();
    }
    
    public function testCopy():void {
      controller.project.name = "A";
      controller.project.path = "B";
      controller.project.developers = "C";
      controller.copy(controller.project, controller.editableProject);
      assertEquals("A", controller.editableProject.name);
      assertEquals("B", controller.editableProject.path);
      assertEquals("C", controller.editableProject.developers);
    }   
    
    public function testShouldNotPopupWindowWhenProjectIsNotSelected():void {
      var originalProject:Project = controller.project;
      controller.showWindow(null);
      
      assertTrue(originalProject == controller.project);
      assertNull(controller.applyButtonLabel);
      assertNull(controller.editableProject.path);
      assertNull(controller.editableProject.name);
      assertNull(controller.editableProject.developers);
    }
  }
}