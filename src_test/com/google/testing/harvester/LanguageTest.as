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