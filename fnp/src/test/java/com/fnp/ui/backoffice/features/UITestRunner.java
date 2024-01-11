package com.fnp.ui.backoffice.features;

import static org.junit.Assert.assertTrue;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import com.fnp.ReportGenerate;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

//@RunWith(Karate.class)
//@KarateOptions(features = "classpath:com/fnp/ui/backoffice/features/users/searchTest.feature")
public class UITestRunner {

	static Results results = null;

	@BeforeClass
	public static void beforeClass() throws Exception {

	}

	@Test
	public void testParallel() {
		results = Runner.path("classpath:com/fnp/ui/backoffice/features").tags("@smoke").parallel(1);
	}

	@AfterClass
	public static void afterClass() throws Exception {
		ReportGenerate.generateReport(results.getReportDir(), "Zeus UI");
		assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
	}

}
