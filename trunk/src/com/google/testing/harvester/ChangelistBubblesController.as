// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.charts.HitData;
  import mx.charts.events.ChartItemEvent;
  import mx.collections.ArrayCollection;
  import mx.formatters.DateFormatter;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class ChangelistBubblesController {
    
    private var percentFormater:PercentFormatter = new PercentFormatter();
    private var dateFormater:DateFormatter = new DateFormatter();
    
    public function ChangelistBubblesController() {
      dateFormater.formatString = "M/D/YY";
      percentFormater.precision = 0;
    }

    /**
     * Format chart label as percent.
     */
    public function percentLabels(value:*, previous:*, axis:*):String { 
      return percentFormater.format(value);
    }
        
    /**
     * Data tip function for rendering hover tool tips.
     */
    public function dataTipFunction(hit:HitData):String {
      var label:String = 
         "<b>User: user</b><br>" +
         "Test Ratio: ratio<br>" +
         "CL Size: size<br>" +
         "Date: date<br>" + 
         "CLs: cls";
      var aggregate:Aggregate = hit.item as Aggregate;
      label = label.replace("user", aggregate.user);
      label = label.replace("cls", clsToString(aggregate.changelists));
      label = label.replace("ratio", percentFormater.format(aggregate.ratio));
      label = label.replace("size", aggregate.size);
      label = label.replace("date", dateFormater.format(aggregate.timestamp));
      return label;
    }

    /**
     * convert the list of changelists into human redable string.
     */
    private function clsToString(cls:ArrayCollection):String {
      var text:String = "";
      var sep:String = "";
      for each (var cl:Changelist in cls) {
        text += sep + cl.cl;
        sep = ", ";
      }
      return text;
    }
    
    public function onItemClick(event:ChartItemEvent):void {
      var aggregate:Aggregate = event.hitData.item as Aggregate;
      aggregate.changelists
    }
  }
}
