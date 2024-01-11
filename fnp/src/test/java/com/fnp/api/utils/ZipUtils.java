package com.fnp.api.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

public class ZipUtils {

	public void zipReportFile(String reportDirPath) throws IOException {

		String sourceFile = reportDirPath + "/extent-reports/Index.pdf";
		String targetFile = reportDirPath + "/extent-reports/report.zip";

		FileOutputStream fos = new FileOutputStream(targetFile);
		ZipOutputStream zipOut = new ZipOutputStream(fos);
		File fileToZip = new File(sourceFile);
		FileInputStream fis = new FileInputStream(fileToZip);
		ZipEntry zipEntry = new ZipEntry(fileToZip.getName());
		zipOut.putNextEntry(zipEntry);
		byte[] bytes = new byte[1024];
		int length;

		while ((length = fis.read(bytes)) >= 0) {
			zipOut.write(bytes, 0, length);
		}

		zipOut.close();
		fis.close();
		fos.close();

		System.out.println("ZIP file generated !");

	}

}
