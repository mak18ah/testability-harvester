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
	
	import mx.collections.ArrayCollection;
	
	public class ChangeListParserTest extends TestCase {
		
		private var changeListParser:ChangeListParser = null;
		
		public override function setUp():void {
			changeListParser = new ChangeListParser();
		} 
		/**
    	 * Test parsing of a single line of raw data file
 	     */ 
		public function testParseChange():void {
			var raw:Changelist = changeListParser.parseChange(
		        "6958308,kcoleman,Java,2008-04-16 00:00:00,null,1,2,3,4,5,6");
      assertEquals("6958308", raw.cl);
      assertEquals("kcoleman", raw.user);
      assertEquals(Language.JAVA, raw.language);
      assertEquals("Tue Apr 15 16:00:00 2008 UTC", raw.date.toUTCString());
      assertEquals(1, raw.productionAdded);
      assertEquals(2, raw.productionDeleted);
      assertEquals(3, raw.productionChanged);
      assertEquals(4, raw.testAdded);
      assertEquals(5, raw.testDeleted);
      assertEquals(6, raw.testChanged);
		}
	
    /**
     * Test that any blank lines get ignored.
     */ 
    public function testIgnoreBlankLinesBetweenNewlines():void {
      var cls:ArrayCollection = changeListParser.parseChangeLists("\n  \n\n\n");
      assertEquals(0, cls.length);
    } 
   
    /**
     * Test that any cariage return lines get ignored.
     */ 
    public function testIgnoreBlanklinesBetweenCarriageReturnNewline():void {
      var cls:ArrayCollection = changeListParser.parseChangeLists("\r\n  \r\n\r\n  \n\r");
      assertEquals(0, cls.length);
    } 
	}
}