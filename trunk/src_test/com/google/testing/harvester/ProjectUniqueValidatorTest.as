package com.google.testing.harvester {
  import com.google.testing.harvester.promotions.PromoteProjectUniqueValidator;
  
  import flexunit.framework.*;
  
  import mx.collections.ArrayCollection;
  
  
  public class ProjectUniqueValidatorTest extends TestCase {
      public var validator:PromoteProjectUniqueValidator = new PromoteProjectUniqueValidator();
      public var project1:Project;
      public var project2:Project;
       
    public override function setUp():void {
      project1 = new Project();
      project2 = new Project();
      
      project1.path = "http://localhost";
      project2.path = "www.thoughtworks.com";
      validator.projects = new ArrayCollection([project1, project2]);
    }
    
    public function testShouldRasieErrorIfPathIsDuplicateWithExisting():void {
      assertEquals(1, validator.doValidationInParent("http://localhost").length);
      assertFalse(validator.valid);
    }
    
    public function testShouldNotRasieErrorIfPathIsNotDuplicateWithExisting():void {
      assertEquals(0, validator.doValidationInParent("no_this_project").length);
      assertTrue(validator.valid);
    }
  }
  
}
