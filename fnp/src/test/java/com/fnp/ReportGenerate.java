package com.fnp;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.commons.io.FileUtils;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class ReportGenerate {

	public static void generateReport(String karateOutputPath, String reportType) {

		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		System.out.println("JSON FILES : " + jsonPaths);
		Configuration config = new Configuration(new File("target"), reportType);
		config.addClassifications("Platform", "Windows 8.1");
		config.addClassifications("Browser", "Chrome");
		config.addClassifications("Branch", "release/1.0");

		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}

}
