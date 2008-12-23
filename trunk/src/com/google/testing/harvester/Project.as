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
  import mx.utils.ObjectUtil;
  
  [Bindable]
  public class Project {
    public var name:String;
    public var path:String;
    public var developers:String;
    
    public function toString():String {
      var keys:Array = [];
      for (var key:String in ObjectUtil.copy(this)) {
        keys.push(key);
      }
      keys.sort();
      var text:String = "";
      for each (key in keys) {
        text += key + ":" + encodeURI(this[key]) + "\n";
      }
      return text;
    }
    
    public function toRawString():String {
    	return "===\n" + toString();
    }
    
    public function equals(project:Project):Boolean {
    	return path == project.path ? true : false;
    }
  }
}