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

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DatasetAggregateTest extends TestCase {
    
    private var dataset:DatasetAggregate = new DatasetAggregate();
    
    public function testAggregateDay():void {
      dataset.timeAggregator = TimeAggregator.DAY;
      
      var cl1:Changelist = new Changelist();
      cl1.cl = 1;
      cl1.productionAdded = 1;
      cl1.testAdded = 2;
      cl1.user = "misko";
      cl1.date = new Date(2008, 1, 1, 1);
      
      var cl2:Changelist = new Changelist();
      cl2.cl = 2;
      cl2.productionAdded = 1;
      cl2.testAdded = 2;
      cl2.user = "misko";
      cl2.date = new Date(2008, 1, 1, 5);
      
      var cl3:Changelist = new Changelist();
      cl3.cl = 3;
      cl3.productionAdded = 1;
      cl3.testAdded = 2;
      cl3.user = "misko";
      cl3.date = new Date(2008, 1, 2, 1);
      
      dataset.changelists.addItem(cl1);
      dataset.changelists.addItem(cl2);
      dataset.changelists.addItem(cl3);
      
      assertEquals(2, dataset.aggregates.length);
      assertEquals(4, dataset.aggregates[0].test);
      assertEquals(2, dataset.aggregates[0].production);

      assertEquals(2, dataset.aggregates[1].test);
      assertEquals(1, dataset.aggregates[1].production);
    }
    
  }
}