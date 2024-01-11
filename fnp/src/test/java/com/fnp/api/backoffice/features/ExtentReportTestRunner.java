package com.fnp.api.backoffice.features;

import static org.junit.Assert.assertTrue;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.fnp.CustomExtentReport;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class ExtentReportTestRunner {

	static Results results = null;

	@BeforeClass
	public static void beforeClass() throws Exception {
		// before close code goes here
	}

	@Test
	public void testParallel() {
		results = Runner.path("classpath:com/fnp/api/backoffice/features/columbus").tags("@columbusRegression").parallel(1);
	}

	@AfterClass
	public static void afterClass() throws Exception {

		// Extent Report
		CustomExtentReport extentReport = new CustomExtentReport();
		extentReport.withKarateResult(results);
		extentReport.withReportDir(results.getReportDir() + "/extent-reports");
		extentReport.withReportTitle("Karate Test Extent Report");

		extentReport.generateExtentReport();

		assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
	}
}
