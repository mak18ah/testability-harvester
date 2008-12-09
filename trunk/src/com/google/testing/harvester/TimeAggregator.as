// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class TimeAggregator {
    
    public static function NONE(time:Date):Date {
      return time;
    };
    public static function DAY(time:Date):Date {
      return new Date(time.fullYear, time.month, time.date);
    };
    public static function WEEK(time:Date):Date {
      return new Date(time.fullYear, time.month, time.date - time.day);
    };
    public static function MONTH(time:Date):Date {
      return new Date(time.fullYear, time.month, 1);
    };    
    public static function YEAR(time:Date):Date {
      return new Date(time.fullYear, 0, 1);
    };
    public static function EVERYTHING(time:Date):Date {
      return new Date(0);
    };
    
  }
}