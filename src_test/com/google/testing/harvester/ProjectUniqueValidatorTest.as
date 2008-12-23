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
