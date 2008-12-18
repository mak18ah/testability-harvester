// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flexunit.framework.TestCase;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class AggregateTest extends TestCase {

    public function testRatio():void {
      var a:Aggregate = new Aggregate();
      a.test = 1;
      a.production = 1;
      assertEquals(0.5, a.ratio);
    }

  }
}