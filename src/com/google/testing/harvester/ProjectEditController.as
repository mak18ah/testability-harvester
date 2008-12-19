package com.google.testing.harvester {
  import flash.display.DisplayObject;
  
  import mx.collections.ArrayCollection;
  import mx.controls.Alert;
  import mx.core.Application;
  import mx.managers.PopUpManager;
  import mx.utils.ObjectUtil;
  
  [Bindable]
  public class ProjectEditController {
    public var server:Server = ServerFactory.create();
    
    public var project:Project = new Project();
    public var editableProject:Project = new Project();
    public var projects:ArrayCollection;
    
    public var parent:DisplayObject;
    
    private var view:ProjectEditView;
    public var applyButtonLabel:String;
    
    public function cancel():void {
      hideWindow();
    }
    
    public function apply():void {
      Alert.show("The project CLs are gathered nightly.\n\n" + 
          "It may take 24hrs before your data shows up / is updated.");
      copy(editableProject, project);
      hideWindow();
      server.saveProject(project);
    }
    
    public function copy(src:*, dst:*):void {
      for (var key:String in ObjectUtil.copy(src)) {
        dst[key] = src[key];
      }
    }
    
    public function showWindow(project:Project):void {
      view = ProjectEditView(
        PopUpManager.createPopUp(parent, ProjectEditView, true));
      this.project = project;
      view.controller = this;
      copy(project, editableProject);
      applyButtonLabel = project.name == null ? "Create" : "Update";
  
      var app:Application = Application.application as Application;
      view.x = (app.width - view.width) / 2;
      view.y = (app.height - view.height) / 2;
    }
    
    public function hideWindow():void {
      PopUpManager.removePopUp(view);
      view = null;
    }
  }
}