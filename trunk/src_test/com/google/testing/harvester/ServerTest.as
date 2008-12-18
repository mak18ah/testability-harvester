// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flexunit.framework.TestCase;
  
  import mx.collections.ArrayCollection;

  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class ServerTest extends TestCase {
    private var server:Server = new Server();
    
    public function testParseEmptyProjects():void {
      var projects:ArrayCollection = server.parseProjects("");
      assertEquals(0, projects.length);
    }
    
    public function testParseKindOfEmptyProjects():void {
      var projects:ArrayCollection = server.parseProjects("\n\r");
      assertEquals(projects.toString(), 0, projects.length);
    }
    
    public function testParseProject():void {
      var projects:ArrayCollection = server.parseProjects(
        "===\nname:A\npath:B\ndevelopers:C\n===\nname:D");
      assertEquals(projects.toString(), 2, projects.length);
      var project:Project = projects[0];
      assertEquals("A", project.name);
      assertEquals("B", project.path);
      assertEquals("C", project.developers);
      project = projects[1];
      assertEquals("D", project.name);
    }
    
    /**
     * Test parsing of a single line of raw data file
     */ 
    public function testParseLine():void {
      var raw:Changelist = server.parseChange(
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
      var cls:ArrayCollection = server.parseChangeLists("\n  \n\n\n");
      assertEquals(0, cls.length);
    } 
   
    /**
     * Test that any cariage return lines get ignored.
     */ 
    public function testIgnoreBlanklinesBetweenCarriageReturnNewline():void {
      var cls:ArrayCollection = server.parseChangeLists("\r\n  \r\n\r\n  \n\r");
      assertEquals(0, cls.length);
    } 
       
  }
}