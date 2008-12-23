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