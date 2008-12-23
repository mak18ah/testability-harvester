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
  
  import mx.charts.series.LineSeries;
  import mx.collections.ArrayCollection;
  import mx.events.CollectionEvent;
  import mx.events.PropertyChangeEvent;
  import mx.graphics.Stroke;
  
  [Bindable]
  public class NoTestController {
    private var _aggregates:ArrayCollection = new ArrayCollection();
    public var clsToAverageOver:Number = 10;
    public var lineSeries:Array = [];
    public var scaleByClSize:Boolean = true;
    public var thresholdPercent:Number = 50;
    
    public function NoTestController() {
      (IEventDispatcher(this)).addEventListener(
        PropertyChangeEvent.PROPERTY_CHANGE, 
        function(event:PropertyChangeEvent):void {
          if (event.property != "lineSeries") {
            refresh();
          }
        });
    }
    
    public function get aggregates(): ArrayCollection {
      return _aggregates;
    }
    
    public function set aggregates(value: ArrayCollection): void {
      if (_aggregates != null) {
        _aggregates.removeEventListener(CollectionEvent.COLLECTION_CHANGE, refresh);
      }
      _aggregates = value;
      refresh();
      if (_aggregates != null) {
        _aggregates.addEventListener(CollectionEvent.COLLECTION_CHANGE, refresh);
      }
    }
    
   public function refresh(ignore:*=null): void {
      var averageByUser:Dictionary = new Dictionary();
      var seriesByUser:Dictionary = new Dictionary();
      var newSeries:Array = [];
      for each (var aggregate:Aggregate in _aggregates) {
        var user:String = aggregate.user;
        var window:AveragingWindow = averageByUser[user];
        var series:Array = seriesByUser[user];
        if (window == null) {
          window = new AveragingWindow(clsToAverageOver);
          series = [];
          averageByUser[user] = window;
          seriesByUser[user] = series;
          newSeries.push(createSeries(user, aggregate.color, series));
        }
        var value:Number = (aggregate.ratio * 100 >= thresholdPercent) ? 1 : 0;
        var weight:Number = scaleByClSize ? Math.abs(aggregate.size) : 1;
        window.add(value, weight);
        series.push({timestamp:aggregate.timestamp, percent:100 * window.average});
      }
      lineSeries = newSeries;
    }
    
    private function createSeries(name:String, color:int, dataProvider:Array): LineSeries {
      var series:LineSeries = new LineSeries();
      series.displayName = name;
      series.xField = "timestamp";
      series.yField = "percent";
      
      var stroke:Stroke = new Stroke();
      stroke.color = color;
      stroke.weight = 1;
      series.setStyle("lineStroke", stroke);
      series.dataProvider = dataProvider;
      return series;
    }
  }
}
