// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.formatters.DateFormatter;
  import mx.formatters.NumberFormatter;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DataController {

    public function time(aggregate:Aggregate):Number {
      return aggregate.timestamp.time;
    }
    
  }
}