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