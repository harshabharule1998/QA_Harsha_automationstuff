package com.fnp.ui.common;

import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;

import com.opencsv.CSVReader;

public class UrlStatusGeneratorUtils {

	String outputFileName = "status";

	public UrlStatusGeneratorUtils(String outputFileName) {
		this.outputFileName = "./" + outputFileName + ".csv";
	}

	public void generateURLStatusData(String url, String status) throws IOException {

		OpenOption[] options = { StandardOpenOption.CREATE, StandardOpenOption.APPEND };

		try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(outputFileName), StandardCharsets.UTF_8,
				options);

				CSVPrinter csvPrinter = new CSVPrinter(writer, CSVFormat.DEFAULT);) {

			csvPrinter.printRecord(url, status);
			csvPrinter.flush();
			System.out.println("In try after csv write Url Status");
		}
		System.out.println("Outside try after csv write Url Status");
	}

	public List<String[]> readCSV(String name) throws IOException {

		String filename = name + ".csv";
		Reader reader = new FileReader(filename);
		CSVReader csvReader = new CSVReader(reader);
		List<String[]> list = new ArrayList<>();
		list = csvReader.readAll();
		reader.close();
		csvReader.close();
		System.out.println("List : " + list.spliterator());
		return list;
	}

}
