// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Sorter {
    
    public function functionSort(getter:Function):Function {
      return function(item1:*, item2:*):int {
          return compare(getter(item1), getter(item2));
        }
    }
    
    public function fieldSort(fieldName:String):Function {
      return function(item1:*, item2:*):int {
          return compare(item1[fieldName], item2[fieldName]);
        }
    }
    
    public function compare(value1:Number, value2:Number):int {
      if (isNaN(value1) && isNaN(value2)) {
        return 0;
      } else if (isNaN(value1)) {
        return -1;
      } else if (isNaN(value2)) {
        return 1;
      }
      var diff:Number = value1 - value2;
      if (diff < 0) {
        return -1;
      } else if (diff > 0) {
        return 1;
      } else {
        return 0;
      }
    }
 }
}