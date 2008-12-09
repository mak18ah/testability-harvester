// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flexunit.framework.TestCase;
  
  import mx.collections.ArrayCollection;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DeveloperParetoControllerTest extends TestCase {
    
    private var controller:DeveloperParetoController 
                     = new DeveloperParetoController();
    
    public function testAggregate():void {
      var a1:Aggregate = new Aggregate();
      var a2:Aggregate = new Aggregate();
      var a3:Aggregate = new Aggregate();
      a1.user = "misko";
      a2.user = "misko";
      a3.user = "oksim";
      
      a3.production = 10;
      
      controller.aggregates = new ArrayCollection(); // force data binding
      controller.aggregates.addItem(a1);
      controller.aggregates.addItem(a2);
      controller.aggregates.addItem(a3);
      
      assertEquals(2, controller.developerAggregates.length);
      
      controller.showTopN = 1;
      controller.sort = controller.SIZE;
      
      assertEquals(1, controller.chart.length);
      assertEquals("oksim", controller.chart[0].user);
    }
    
  }
}