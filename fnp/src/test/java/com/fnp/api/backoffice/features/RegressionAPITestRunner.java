package com.fnp.api.backoffice.features;

import static org.junit.Assert.assertTrue;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.fnp.CustomExtentReport;
import com.fnp.ReportGenerate;
import com.fnp.api.utils.ZipUtils;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

public class RegressionAPITestRunner {

	static Results results = null;

	@BeforeClass
	public static void beforeClass() throws Exception {
		// before close code goes here
	}

	@Test
	public void testParallel() {
		results = Runner.path("classpath:com/fnp/api/backoffice/features").tags("@Regression").parallel(1);
	}

	@AfterClass
	public static void afterClass() throws Exception {

		ReportGenerate.generateReport(results.getReportDir(), "Phase-1 API Regression");

		// Extent Report
		CustomExtentReport extentReport = new CustomExtentReport();
		extentReport.withKarateResult(results);
		extentReport.withReportDir(results.getReportDir() + "/extent-reports");
		extentReport.withReportTitle("Phase-1 API Regression Report");

		extentReport.generateExtentReport();

		ZipUtils zipUtil = new ZipUtils();
		zipUtil.zipReportFile(results.getReportDir());

		assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
	}
}
