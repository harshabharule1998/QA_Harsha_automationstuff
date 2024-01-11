package com.fnp.api.backoffice.features;
 
import static org.junit.Assert.assertTrue;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.fnp.ReportGenerate;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class SmokeTestRunner {

	static Results results = null;

	@BeforeClass
	public static void beforeClass() throws Exception {
		// before close code goes here
	}

	@Test
	public void testParallel() {
		results = Runner.path("classpath:com/fnp/api/backoffice/features").tags("@smoke").parallel(1);
	}

	// @Test
	public void testPerformanceData() {
		for (int i = 1; i <= 1; i++) {
			results = Runner.path("classpath:com/fnp/api/backoffice/features").tags("@performanceData1").parallel(1);
		}
	}

	@AfterClass
	public static void afterClass() throws Exception {
		ReportGenerate.generateReport(results.getReportDir(), "Smoke Test");
		assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
	}
}
