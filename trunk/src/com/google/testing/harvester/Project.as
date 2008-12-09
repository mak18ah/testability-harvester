package com.google.testing.harvester {
  import mx.utils.ObjectUtil;
  
  [Bindable]
  public class Project {
    public var name:String;
    public var path:String;
    public var developers:String;
    
    public function toString():String {
      var keys:Array = [];
      for (var key:String in ObjectUtil.copy(this)) {
        keys.push(key);
      }
      keys.sort();
      var text:String = "";
      for each (key in keys) {
        text += key + ":" + encodeURI(this[key]) + "\n";
      }
      return text;
    }
  }
}