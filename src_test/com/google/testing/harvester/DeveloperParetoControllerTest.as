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
  import flexunit.framework.TestCase;
  
  import mx.collections.ArrayCollection;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DeveloperParetoControllerTest extends TestCase {
    
    private var controller:DeveloperParetoController 
                     = new DeveloperParetoController();
    
    public function testAggregate():void {
      var a1:Aggregate = new Aggregate();
      var a2:Aggregate = new Aggregate();
      var a3:Aggregate = new Aggregate();
      a1.user = "misko";
      a2.user = "misko";
      a3.user = "oksim";
      
      a3.production = 10;
      
      controller.aggregates = new ArrayCollection(); // force data binding
      controller.aggregates.addItem(a1);
      controller.aggregates.addItem(a2);
      controller.aggregates.addItem(a3);
      
      assertEquals(2, controller.developerAggregates.length);
      
      controller.showTopN = 1;
      controller.sort = controller.SIZE;
      
      assertEquals(1, controller.chart.length);
      assertEquals("oksim", controller.chart[0].user);
    }
    
  }
}