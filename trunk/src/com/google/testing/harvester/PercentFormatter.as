// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.formatters.NumberFormatter;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class PercentFormatter extends NumberFormatter {
    public function PercentFormatter() {
      super();
      precision = 1;
    }
    
    public override function format(value:Object):String {
      return super.format(100 * Number(value)) + "%";
    }
    
    public function forField(field:String):Function {
      return function (value:Object, ignore:*):String {
          return format(value[field]);
        };
    }
    
  }
}