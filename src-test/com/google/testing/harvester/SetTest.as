// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flexunit.framework.TestCase;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class SetTest extends TestCase {
    
    private var set:Set = new Set();
    
    public function testNewMapIsEmpty():void {
      assertEquals(0, set.length);
    }
    
    public function testAddToSetUpdatesMap():void {
      set.addItem("A");
      set.addItem("A");
      assertTrue(set.contains("A"));
      assertFalse(set.contains("B"));
      assertEquals(1, set.length);
      assertEquals("A", set.getItemAt(0));
    }
    
    public function testArrayAlwaysSorted():void {
      set.addItem("B");
      set.addItem("A");
      assertEquals("A", set.getItemAt(0));
      assertEquals("B", set.getItemAt(1));
    }
    
    public function testToString():void {
      set.addItem("B");
      set.addItem("A");
      assertEquals("A, B", set.asString);
    }
    
    public function testAsStringAssignment():void {
      set.addItem("X"); // existing items need to be removed.
      set.asString = "B ,  , A ; C  ";
      assertTrue(set.contains("A"));
      assertTrue(set.contains("B"));
      assertTrue(set.contains("C"));
      assertEquals("A, B, C", set.asString);
    }
    
  }
}