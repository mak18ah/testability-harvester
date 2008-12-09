// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.charts.renderers.CircleItemRenderer;
  import mx.charts.series.items.BubbleSeriesItem;
  import mx.graphics.SolidColor;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class UserBubbleRenderer extends CircleItemRenderer {

    override protected function updateDisplayList(width:Number,
                        height:Number):void {
      var item:BubbleSeriesItem = data as BubbleSeriesItem;
      var aggregate:Aggregate = item.item as Aggregate;
      item.fill = new SolidColor(aggregate.color, 0.5);
      super.updateDisplayList(width, height);
    }
  }
}