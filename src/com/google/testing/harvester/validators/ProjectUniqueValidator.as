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