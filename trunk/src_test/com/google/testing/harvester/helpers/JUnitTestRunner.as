package com.google.testing.harvester.helpers
{
	import flash.events.DataEvent;
	import flash.net.XMLSocket;
	import flash.utils.describeType;
	
	import flexunit.framework.Test;
	import flexunit.framework.TestListener;
	import flexunit.framework.TestResult;
	
	import mx.collections.ArrayCollection;
	import flexunit.framework.AssertionFailedError;
	import flash.system.Security;
	import flash.events.Event;
	import flash.errors.IOError;

	/**
	 * This class is intended as a test runner that mimics the JUnit task found
	 * in Ant. It is also intended to be run from an Ant task - please see the
	 * FlexUnitTask.
	 * 
	 * The output from the test run is an XML file per Test, which is formatted
	 * as per the XML formatter in the JUnit task, this allows a report to
	 * be generated using the JUnitReport task.
	 * 
	 * Communicate between this test runner and the controlling Ant task is done
	 * using a XMLSocket.
	 */
	public class JUnitTestRunner implements TestListener
	{
		private static const END_OF_TEST_RUN : String = "<endOfTestRun/>";
		private static const END_OF_TEST_ACK : String ="<endOfTestRunAck/>";
		
		[Inspectable]
		public var port : uint = 1024;
		
		[Inspectable]
		public var server : String = "127.0.0.1";
		
		[Bindable]
		public var status : String = "";
		
		private var reports : Object = new Object();
		private var result : TestResult = new TestResult();
		private var testsComplete : Function;
		private var totalTestCount : int;
    	private var numTestsRun : int = 0;
    	private var socket : XMLSocket;
		
		/**
		 * Run the Test.
		 * @param test the Test to run.
		 * @param onComplete the Function to call when the test run is complete.
		 * @return the TestResult.
		 */
		public function run( test : Test, onComplete : Function = null ) : TestResult
    	{
    		var result : TestResult = new TestResult();
	        result.addListener(TestListener( this ));

    	    //startTime = getTimer();
    	    testsComplete = onComplete;
        	 totalTestCount = test.countTestCases();
	        
    	    test.runWithResult( result );
    	    
        	return result;
		}
    	
    	/**
    	 * Called when a Test starts.
    	 * @param Test the test.
    	 */
    	public function startTest( test : Test ) : void
		{
			addMethod( test );
		}
		
		/**
		 * Called when a Test ends.
		 * @param Test the test.
		 */
		public function endTest( test : Test ) : void
		{	
			// If we have finished running all the tests send the results.
			if ( ++numTestsRun == totalTestCount )
			{
				sendResults();
   			}
		}
	
		/**
		 * Called when an error occurs.
		 * @param test the Test that generated the error.
		 * @param error the Error.
		 */
		public function addError( test : Test, error : Error ) : void
		{
			// Increment error count.
			var report : Object = getReport( test );
			report.errors++;
			
			// Add the error to the method.
			var methodObject : Object = getMethod( test );
			
			var errorObject : Object = new Object();
			methodObject.error = errorObject;

			errorObject.type = getClassName( error );
			errorObject.message = error.message;
		}

		/**
		 * Called when a failure occurs.
		 * @param test the Test that generated the failure.
		 * @param error the failure.
		 */
		public function addFailure( test : Test, error : AssertionFailedError ) : void
		{
			// Increment failure count.
			var report : Object = getReport( test );
			report.failures++;
			
			// Add the failure to the method.
			var methodObject : Object = getMethod( test );
			
			var failureObject : Object = new Object();
			methodObject.failure = failureObject;

			failureObject.type = getClassName( error );
			failureObject.message = error.message;
		}
		
		/**
		 * Return the fully qualified class name for an Object.
		 * @param obj the Object.
		 * @return the class name.
		 */
		private function getClassName( obj : Object ) : String
		{
			var description : XML = describeType( obj );
			var className : Object = description.@name;
			
			return className[ 0 ];
		}
		
		/**
		 * Return the method Object from the internal report model for the
		 * currently executing method on a Test.
		 * @param test the Test.
		 * @return the method Object.
		 */
		private function getMethod( test : Test ) : Object
		{
			var reportObject : Object = getReport( test );
			var methodsObject : Object = reportObject.methods;
			
			var methodName : String = test[ "methodName" ];
			
			return methodsObject[ methodName ];
		}
		
		/**
		 * Add the currently executing method on a Test to the internal report
		 * model.
		 * @param test the Test.
		 */
		private function addMethod( test : Test ) : void
		{
			var reportObject : Object = getReport( test );
			reportObject.tests++;
			
			var methodName : String = test[ "methodName" ];
			var methodsObject : Object = reportObject.methods;
			
			var methodObject : Object = new Object();
			methodsObject[ methodName ] = methodObject;

			methodObject.classname = test.className;
			methodObject.name = methodName;
			methodObject.time = 0.0;
		}
		
		/**
		 * Return the report Object from the internal report model for the
		 * currently executing Test.
		 * @param Test the test.
		 */
		private function getReport( test : Test ) : Object
		{
			var reportObject : Object;
			var className : String = test.className;
			
			// Check we have a report Object for the executing Test, if not
			// create a new one.
			if ( reports[ className ] )
			{
				reportObject = reports[ className ];
			}
			else
			{
				reportObject = new Object();
				reportObject.name = className;
				reportObject.errors = 0;
				reportObject.failures = 0;
				reportObject.tests = 0;
				reportObject.time = 0.0;
				reportObject.methods = new Object();
				
				reports[ className ] = reportObject;
			}
			
			return reportObject;
		}
		
		private function formatQualifiedClassName( className : String ) : String
		{
			var pattern : RegExp = /::/;
			
			return className.replace( pattern, "." );
		}
		
		/**
		 * Sends the results. This sends the reports back to the controlling Ant
		 * task using an XMLSocket.
		 */
		private function sendResults() : void
		{
			// Open an XML socket.
			socket = new XMLSocket();
			socket.addEventListener( Event.CONNECT, handleConnect );
			socket.addEventListener( DataEvent.DATA, dataHandler );
   	   socket.connect( server, port );
		}
		
		private function handleConnect( event : Event ) : void
		{
			for ( var className : String in reports )
			{
				// Create the XML report.
				var xml : XML = createXMLReport( reports[ className ] );
				
				// Send the XML report.
				socket.send( xml.toXMLString() );
			}
			
			// Send the end of reports terminator.
			socket.send( END_OF_TEST_RUN );
		}
		
		/**
		 * Create the XML report.
		 * @param obj the report Object.
		 * @return the XML report.
		 */
		private function createXMLReport( obj : Object ) : XML
		{
			// Create the test suite element.
			var testSuite : XML = createTestSuite( obj );
				
			// Create the test case elements.					
			var methodsObject : Object = obj.methods;
			for ( var methodName : String in methodsObject )
			{
				var methodObject : Object = methodsObject[ methodName ];
				var testCase : XML = createTestCase( methodObject );
						
				// Create the failure element.
				if ( methodObject.failure )
				{
					var failureObject : Object = methodObject.failure;			
					var failure : XML = createFailure( failureObject );
							
					testCase = testCase.appendChild( failure );									
				}
					
				// Create the error element.
				if ( methodObject.error )
				{
					var errorObject : Object = methodObject.error;
					var error : XML = createError( errorObject );
							
					testCase = testCase.appendChild( error );									
				}					
							
				testSuite = testSuite.appendChild( testCase );
			}
			
			return testSuite;
		}
		
		/**
		 * Create the test suite XML.
		 * @return the XML.
		 */ 
		private function createTestSuite( obj : Object ) : XML
		{
			var name : String = obj.name;
			var errors : uint = obj.errors;
			var failures : uint = obj.failures;
			var tests : uint = obj.tests;
			var time : Number = obj.time;
			var methods : Object = obj.methods;
				
			var xml : XML =
				<testsuite
					errors={ errors }
					failures={ failures }
					name={ formatQualifiedClassName( name ) }
					tests={ tests }
					time={ time } />;
			
			return xml;
		}
		
		/**
		 * Create the test case XML.
		 * @return the XML.
		 */
		private function createTestCase( obj : Object ) : XML
		{
			var classname : String = obj.classname;
			var name : String = obj.name;
			var time : Number = obj.time;
					
			var xml : XML =
				<testcase
					classname={ formatQualifiedClassName( classname ) }
					name={ name }
					time={ time } />;
					
			return xml;
		}
		
		/**
		 * Create the failure XML.
		 * @return the XML.
		 */
		private function createFailure( obj : Object ) : XML
		{
			var type : String = obj.type;
			var message : String = obj.message;
					
			var xml : XML =
				<failure type={ formatQualifiedClassName( type ) }>
					{ message }
				</failure>;
					
			return xml;
		}
		
		/**
		 * Create the test error XML.
		 * @return the XML.
		 */
		private function createError( obj : Object ) : XML
		{
			var type : String = obj.type;
			var message : String = obj.message;
					
			var xml : XML =
				<error type={ formatQualifiedClassName( type ) }>
					{ message }
				</error>;
					
			return xml;
		}
		
		/**
		 * Event listener to handle data received on the socket.
		 * @param event the DataEvent.
		 */
		private function dataHandler( event : DataEvent ) : void
		{
			var data : String = event.data;

			// If we received an acknowledgement finish-up.			
			if ( data == END_OF_TEST_ACK )
			{
				exit();
   		}
		}
		
		/**
		 * Exit the test runner and close the player.
		 */
		private function exit() : void
		{
			// Close the socket.
			socket.close();
				
			// Execute the user's test complete function.
			if( testsComplete != null )
        	{
  	    	   testsComplete();
        	}
		}
	}
}