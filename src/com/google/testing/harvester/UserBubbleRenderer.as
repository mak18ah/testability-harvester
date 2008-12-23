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