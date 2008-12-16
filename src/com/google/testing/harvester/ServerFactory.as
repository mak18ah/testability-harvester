package com.google.testing.harvester
{
	import flash.utils.getDefinitionByName;
	
	public class ServerFactory {
		
		public static var serverClassName:String = "com.google.testing.harvester.Server";
		
		public static function create():Server {
			var serverType : Class = getDefinitionByName(serverClassName) as Class;
			return new serverType() as Server;
		}
	}
}