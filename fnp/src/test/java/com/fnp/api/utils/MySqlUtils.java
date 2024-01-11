package com.fnp.api.utils;

import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

public class MySqlUtils {
	
	private static JdbcTemplate jdbc;
	private static final Logger logger = LoggerFactory.getLogger(MySqlUtils.class);
	
	public MySqlUtils(String dataBaseName) {
		
		ResourceBundle rb = ResourceBundle.getBundle("db");
		String url = (String)rb.getObject(dataBaseName+".url");
		String userName = (String)rb.getObject(dataBaseName+".userName");
		String password = (String)rb.getObject(dataBaseName+".password");
		String driver = (String)rb.getObject(dataBaseName+".driverClassName");
		
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(driver);
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(password);
		
		jdbc = new JdbcTemplate(dataSource);
		logger.info("init jdbc template: {}", url);
	}

	public Object readValue(String query) {
		return jdbc.queryForObject(query, Object.class);
	}    

	public Map<String, Object> readRow(String query) {
		return jdbc.queryForMap(query);
	}

	public List<Map<String, Object>> readRows(String query) {
		return jdbc.queryForList(query);
	}   

}