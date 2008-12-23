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
	
	public class ProjectParser {
    /**
     * Given a response from the web-service, parse the response and
     * extract the list of projects.
     */		
		public function parseProjects(projectList:String):ArrayCollection {
		  var projects:ArrayCollection = new ArrayCollection();
      for each(var line:String in projectList.split("\n")) {
        line = StringUtil.trim(line);
        var project:Project;
        if (line == "===") {
        	project = new Project();
        	projects.addItem(project);
        } else if (line != "") {
        	var index:int = line.indexOf(":");
        	var key:String = StringUtil.trim(line.substr(0, index));
        	var value:String = StringUtil.trim(line.substr(index + 1));
       		project[key] = decodeURI(value);
      	}
      }
      
  	  return projects;
		}
	}
}