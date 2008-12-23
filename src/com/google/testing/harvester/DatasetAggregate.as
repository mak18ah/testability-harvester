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
  import flash.events.IEventDispatcher;
  import flash.utils.Dictionary;
  
  import mx.collections.ArrayCollection;
  import mx.collections.IList;
  import mx.events.CollectionEvent;
  import mx.events.PropertyChangeEvent;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  public class DatasetAggregate {
    
    private var _changelists:IList;
    
    public var ratioComputer:RatioComputer = new RatioComputer();
    
    public var aggregateDevelopers:Boolean = false;
    public var timeAggregator:Function = TimeAggregator.NONE;
    
    public var aggregates:ArrayCollection = new ArrayCollection();
    
    public function DatasetAggregate() {
      changelists = new ArrayCollection();
      (IEventDispatcher(this)).addEventListener(
        PropertyChangeEvent.PROPERTY_CHANGE,
        refresh );
      (IEventDispatcher(ratioComputer)).addEventListener(
        PropertyChangeEvent.PROPERTY_CHANGE,
        refresh );
    }
    
    public function set changelists(changelists:IList):void {
      if (_changelists != null) {
        _changelists.removeEventListener(
          CollectionEvent.COLLECTION_CHANGE,
          refresh);
      }
      _changelists = changelists;
      if (_changelists != null) {
        _changelists.addEventListener(
          CollectionEvent.COLLECTION_CHANGE,
          refresh);
      }
    }
    
    public function get changelists():IList {
      return _changelists;
    }

    public function refresh(event:* = null):void {
      var list:Array = [];
      var lastBucketTime:Date = new Date(0);
      var lastAggregates:Dictionary = null;
      for each (var cl:Changelist in _changelists) {
        var bucketTime:Date = timeAggregator(cl.date);
        if (lastBucketTime.time != bucketTime.time) {
          lastBucketTime = bucketTime;
          lastAggregates = new Dictionary();
        }
        var user:String = aggregateDevelopers ? "EVERYONE" : cl.user;
        var aggregate:Aggregate = lastAggregates[user];
        if (aggregate == null) {
          aggregate = new Aggregate();
          aggregate.user = user;
          aggregate.timestamp = bucketTime;
          lastAggregates[user] = aggregate;
          list.push(aggregate);
        }
        aggregate.addChangelist(cl, ratioComputer);
      }
      aggregates.source = list;
    }
    
  }
}