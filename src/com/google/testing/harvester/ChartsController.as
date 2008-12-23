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
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  
  import mx.formatters.DateFormatter;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  public class ChartsController {
    
    private var timestampFormater:DateFormatter = new DateFormatter();
    public var selectedDevelopers:Set = new Set();
    
    public function ChartsController() {
      timestampFormater.formatString = "YYYY/MM/DD LL:NNA EEEE";
    }
    
    public function onChangelistClick(cl:Changelist):void {
      if (cl != null) {
      	// TODO: Redirect to web base version control to see details of the CL.
        navigateToURL(new URLRequest("http://<url>/" + cl.cl), "CL_" + cl.cl);
      }
    }
    
    public function time(cl:Changelist):Number {
      return cl.date.time;
    }
    
    public function timestamp(cl:Changelist, ignore:*=null):String {
      return timestampFormater.format(cl.date);
    }
    
    public function sorter(getter:Function):Function {
      return function(cl1:Changelist, cl2:Changelist):int {
          var value1:Number = getter(cl1);
          var value2:Number = getter(cl2);
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
    
    public function set developerSelection(developers:Array):void {
      selectedDevelopers.source = developers;
    }
    
  }
}