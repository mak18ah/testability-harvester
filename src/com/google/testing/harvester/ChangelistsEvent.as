// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flash.events.Event;
  
  import mx.collections.ArrayCollection;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class ChangelistsEvent extends Event {
    
    public var changelists:ArrayCollection;
    
    public function ChangelistsEvent(changelists:ArrayCollection) {
      super("changelistsEvent");
      this.changelists = changelists;
    }

  }
}