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
  import flash.events.Event;
  import flash.utils.Dictionary;
  
  import mx.collections.ArrayCollection;
  import mx.utils.StringUtil;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Set extends ArrayCollection {
    private var set:Dictionary = new Dictionary();
    
    public override function removeAll():void {
      set = new Dictionary();
      super.removeAll();
    }
    
    public override function addItem(item:Object):void {
      if (!contains(item)) {
        set[item] = true;
        var i:int = 0;
        for (; (i < length && item > super.getItemAt(i)); i++) {
        }
        super.addItemAt(item, i);
      }
    }
    
    public override function contains(item:Object):Boolean {
      return set[item];
    }
    
    public override function itemUpdated(item:Object, 
                         property:Object = null, 
                         oldValue:Object = null, 
                         newValue:Object = null):void {
      throw new Error("UnsuportedOperation");
    }
    
    public override function addItemAt(item:Object, index:int):void {
      throw new Error("UnsuportedOperation");
    }
    
    public override function setItemAt(item:Object, index:int):Object {
      throw new Error("UnsuportedOperation");
    }
    
    public override function removeItemAt(index:int):Object {
      throw new Error("UnsuportedOperation");
    }
    
    public override function getItemIndex(item:Object):int {
      throw new Error("UnsuportedOperation");
    }
    
    public function get asString():String {
      var txt:String = "";
      var sep:String = "";
      for each (var item:Object in source) {
        txt = txt + sep + item;
        sep = ", ";
      }
      return txt;
    }
    
    [Bindable("asStringChanged")]
    public function set asString(txt:String):void {
      set = new Dictionary();
      var array:Array = [];
      if (txt != null) {
        for each (var items:String in txt.split(",")) {
          for each (var item:String in items.split(";")) {
            item = StringUtil.trim(item);
            if (item != "") {
              set[item] = true;
              array.push(item);
            }
          }
        } 
        array.sort();
      }
      super.source = array;
      dispatchEvent(new Event("asStringChanged"));
    }
    
    public override function set source(array:Array):void {
      set = new Dictionary();
      var oldValue:String = asString;
      var myArray:Array = [];
      if (array != null) {
        for each (var item:Object in array) {
          set[item] = true;
          myArray.push(item);
        }
        myArray.sort();
      }
      super.source = myArray;
      dispatchEvent(new Event("asStringChanged"));
    }
    
    public function removeItem(item:Object):void {
      if (contains(item)) {
        super.removeItemAt(super.getItemIndex(item));
        delete set[item];
      }
    }
    
  }
}