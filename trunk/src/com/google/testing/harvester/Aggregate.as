// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import mx.collections.ArrayCollection;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Aggregate {

    public var changelists:ArrayCollection = new ArrayCollection();
    public var timestamp:Date;
    public var user:String;
    public var production:int = 0;
    public var test:int = 0;
    
    public function get ratio():Number {
      return (test) / (test + production);
    }
    
    public function get size():Number {
      return Number(production + test);
    }
    
    public function get sqrtSize():Number {
      return Math.sqrt(size);
    }
    
    public function addChangelist(cl:Changelist, computer:RatioComputer):void {
      changelists.addItem(cl);
      production += computer.production(cl);
      test += computer.test(cl);
    }
    
    public function get color():uint {
      var color:uint = 0;
      for (var i:int = 0; i < user.length; i++) {
          color = (((31 * color) >> 0) + user.charCodeAt(i)) >> 0;
      }
      return color;
    }
    
    public function merge(other:Aggregate):void {
      production += other.production;
      test += other.test;
      for each (var otherCl:Changelist in other.changelists) {
        changelists.addItem(otherCl);
      }
    }
  }
}
