// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Language {
    
    public static const JAVA:Language = new Language("Java");
    public static const CPP:Language = new Language("C++");
    public static const PYTHON:Language = new Language("Python");
    public static const JAVA_SCRIPT:Language = new Language("JavaScript");
    
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
      throw new Error("Unknown language: " + name);
    }
    
    public function toString():String {
      return name;
    }

  }
}