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
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  
  import mx.collections.ArrayCollection;
  import mx.collections.Sort;
  import mx.collections.SortField;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  [Event(name="visualize", type="flash.events.Event")]
  [Event(name="newDataset", type="flash.events.Event")]
  public class DatasetController {
    public var server:Server = ServerFactory.create();
    public var projects:ArrayCollection = new ArrayCollection();
    public var selectedProject:Project;
    public var projectEditController:ProjectEditController;
    public var dataset:Dataset = new Dataset();
    public var filter:DatasetFilter = new DatasetFilter();
    public var aggregate:DatasetAggregate = new DatasetAggregate();
    
    public var chartDataset:ArrayCollection = new ArrayCollection();
    
    public function DatasetController() {
      filter.unfilteredCLs = dataset.changelists;
      aggregate.changelists = filter.filteredCLs;
      projects.sort = new Sort();
      projects.sort.fields = [ new SortField("name", true) ];
    }
    
    public function loadProjects():void {
      server.fetchProjects(function(list:ArrayCollection):void {
        projects.source = list.source;
        projects.refresh();
      });
    }
    
    public function fetch(project:Project):void {
      selectedProject = project;
      server.fetchChangelists(
          selectedProject.id,
          processNewDataset
        );
    }
    
    public function processNewDataset(cls:ArrayCollection):void {
      dataset.changelists.source = cls.source;
      filterAllCLs();
      filterAllDates();
      (IEventDispatcher(this)).dispatchEvent(new Event("newDataset"));
    }
    
    public function filterAllDates():void {
      filter.startDate = dataset.first.date; 
      filter.endDate = dataset.last.date; 
    }

    public function filterAllCLs():void {
      filter.startCL = dataset.first.cl; 
      filter.endCL = dataset.last.cl; 
    }
    
    public function refresh():void {
      filter.refresh();
    }
    
    public function visualize():void {
      chartDataset = aggregate.aggregates;
      (IEventDispatcher(this)).dispatchEvent(new Event("visualize"));
    }
    
    public function addProject(parent:DisplayObject):void {
      projectEditController.showWindow(new Project());
    }

    public function editProject():void {
      projectEditController.showWindow(selectedProject);
    }

  }
}