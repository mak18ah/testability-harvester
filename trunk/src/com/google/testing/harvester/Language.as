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
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Language {
    
    public static const JAVA:Language = new Language("Java");
    public static const CPP:Language = new Language("C++");
    public static const PYTHON:Language = new Language("Python");
    public static const JAVA_SCRIPT:Language = new Language("JavaScript");
    public static const UNKNOWN:Language = new Language("Unknown");
    
    public static const ALL:Array = [JAVA, CPP, PYTHON, JAVA_SCRIPT];
    
    public var name:String;
    
    public function Language(name:String) {
      this.name = name;
    }
    
    public static function parse(name:String):Language {
      for each (var language:Language in ALL) {
        if (language.name == name) {
          return language;
        }
      }
      return UNKNOWN;
    }
    
    public function toString():String {
      return name;
    }

  }
}