package com.google.testing.harvester
{
	import flexunit.framework.TestCase;
	import flash.utils.getQualifiedClassName;
	
	public class ServerFactoryTest extends TestCase 
	{
		 public function testCreate():void {
		 	var server:Object = ServerFactory.create();
		 	assertEquals("com.google.testing.harvester::Server", getQualifiedClassName(server));
		 }
	}
}