// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.formatters.NumberFormatter;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  public class RatioComputer {
    public var productionAdded:Boolean = true;
    public var productionChanged:Boolean = true;
    public var productionDeleted:Boolean = true;

    public var testAdded:Boolean = true;
    public var testChanged:Boolean = true;
    public var testDeleted:Boolean = true;
    
    private var percentFormat:NumberFormatter = new NumberFormatter();
    
    public function RatioComputer():void {
      percentFormat.precision = 1;
    }
    
    public function production(cl:Changelist, ignore:*=null):int {
      return (productionAdded ? cl.productionAdded : 0)
           + (productionChanged ? cl.productionChanged : 0)
           - (productionDeleted ? cl.productionDeleted : 0)
    }
    
    public function test(cl:Changelist, ignore:*=null):int {
      return (testAdded ? cl.testAdded : 0)
           + (testChanged ? cl.testChanged : 0)
           - (testDeleted ? cl.testDeleted : 0)
    }
    
    public function ratio(cl:Changelist, ignore:*=null):Number {
      var t:int = test(cl);
      var p:int = production(cl);
      return t == 0 ? 0 : t / (t + p);
    }
    
    public function total(cl:Changelist, ignore:*=null):int {
      return test(cl) + production(cl);
    }
    
    public function ratioPercent(cl:Changelist, ignore:*=null):String {
      return percentFormat.format(100 * ratio(cl)) + "%";
    }
    
  }
}