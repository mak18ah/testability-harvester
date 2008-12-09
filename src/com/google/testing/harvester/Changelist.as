// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class Changelist {

    public var cl:int;
    public var user:String;
    public var language:Language;
    public var date:Date;

    public var productionAdded:int;
    public var productionDeleted:int;
    public var productionChanged:int;

    public var testAdded:int;
    public var testDeleted:int;
    public var testChanged:int;

  }
}
