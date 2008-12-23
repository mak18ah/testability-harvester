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
      if (project == null) {
        Alert.show("Please select a project.");
        return;
      }
      
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