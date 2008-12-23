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
  
  import flexunit.framework.TestCase;
  
  import mx.events.PropertyChangeEvent;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DatasetTest extends TestCase {
    public function testFirst():void {
      var dataset:Dataset = new Dataset();
      assertNull(dataset.first);
      
      dataset.changelists.addItem({cl:2});
      dataset.changelists.addItem({cl:1});
      
      assertEquals(1, dataset.first.cl);
    }

    public function testLast():void {
      var dataset:Dataset = new Dataset();
      assertNull(dataset.last);
      
      dataset.changelists.addItem({cl:2});
      dataset.changelists.addItem({cl:1});
            
      assertEquals(2, dataset.last.cl);
    }
    
    public function testFirstEventFires(): void {
      var eventFirstFired:int = 0;
      var eventLastFired:int = 0;
      var dataset:Dataset = new Dataset();
      (IEventDispatcher(dataset)).addEventListener(
          PropertyChangeEvent.PROPERTY_CHANGE,
          function (event:PropertyChangeEvent):void {
            if (event.property == "first") {
              eventFirstFired++;
            }
            if (event.property == "last") {
              eventLastFired++;
            }
          }
        );
      dataset.changelists.addItem({cl:2}); // +1
      dataset.changelists.source = [];     // +1

      assertEquals(2, eventFirstFired);      
      assertEquals(2, eventLastFired);      
    }
    
  }
}