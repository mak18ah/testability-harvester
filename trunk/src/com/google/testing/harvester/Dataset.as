// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.collections.ArrayCollection;
  import mx.collections.Sort;
  import mx.collections.SortField;
  import mx.events.CollectionEvent;
  
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  [Bindable]
  public class Dataset {
    
    public var changelists:ArrayCollection = new ArrayCollection();
    public var first:*;
    public var last:*;

    public function Dataset() {
      changelists.sort = new Sort();
      changelists.sort.fields = [ new SortField("cl", false, false, true) ];
      
      changelists.addEventListener(
          CollectionEvent.COLLECTION_CHANGE,
          changelistsChanged)
    }
    
    private function changelistsChanged(event:CollectionEvent):void {
      changelists.removeEventListener(
          CollectionEvent.COLLECTION_CHANGE,
          changelistsChanged)

      // Refresh causes the changelist to fire a change event.
      // we remove and readd the listener to prevent infinite recursion.
      changelists.refresh();

      first = changelists.length == 0 ? null : changelists[0];
      last = changelists.length == 0 ? null : changelists[changelists.length - 1];

      changelists.addEventListener(
          CollectionEvent.COLLECTION_CHANGE,
          changelistsChanged)
    }

  }
}