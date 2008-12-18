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