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

  public class NoTestControllerTest extends TestCase {
    private var controller:NoTestController = new NoTestController();
    
    public function testRefresh(): void {
      controller.clsToAverageOver = 3;
      controller.thresholdPercent = 50;
      
      var a1:Aggregate = new Aggregate();
      a1.production = 1;
      a1.test = 1; // ratio = 1 / (1 + 1) = 0.5
      
      var a2:Aggregate = new Aggregate();
      a2.production = 2;
      a2.test = 1; // ratio = 1 / (1 + 2) = 0.33
      
      var a3:Aggregate = new Aggregate();
      a3.production = 1;
      a3.test = 2; // ratio = 2 / (1 + 2) = 0.66
      
      var a4:Aggregate = new Aggregate();
      a4.production = 1;
      a4.test = 2; // ratio = 2 / (1 + 2) = 0.66
      
      controller.aggregates.addItem(a1);
      controller.aggregates.addItem(a2);
      controller.aggregates.addItem(a3);
      controller.aggregates.addItem(a4);
      
//      assertEquals(4, controller.chart.length);
//      assertEquals(100 * (1 / 1.0), controller.chart[0].percent);
//      assertEquals(100 * (1 / 2.0), controller.chart[1].percent);
//      assertEquals(100 * (2 / 3.0), controller.chart[2].percent);
//      assertEquals(100 * (2 / 3.0), controller.chart[3].percent);
    }
  }
}