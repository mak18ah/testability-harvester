/*
 * Copyright 2008 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */
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