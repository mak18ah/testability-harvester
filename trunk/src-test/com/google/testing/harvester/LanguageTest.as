// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flexunit.framework.TestCase;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class LanguageTest extends TestCase {
    
    public function testEnumerations():void {
      assertEquals(Language.JAVA, Language.parse("Java"));
      assertEquals(Language.CPP, Language.parse("C++"));
      assertEquals(Language.PYTHON, Language.parse("Python"));
      assertEquals(Language.JAVA_SCRIPT, Language.parse("JavaScript"));
      
      // unknown language
	  assertEquals(Language.UNKNOWN, Language.parse("X"));
    }
    
  }
}