// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.formatters.DateFormatter;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DatetimeFormatter extends DateFormatter {
    public function DatetimeFormatter() {
      formatString = "YYYY/MM/DD LL:NNA EEEE";
    }
    
    public function forField(field:String):Function {
      return function (value:Object, ignore:*):String {
          return format(value[field]);
        };
    }
  }
}