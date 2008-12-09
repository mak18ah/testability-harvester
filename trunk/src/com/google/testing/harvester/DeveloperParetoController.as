// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flash.events.IEventDispatcher;
  import flash.utils.Dictionary;
  
  import mx.collections.ArrayCollection;
  import mx.collections.Sort;
  import mx.collections.SortField;
  import mx.events.CollectionEvent;
  import mx.events.PropertyChangeEvent;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  public class DeveloperParetoController {

    public var PRODUCTION:Sort = new Sort();
    public var TEST:Sort = new Sort();
    public var RATIO:Sort = new Sort();
    public var SIZE:Sort = new Sort();

    public var showTopN:int = 20;
    private var showTopNCounter:int = 0;

    private var _aggregates:ArrayCollection = new ArrayCollection();
    public var developerAggregates:ArrayCollection = new ArrayCollection();
    public var sortedDeveloperAggregates:ArrayCollection = new ArrayCollection();
    public var chart:ArrayCollection = new ArrayCollection();

    public function DeveloperParetoController() {
      PRODUCTION.fields = [new SortField("production", false, true, int)];
      TEST.fields = [new SortField("test", false, true, int)];
      RATIO.fields = [new SortField("ratio", false, true, Number)];
      SIZE.fields = [new SortField("size", false, true, int)];

      sort = PRODUCTION;
      
      sortedDeveloperAggregates.list = developerAggregates;
      chart.list = sortedDeveloperAggregates;
      
      chart.filterFunction = function(aggregate:Aggregate):Boolean {
        return (showTopNCounter++ < showTopN);
      }

      developerAggregates.addEventListener(
        CollectionEvent.COLLECTION_CHANGE,
        function(event:CollectionEvent):void {
          sortedDeveloperAggregates.refresh();
        });
      sortedDeveloperAggregates.addEventListener(
        CollectionEvent.COLLECTION_CHANGE,
        function(event:CollectionEvent):void {
          showTopNCounter = 0;
          chart.refresh();
          showTopNCounter = 0;
        });
      (IEventDispatcher(this)).addEventListener(
        PropertyChangeEvent.PROPERTY_CHANGE,
        function(event:PropertyChangeEvent):void {
          if (event.property != "showTopN") {
            return;
          }
          showTopNCounter = 0;
          chart.refresh();
        });
    }
    
    public function set aggregates(value:ArrayCollection):void {
      _aggregates.removeEventListener(
        CollectionEvent.COLLECTION_CHANGE,
        computeDeveloperAggregate);
      _aggregates = value;
      computeDeveloperAggregate();
      _aggregates.addEventListener(
        CollectionEvent.COLLECTION_CHANGE,
        computeDeveloperAggregate);
    }
    
    public function get aggregates():ArrayCollection {
      return _aggregates;
    }
    
    public function set sort(sort:*):void {
      sortedDeveloperAggregates.sort = sort as Sort;
      sortedDeveloperAggregates.refresh();
    }
    
    public function computeDeveloperAggregate(ignore:*=null):void {
      var developers:Dictionary = new Dictionary();
      var developerAggregatesArray:Array = [];
      for each (var aggregate:Aggregate in aggregates) {
        var sumAggregate:Aggregate = developers[aggregate.user];
        if (sumAggregate == null) {
          sumAggregate = new Aggregate();
          sumAggregate.user = aggregate.user;
          developers[aggregate.user] = sumAggregate;
          developerAggregatesArray.push(sumAggregate);
        }
        sumAggregate.merge(aggregate);
      }
      developerAggregates.source = developerAggregatesArray;
    }

  }
}