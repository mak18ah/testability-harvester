// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.collections.ArrayCollection;
  import mx.controls.Alert;
  import mx.rpc.events.FaultEvent;
  import mx.rpc.events.ResultEvent;
  import mx.rpc.http.HTTPService;
  import mx.utils.StringUtil;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Server {
    
    private var URL_DATA:String = "http://www.corp.google.com/~harvester/harvester.php";
    private var URL_PROJECTS:String = "http://www.corp.google.com/~harvester/projects_2.php";
    
    public function fetchProjects(callback:Function):void {
      var service:HTTPService = new HTTPService();
      service.url = URL_PROJECTS;
      service.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
      service.addEventListener(ResultEvent.RESULT, 
        function (event:ResultEvent):void {
          callback(parseProjects(String(service.lastResult)));
        });
      service.addEventListener(FaultEvent.FAULT, 
        function (event:FaultEvent):void {
          Alert.show(event.toString());
        });
      service.send();
    }

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

    /**
     * Load data set from web-service for a specific project.
     */
    public function fetchChangelists(name:String, callback:Function):void {
      var httpService:HTTPService = new HTTPService();
      httpService.request = {path:name + ".csv"};
      httpService.url = URL_DATA;
      httpService.addEventListener(ResultEvent.RESULT, 
        function(event:ResultEvent):void {
          callback(parseChangeLists(httpService.lastResult as String));
        });
      httpService.addEventListener(FaultEvent.FAULT, 
        function(event:FaultEvent):void {
          Alert.show(event.toString());
        });
      httpService.send();
    }
    
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
    
    public function saveProject(project:Project):void {
      var service:HTTPService = new HTTPService();
      service.url = URL_DATA;
      service.request = {path:project.name + ".info", data:project.toString()};
      service.addEventListener(FaultEvent.FAULT, 
        function (event:FaultEvent):void {
          Alert.show(event.toString());
        });
      service.send();
    }
  }
}