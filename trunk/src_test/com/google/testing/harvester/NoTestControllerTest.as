package com.google.testing.harvester {
  import flexunit.framework.TestCase;

  public class NoTestControllerTest extends TestCase {
    private var controller:NoTestController = new NoTestController();
    
    public function testRefresh(): void {
      controller.clsToAverageOver = 3;
      controller.thresholdPercent = 50;
      
      var a1:Aggregate = new Aggregate();
      a1.production = 1;
      a1.test = 1; // ratio = 1 / (1 + 1) = 0.5
      
      var a2:Aggregate = new Aggregate();
      a2.production = 2;
      a2.test = 1; // ratio = 1 / (1 + 2) = 0.33
      
      var a3:Aggregate = new Aggregate();
      a3.production = 1;
      a3.test = 2; // ratio = 2 / (1 + 2) = 0.66
      
      var a4:Aggregate = new Aggregate();
      a4.production = 1;
      a4.test = 2; // ratio = 2 / (1 + 2) = 0.66
      
      controller.aggregates.addItem(a1);
      controller.aggregates.addItem(a2);
      controller.aggregates.addItem(a3);
      controller.aggregates.addItem(a4);
      
//      assertEquals(4, controller.chart.length);
//      assertEquals(100 * (1 / 1.0), controller.chart[0].percent);
//      assertEquals(100 * (1 / 2.0), controller.chart[1].percent);
//      assertEquals(100 * (2 / 3.0), controller.chart[2].percent);
//      assertEquals(100 * (2 / 3.0), controller.chart[3].percent);
    }
  }
}