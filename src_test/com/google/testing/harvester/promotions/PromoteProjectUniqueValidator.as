package com.google.testing.harvester.promotions {
  import com.google.testing.harvester.validators.ProjectUniqueValidator;
  
  public class PromoteProjectUniqueValidator extends ProjectUniqueValidator {
    public function doValidationInParent(value:Object):Array {
      return super.doValidation(value) ;
    }
   }
}