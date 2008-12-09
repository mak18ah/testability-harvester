package com.google.testing.harvester {
  import flexunit.framework.TestCase;

  public class ProjectEditControllerTest extends TestCase {
    
    private var controller:ProjectEditController = new ProjectEditController();
    
    public function testCancel():void {
      controller.project.name = "A";
      controller.project.path = "B";
      controller.project.developers = "C";
      controller.copy(controller.project, controller.editableProject);
      assertEquals("A", controller.editableProject.name);
      assertEquals("B", controller.editableProject.path);
      assertEquals("C", controller.editableProject.developers);
    }   
    
  }
}