require 'test/unit'
require 'funfx'

class TestProductOne < Test::Unit::TestCase

	def setup
	@ie = Funfx.instance
	@ie.start(true)
	@ie.speed = 1
	@ie.goto("http://localhost:9999/examples/Harvester_LocalServer.html", "Harvester_LocalServer")
	end

	def teardown
		@ie.unload
	end
	
	def test_data_source_list_should_not_empty_when_start
		assert_equal(2, @ie.list("datasourceList").numAutomationChildren)
	end
	
	def test_should_populate_data_info_after_select_datasource
		@ie.list("datasourceList").select(:itemRenderer => "0")
		
		assert_equal("Project1", @ie.label("projectNameLabel").text)
				
		assert_equal(@ie.label("beginDateLabel").text, @ie.dateField("beginDateField").text)
		assert_equal(@ie.label("endDateLabel").text, @ie.dateField("endDateField").text)
		
		
		assert_equal(@ie.textArea("startCLTextInput").text, @ie.label("firstCLLabel").text)
		assert_equal(@ie.textArea("endCLTextInput").text, @ie.label("lastCLLabel").text)
		
		assert_equal(@ie.label("clCountLabel")[0].text, @ie.label("clCountLabel")[1].text)
	end
		
end