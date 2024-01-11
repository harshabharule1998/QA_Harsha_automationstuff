package com.fnp.api.utils;

import java.io.IOException;

public class DataGeneratorUtils {

	public static void main(String[] args) throws IOException {

		CSVDataGeneratorUtils csvDataGenerator = new CSVDataGeneratorUtils();
		// csvDataGenerator.generateURLRedirectCreateData();
		// csvDataGenerator.generateURLRedirectUpdateData();
		// csvDataGenerator.generateURLRedirectDeleteData();
		csvDataGenerator.generateUserEmails();

		JSONDataGeneratorUtils jsonDataGenerator = new JSONDataGeneratorUtils();
		// jsonDataGenerator.generateWebtoolsJSONFile();

		XMLDataGeneratorUtils xmlDataGenerator = new XMLDataGeneratorUtils();
		// xmlDataGenerator.generateURLRedirectCreateXML();
		// xmlDataGenerator.generateURLRedirectUpdateXML();
		// xmlDataGenerator.generateURLRedirectDeleteXML();

	}

}
