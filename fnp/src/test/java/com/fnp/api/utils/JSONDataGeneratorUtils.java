package com.fnp.api.utils;

import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JSONDataGeneratorUtils {

	@SuppressWarnings("unchecked")
	public void generateWebtoolsJSONFile() {

		JSONObject webtoolData = null;
		JSONArray webtoolDataList = new JSONArray();

		// Add webtools data to list
		for (int i = 1; i <= 1000; i++) {

			webtoolData = new JSONObject();
			webtoolData.put("id", i);
			webtoolData.put("product_name", "mysql_" + i);
			webtoolData.put("price", i + 100);
			webtoolData.put("image_url", "img_url_" + i);

			// add json object to json array
			webtoolDataList.add(webtoolData);

			// System.out.println(webtoolDataList.toJSONString());

		}

		System.out.println("Added json object to json array");

		// Write JSON file
		try (FileWriter file = new FileWriter("webtools_mysql.json")) {
			// We can write any JSONArray or JSONObject instance to the file
			file.write(webtoolDataList.toJSONString());
			file.flush();

		} catch (IOException e) {
			e.printStackTrace();
		}

		System.out.println("JSON file generated !");

	}

}
