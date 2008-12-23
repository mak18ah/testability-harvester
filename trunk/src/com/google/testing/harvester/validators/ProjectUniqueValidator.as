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
 package com.google.testing.harvester.validators {
  import com.google.testing.harvester.Project;
  
  import mx.collections.ArrayCollection;
  import mx.validators.ValidationResult;
  import mx.validators.Validator;

  public class ProjectUniqueValidator extends Validator {
    
    public var projects:ArrayCollection;
    
    [Bindable]
    public var valid:Boolean = false;
    
    protected override function doValidation(value:Object):Array {
      var validateResults:Array = super.doValidation(value);
      if (validateResults.length > 1) {
        valid = false;
        return validateResults;
      }
      
      
      for each(var project:Project in projects) {
        if (project.path == value as String) {
          validateResults.push(new ValidationResult(false, null, "path_duplicate", "Path cannot be duplicate."));
          valid = false;
          return (validateResults);
        }
      }
      valid = true;
      return validateResults;
    }
  }
}