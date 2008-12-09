// Copyright 2008 Google, Inc. All Rights Reserved.
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
