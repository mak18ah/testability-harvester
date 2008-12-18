package com.google.testing.harvester {
	import flash.net.FileReference;
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import com.google.testing.harvester.MockServerData;
	
	
	public class MockServer extends Server {
		
		public override function fetchProjects(callback:Function):void {
			callback(parseProjects(MockServerData.instance.getProjectsInfo()));
		}
		
		public override function fetchChangelists(name:String, callback:Function):void {
			callback(parseChangeLists(MockServerData.instance.changelists(name)));
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