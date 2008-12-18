package
{
    import flexunit.framework.*;
    import com.google.testing.harvester.AggregateTest;
    import com.google.testing.harvester.AveragingWindowTest;
    import com.google.testing.harvester.DatasetAggregateTest;
    import com.google.testing.harvester.DatasetFilterTest;
    import com.google.testing.harvester.DatasetTest;
    import com.google.testing.harvester.DeveloperParetoControllerTest;
    import com.google.testing.harvester.LanguageTest;
    import com.google.testing.harvester.NoTestControllerTest;
    import com.google.testing.harvester.ProjectEditControllerTest;
    import com.google.testing.harvester.ProjectTest;
    import com.google.testing.harvester.ServerFactoryTest;
    import com.google.testing.harvester.ServerTest;
    import com.google.testing.harvester.SetTest;

    public class FlexUnitAllTests 
    {
        public static function suite() : TestSuite
        {
            var testSuite:TestSuite = new TestSuite();
            testSuite.addTestSuite(com.google.testing.harvester.AggregateTest);
            testSuite.addTestSuite(com.google.testing.harvester.AveragingWindowTest);
            testSuite.addTestSuite(com.google.testing.harvester.DatasetAggregateTest);
            testSuite.addTestSuite(com.google.testing.harvester.DatasetFilterTest);
            testSuite.addTestSuite(com.google.testing.harvester.DatasetTest);
            testSuite.addTestSuite(com.google.testing.harvester.DeveloperParetoControllerTest);
            testSuite.addTestSuite(com.google.testing.harvester.LanguageTest);
            testSuite.addTestSuite(com.google.testing.harvester.NoTestControllerTest);
            testSuite.addTestSuite(com.google.testing.harvester.ProjectEditControllerTest);
            testSuite.addTestSuite(com.google.testing.harvester.ProjectTest);
            testSuite.addTestSuite(com.google.testing.harvester.ServerFactoryTest);
            testSuite.addTestSuite(com.google.testing.harvester.ServerTest);
            testSuite.addTestSuite(com.google.testing.harvester.SetTest);
            return testSuite;
        }
    }
}
