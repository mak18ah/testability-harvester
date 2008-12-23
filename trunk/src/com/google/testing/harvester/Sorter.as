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