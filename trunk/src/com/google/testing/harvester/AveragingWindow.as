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
  
  /**
   * Computes the average (mean) over the N-most-recent values in a series.
   * 
   * N is the window size passed to the constructor.
   *  
   * @author Nicholas Behrens (nbehrens@google.com)
   */
  public class AveragingWindow {

    private var values:Array;
    private var weights:Array;
    private var valueSum:Number = 0;
    private var weightSum:Number = 0;
    private var index:int = 0;
    public var internalAdd:Function = fillAdd;
    
    public function AveragingWindow(windowSize:int) {
      this.values = new Array(windowSize);
      this.weights = new Array(windowSize);
    }
    
    public function get average(): Number {
      return weightSum == 0 ? 0 : valueSum / weightSum;
    }
    
    public function add(value:Number, weight:Number): void {
      internalAdd(value, weight);
    }
    
    private function fillAdd(value:Number, weight:Number): void {
      values[index] = value * weight;
      weights[index] = weight;
      
      valueSum += value * weight;
      weightSum += weight;

      index ++;
      if (index == values.length) {
        internalAdd = fullAdd;
        index = 0;
      }
    }
    
    private function fullAdd(value:Number, weight:Number): void {
      valueSum -= values[index];
      weightSum -= weights[index];

      values[index] = value * weight;
      weights[index] = weight;

      valueSum += value * weight;
      weightSum += weight;
      
      index ++;
      if (index == values.length) {
        index = 0;
      }
    }
    
  }
}
