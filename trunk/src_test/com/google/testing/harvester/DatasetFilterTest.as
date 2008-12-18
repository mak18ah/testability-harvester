// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flash.utils.Dictionary;
  
  import flexunit.framework.TestCase;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class DatasetFilterTest extends TestCase {
    
    private var filter:DatasetFilter = new DatasetFilter();
    
    public function testLanguage():void {
      var cl:Changelist = new Changelist();
      cl.language = Language.JAVA;
      cl.date = new Date();
      filter.startDate = cl.date;
      filter.endDate = cl.date;
      filter.unfilteredCLs.addItem(cl);
      filter.refresh();
      assertEquals(1, filter.filteredCLs.length);
      filter.language_Java = false;
      filter.refresh();
      assertEquals(0, filter.filteredCLs.length);      
    }
    
    public function testCLRange():void {
      var cl:Changelist = new Changelist();
      cl.language = Language.JAVA;
      cl.cl = 1;
      cl.date = new Date();
      filter.startDate = cl.date;
      filter.endDate = cl.date;
      filter.unfilteredCLs.addItem(cl);
      filter.startCL = 0;
      filter.endCL = 1;
      filter.refresh();
      assertEquals(1, filter.filteredCLs.length);

      filter.endCL = 0;
      filter.refresh();
      assertEquals(0, filter.filteredCLs.length);      
    }
    
    public function testDateRange():void {
      var cl:Changelist = new Changelist();
      cl.language = Language.JAVA;
      cl.date = new Date(1);

      filter.startDate = new Date(0);
      filter.endDate = new Date(1);
      filter.unfilteredCLs.addItem(cl);
      filter.refresh();
      assertEquals(1, filter.filteredCLs.length);

      filter.endDate = new Date(0);
      filter.refresh();
      assertEquals(0, filter.filteredCLs.length);      
    }
    
    public function testSkilCLs():void {
      var cl:Changelist = new Changelist();
      cl.language = Language.JAVA;
      cl.date = new Date(0);
      filter.startDate = new Date(0);
      filter.endDate = new Date(0);
      filter.unfilteredCLs.addItem(cl);

      filter.refresh();
      assertEquals(1, filter.filteredCLs.length);

      filter.skipCLs.addItem(0);
      filter.refresh();
      assertEquals(0, filter.filteredCLs.length);      
    }
    
    public function testDevelopersOnly():void {
      var cl:Changelist = new Changelist();
      cl.language = Language.JAVA;
      cl.date = new Date(0);
      cl.user = "misko";
      filter.startDate = new Date(0);
      filter.endDate = new Date(0);
      filter.selectedDevelopers.addItem("misko");
      filter.unfilteredCLs.addItem(cl);

      filter.refresh();
      assertEquals(1, filter.filteredCLs.length);

      filter.selectedDevelopers.removeItem("misko");
      filter.selectedDevelopers.addItem("X");
      filter.refresh();
      assertEquals(0, filter.filteredCLs.length);      
    }
    
 }
}