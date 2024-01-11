package com.fnp.ui.common;

import java.io.FileReader;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.intuit.karate.Logger;
import com.intuit.karate.driver.Target;

public class BrowserStackTarget implements Target {

	private String url;
	private String driverType = null;
	private String capabilityKey = null;
	private String capability = null;

	public BrowserStackTarget(Map<String, Object> options) {
		url = (String) options.get("url");
		capabilityKey = (String) options.get("capabilityKey");
		if (url == null) {
			throw new RuntimeException("url is null");
		}
		// update driver type and browserName if needed
	}

	@Override
	public Map<String, Object> start(Logger logger) {

		String webDriverUrl = url;
		logger.info("BrowserStack url provisioned: {}", webDriverUrl);

		Map<String, Object> driverMap = new HashMap<String, Object>();
		Map<String, Object> session = new HashMap<String, Object>();
		Map<String, Object> capabilities = new HashMap<String, Object>();

		JSONParser parser = new JSONParser();
		try {

			Object obj = parser.parse(new FileReader("src/main/resources/capabilities.json"));

			JSONObject jsonObject = (JSONObject) obj;
			capability = (String) ((JSONObject) jsonObject.get(capabilityKey)).get("capabilities").toString();
			driverType = (String) ((JSONObject) jsonObject.get(capabilityKey)).get("driverType");
			logger.info("{} : {} ", capabilityKey, capability);
			logger.info("driverType : {}", driverType);

		} catch (Exception e) {
			e.printStackTrace();
		}

		driverMap.put("type", driverType);

		Map<String, String> capabilityMap = jsonStringToMap(capability);

		for (Map.Entry<String, String> entry : capabilityMap.entrySet()) {
			logger.info("Adding - {} : {}", entry.getKey(), entry.getValue());
			capabilities.put(entry.getKey(), entry.getValue());

		}

		session.put("capabilities", capabilities);
		session.put("desiredCapabilities", capabilities);

		driverMap.put("webDriverSession", session);
		driverMap.put("start", false);
		driverMap.put("webDriverUrl", webDriverUrl);

		return driverMap;
	}

	@Override
	public Map<String, Object> stop(Logger logger) {
		return Collections.EMPTY_MAP;
	}

	public Map<String, String> jsonStringToMap(String cap) {

		Map<String, String> map = new HashMap<String, String>();
		ObjectMapper mapper = new ObjectMapper();

		try {
			// convert JSON string to Map
			map = mapper.readValue(cap, new TypeReference<HashMap<String, String>>() {
			});
			System.out.println(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

}