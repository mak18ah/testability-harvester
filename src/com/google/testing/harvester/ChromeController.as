// Copyright 2008 Google, Inc. All Rights Reserved.
package com.google.testing.harvester {
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  
  /**
   * @author Misko Hevery <misko@google.com>
   */
  public class ChromeController {

    public const URL:String = "http://go/harvester-help";

    public function help():void {
      navigateToURL(new URLRequest(URL), "helpWindow");
    }

  }
}