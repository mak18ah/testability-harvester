package com.google.testing.harvester
{
	import flash.net.SharedObject;
	import flash.utils.getDefinitionByName;
	
	public class ServerFactory {
		
		public static var serverClassName:String = "com.google.testing.harvester.Server";
		
		public static function create():Server {
			var mock : MockServer = null;
			var serverType : Class = getDefinitionByName(serverClassName) as Class;
			var serverInstance : Server = new serverType() as Server;
			return serverInstance;
		}
	}
}