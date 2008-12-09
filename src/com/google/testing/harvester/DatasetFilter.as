// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flash.events.IEventDispatcher;
  
  import mx.binding.utils.BindingUtils;
  import mx.collections.ArrayCollection;
  import mx.collections.ListCollectionView;
  import mx.events.CollectionEvent;
  import mx.events.PropertyChangeEvent;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  public class DatasetFilter {
    public var unfilteredCLs:ArrayCollection = new ArrayCollection();
   
    public var startDate:Date = new Date();
    public var endDate:Date = new Date();
   
    public var startCL:int = 0;
    public var endCL:int = 0;
   
    public var allDevelopers:Set = new Set();
    public var selectedDevelopers:Set = new Set();
    
    public var skipCLs:Set = new Set();
    
    public var language_CPP:Boolean = true;
    public var language_Java:Boolean = true;
    public var language_JavaScript:Boolean = true;
    public var language_Python:Boolean = true;

    public var filteredCLs:ListCollectionView = new ListCollectionView();
    
    public function DatasetFilter() {
      filteredCLs.filterFunction = filterFunction;
      BindingUtils.bindProperty(filteredCLs, "list", this, "unfilteredCLs");
      (IEventDispatcher(this)).addEventListener(
        PropertyChangeEvent.PROPERTY_CHANGE,
        refresh);
      selectedDevelopers.addEventListener(
        CollectionEvent.COLLECTION_CHANGE,
        refresh);
      skipCLs.addEventListener(
        CollectionEvent.COLLECTION_CHANGE,
        refresh);
      BindingUtils.bindSetter(
        function(items:Array):void{
          allDevelopers.removeAll();
          for each (var cl:Changelist in items) {
            allDevelopers.addItem(cl.user);
          }
        },
        this, ["unfilteredCLs", "source"]);
    }
    
    private function filterFunction(cl:Changelist):Boolean {
      return isCorrectLanguage(cl) &&
             (startCL <= cl.cl && cl.cl <= endCL) &&
             (startDate.time <= cl.date.time && cl.date.time <= endDate.time) &&
             (!skipCLs.contains(cl.cl)) &&
             (selectedDevelopers.length == 0 || selectedDevelopers.contains(cl.user))
      
    }
    
    public function refresh(ignore:*=null):void {
      filteredCLs.refresh();
    }
    
    private function isCorrectLanguage(cl:Changelist):Boolean {
      return (language_CPP        && cl.language == Language.CPP) ||
             (language_Java       && cl.language == Language.JAVA) ||
             (language_JavaScript && cl.language == Language.JAVA_SCRIPT) ||
             (language_Python     && cl.language == Language.PYTHON);
    }
    
  }
}