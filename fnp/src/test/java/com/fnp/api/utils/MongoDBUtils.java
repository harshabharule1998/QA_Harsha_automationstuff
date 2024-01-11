package com.fnp.api.utils;

import java.util.ResourceBundle;

import org.bson.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

public class MongoDBUtils {

	private static final Logger logger = LoggerFactory.getLogger(MongoDBUtils.class);
	private String url = null;
	private String dbName = null;

	MongoClientURI connectionString = null;
	MongoClient mongoClient = null;
	MongoDatabase database = null;
	MongoCollection<Document> collection = null;

	public MongoDBUtils(String dataBaseName, String collectionName) {

		ResourceBundle rb = ResourceBundle.getBundle("db");
		url = (String) rb.getObject(dataBaseName + ".url");
		dbName = (String) rb.getObject(dataBaseName + ".database");
		logger.info("MongoDB connection url : {} database : {}", url, database);

		connectionString = new MongoClientURI("mongodb://localhost:27017");
		mongoClient = new MongoClient(connectionString);
		database = mongoClient.getDatabase(dbName);
		collection = database.getCollection(collectionName);
	}

	public String readFieldValue(Document doc, String fieldName) {

		String fieldValue = "" + doc.get(fieldName);
		logger.info("fieldValue for {} : {} ", fieldName, fieldValue);
		return fieldValue;
	}

	public Document readRowContainingFieldvalue(MongoCollection<Document> collection, String fieldName,
			String fieldValue) {

		MongoCursor<Document> cursor = collection.find().iterator();
		Document doc = null;
		try {

			while (cursor.hasNext()) {
				doc = cursor.next();
				logger.info(doc.toJson());

				if (doc.getString(fieldName).equalsIgnoreCase(fieldValue)) {
					return doc;
				}
			}

		} finally {
			cursor.close();
		}

		return doc;
	}

	public MongoCollection<Document> readAllRows() {

		MongoCursor<Document> cursor = this.collection.find().iterator();
		Document doc = null;

		while (cursor.hasNext()) {
			doc = cursor.next();
			logger.info(doc.toJson());
		}

		cursor.close();
		return this.collection;

	}

}