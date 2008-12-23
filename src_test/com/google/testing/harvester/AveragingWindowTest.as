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

  public class AveragingWindowTest extends TestCase {
    
    public function testAverageOfNoElementsIsZero(): void {
      var window:AveragingWindow = new AveragingWindow(3);
      assertEquals(0, window.average);
    }
    
    public function testAverageOfOneElementIsThatElement(): void {
      var window:AveragingWindow = new AveragingWindow(3);
      window.add(123, 1);
      assertEquals(123, window.average);
    }
    
    public function testAveragesOfMultipleElementsWithinWindow(): void {
      var window:AveragingWindow = new AveragingWindow(3);
      window.add(1, 1);
      window.add(3, 1);
      assertEquals(2, window.average); // (3 + 1 = 4) / 2 elements = 2
      
      window.add(5, 1);
      assertEquals(3, window.average); // (5 + 3 + 1 = 9) / 3 elements = 3
    }
    
    public function testAveragesOfMultipleElementsExceedingWindow(): void {
      var window:AveragingWindow = new AveragingWindow(3);
      window.add(1, 1);
      window.add(3, 1);
      window.add(5, 1);
      window.add(7, 1);  // 1 gets kicked out
      assertEquals(5, window.average); // (7 + 5 + 3 = 15) / 3 elements = 5
      
      window.add(0, 1);  // 3 gets kicked out
      assertEquals(4, window.average); // (0 + 7 + 5 = 12) / 3 elements = 4
    }
    
    public function testSuperLargeWindow(): void {
      var window:AveragingWindow = new AveragingWindow(100);
      window.add(1, 1); assertEquals(1/1, window.average);
      window.add(0, 1); assertEquals(1/2, window.average);
      window.add(1, 1); assertEquals(2/3, window.average);
      window.add(0, 1); assertEquals(2/4, window.average);
      window.add(0, 1); assertEquals(2/5, window.average);
      window.add(0, 1); assertEquals(2/6, window.average);
      window.add(0, 1); assertEquals(2/7, window.average);
      window.add(0, 1); assertEquals(2/8, window.average);
      window.add(0, 1); assertEquals(2/9, window.average);
      window.add(1, 1); assertEquals(3/10, window.average);
      window.add(0, 1); assertEquals(3/11, window.average);
      window.add(1, 1); assertEquals(4/12, window.average);
    }
    
    public function testAverageDifferentWeights():void {
      var window:AveragingWindow = new AveragingWindow(2);
      window.add(1, 2); assertEquals(1*2/2, window.average);
      window.add(3, 4); assertEquals((3*4+1*2)/(4+2), window.average);
      window.add(5, 6); assertEquals((5*6+3*4)/(6+4), window.average);
      window.add(7, 8); assertEquals((7*8+5*6)/(8+6), window.average);
      window.add(9, 0); assertEquals((9*0+7*8)/(0+8), window.average);
    }
  }
}