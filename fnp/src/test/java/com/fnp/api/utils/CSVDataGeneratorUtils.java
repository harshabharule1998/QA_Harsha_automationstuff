package com.fnp.api.utils;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;

public class CSVDataGeneratorUtils {

	private static final String URL_REDIRECT_CREATE_OUTPUT_CSV_FILE = "./url_redirect_create_data.csv";
	private static final String URL_REDIRECT_UPDATE_OUTPUT_CSV_FILE = "./url_redirect_update_data.csv";
	private static final String URL_REDIRECT_DELETE_OUTPUT_CSV_FILE = "./url_redirect_delete_data.csv";
	private static final String USER_EMAIL_CSV_FILE = "./emails.csv";

	public void generateURLRedirectCreateData() throws IOException {

		try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(URL_REDIRECT_CREATE_OUTPUT_CSV_FILE));

				CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("sourceUrl", "targetUrl",
						"entityType", "redirectType", "isEnabled", "comment", "Action"));) {

			for (int i = 1; i <= 1000; i++) {

				csvPrinter.printRecord("fnp.com/cup-cakes" + i, "fnp.com/gifts/mothers-day" + i, "CMS", "301", "TRUE",
						"CREATE-Feature comment", "create");
			}

			csvPrinter.flush();
			System.out.println("In try after csv write Url Redirect Create");
		}
		System.out.println("Outside try after csv write Url Redirect Create");
	}

	public void generateURLRedirectUpdateData() throws IOException {

		try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(URL_REDIRECT_UPDATE_OUTPUT_CSV_FILE));

				CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("urlId", "targetUrl",
						"redirectType", "isEnabled", "comment", "Action"));) {

			for (int i = 1; i <= 1000; i++) {

				csvPrinter.printRecord("92cb0902-9086-4f29-aad7-dc442cde86ca", "fnp.com/gifts/fathers-day" + i, "301",
						"TRUE", "UPDATE-Feature comment", "create");
			}

			csvPrinter.flush();
			System.out.println("In try after csv write Url Redirect Update");
		}
		System.out.println("Outside try after csv write Url Redirect Update");
	}

	public void generateURLRedirectDeleteData() throws IOException {

		try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(URL_REDIRECT_DELETE_OUTPUT_CSV_FILE));

				CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("urlId", "Action"));) {

			for (int i = 1; i <= 1000; i++) {

				csvPrinter.printRecord("92cb0902-2021-4f29-aad7-dc442cde86ca", "delete");
			}

			csvPrinter.flush();
			System.out.println("In try after csv write Url Redirect Delete");
		}
		System.out.println("Outside try after csv write Url Redirect Delete");
	}

	public void generateUserEmails() throws IOException {

		try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(USER_EMAIL_CSV_FILE));

				CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT.withHeader("email"));) {

			for (int i = 1; i <= 1000; i++) {

				csvPrinter.printRecord("perfuser" + i + "@fnp.com");
			}

			csvPrinter.flush();
			System.out.println("In try after csv write Url Redirect Delete");
		}
		System.out.println("Outside try after csv write Url Redirect Delete");
	}

}
