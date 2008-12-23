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
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import com.google.testing.harvester.MockServerData;
	import com.google.testing.harvester.ProjectParser;
	import com.google.testing.harvester.ChangeListParser;
	
	
	public class MockServer extends Server {
		
		public override function fetchProjects(callback:Function):void {
			callback(new ProjectParser().parseProjects(MockServerData.instance.getProjectsInfo()));
		}
		
		public override function fetchChangelists(name:String, callback:Function):void {
			callback(new ChangeListParser().parseChangeLists(MockServerData.instance.changelists(name)));
		}
	    
	    public override function saveProject(project:Project):void {
	    	MockServerData.instance.projects.push(project); 
	    	var changeList:String = "1,(no author),,2008-03-01 13:42:51,,0,0,0,0,0,0  \n" +
				                    "2,misko.hevery,Other;Java,2008-03-01 14:25:28,,7596,0,0,3715,0,0  \n" +
				                    "3,misko.hevery,,2008-03-01 14:27:44,,0,0,0,0,0,0                  \n" +
				                    "4,Misko.Hevery,,2008-03-01 14:50:07,,0,0,0,0,0,0                  ";
	    	MockServerData.instance.addProjectAndChangeList(project.name, changeList);
	    }
	}
}