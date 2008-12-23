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
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	public class ChangeListParser {
		
    /**
     * Parse the response from web-service for a particular project
     * and extract individual CL information.
     */		
		public function parseChangeLists(csv:String):ArrayCollection {
			var cls:ArrayCollection = new ArrayCollection();
  		for each (var line:String in csv.split(/[\n\r]+/)) {
  		  if (StringUtil.trim(line) != "")
  		    cls.addItem(parseChange(line));
	    }
	    
  		return cls;
		}
	
    /**
     * Parse the incoming line of text into raw data.
     * P - Production; T - Test;
     * A - Add;        C - Change;   D - Delete;
     */
    public function parseChange(csv:String):Changelist {
      var part:Array = csv.split(",");
      var cl:Changelist = new Changelist();
      cl.cl = part[0],
      cl.user = part[1],
      cl.language = Language.parse(part[2]),
      cl.date = parseDate(part[3]),

      cl.productionAdded = int(part[5]),
      cl.productionDeleted = int(part[6]),
      cl.productionChanged = int(part[7]),

      cl.testAdded = int(part[8]),
      cl.testDeleted = int(part[9]),
      cl.testChanged = int(part[10])
      return cl;
    }

    /**
     * Utility function to parse the date.
     */
    public function parseDate(dateString:String):Date {
      var date:Array = dateString.split(" ")[0].split("-");
      var time:Array = dateString.split(" ")[1].split(":");
      return new Date(date[0], date[1] -1, date[2], time[0], time[1], time[2]);
    }
	}
}