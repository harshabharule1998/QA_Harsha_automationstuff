package com.fnp.api.utils;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class XMLDataGeneratorUtils {

	private static final String URL_REDIRECT_CREATE_OUTPUT_XML_FILE = "./url_redirect_create_data.xml";
	private static final String URL_REDIRECT_UPDATE_OUTPUT_XML_FILE = "./url_redirect_update_data.xml";
	private static final String URL_REDIRECT_DELETE_OUTPUT_XML_FILE = "./url_redirect_delete_data.xml";

	public void generateURLRedirectCreateXML() {

		try {

			DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();

			DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();

			Document document = documentBuilder.newDocument();

			// root element
			Element root = document.createElement("urlRedirect");
			document.appendChild(root);

			for (int i = 1; i <= 10; i++) {

				// urlRedirectList element
				Element urlRedirectList = document.createElement("urlRedirectList");
				root.appendChild(urlRedirectList);

				// sourceUrl element
				Element sourceUrl = document.createElement("sourceUrl");
				sourceUrl.appendChild(document.createTextNode("fnp.com/cup-cakes" + i));
				urlRedirectList.appendChild(sourceUrl);

				// targetUrl element
				Element targetUrl = document.createElement("targetUrl");
				targetUrl.appendChild(document.createTextNode("fnp.com/cup-cakes" + i + i));
				urlRedirectList.appendChild(targetUrl);

				// isEnabled element
				Element isEnabled = document.createElement("isEnabled");
				isEnabled.appendChild(document.createTextNode("true"));
				urlRedirectList.appendChild(isEnabled);

				// entityType element
				Element entityType = document.createElement("entityType");
				entityType.appendChild(document.createTextNode("CMS"));
				urlRedirectList.appendChild(entityType);

				// redirectType element
				Element redirectType = document.createElement("redirectType");
				redirectType.appendChild(document.createTextNode("302"));
				urlRedirectList.appendChild(redirectType);

				// comment element
				Element comment = document.createElement("comment");
				comment.appendChild(document.createTextNode("create xml"));
				urlRedirectList.appendChild(comment);

				// action element
				Element action = document.createElement("action");
				action.appendChild(document.createTextNode("create"));
				urlRedirectList.appendChild(action);

			}

			// create the xml file
			// transform the DOM Object to an XML File
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource domSource = new DOMSource(document);
			StreamResult streamResult = new StreamResult(new File(URL_REDIRECT_CREATE_OUTPUT_XML_FILE));

			// If you use
			// StreamResult result = new StreamResult(System.out);
			// the output will be pushed to the standard output ...
			// You can use that for debugging

			transformer.transform(domSource, streamResult);

			System.out.println("Done creating XML File");

		} catch (ParserConfigurationException pce) {
			pce.printStackTrace();
		} catch (TransformerException tfe) {
			tfe.printStackTrace();
		}
	}

	public void generateURLRedirectUpdateXML() {

		try {

			DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();

			DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();

			Document document = documentBuilder.newDocument();

			// root element
			Element root = document.createElement("urlRedirect");
			document.appendChild(root);

			for (int i = 1; i <= 10; i++) {

				// urlRedirectList element
				Element urlRedirectList = document.createElement("urlRedirectList");
				root.appendChild(urlRedirectList);

				// urlId element
				Element urlId = document.createElement("urlId");
				urlId.appendChild(document.createTextNode("92cb0902-9086-4f29-aad7-dc442cde86ca"));
				urlRedirectList.appendChild(urlId);

				// targetUrl element
				Element targetUrl = document.createElement("targetUrl");
				targetUrl.appendChild(document.createTextNode("fnp.com/gifts/mothers-day-update" + i));
				urlRedirectList.appendChild(targetUrl);

				// isEnabled element
				Element isEnabled = document.createElement("isEnabled");
				isEnabled.appendChild(document.createTextNode("true"));
				urlRedirectList.appendChild(isEnabled);

				// redirectType element
				Element redirectType = document.createElement("redirectType");
				redirectType.appendChild(document.createTextNode("302"));
				urlRedirectList.appendChild(redirectType);

				// comment element
				Element comment = document.createElement("comment");
				comment.appendChild(document.createTextNode("update xml"));
				urlRedirectList.appendChild(comment);

				// action element
				Element action = document.createElement("action");
				action.appendChild(document.createTextNode("update"));
				urlRedirectList.appendChild(action);

			}

			// create the xml file
			// transform the DOM Object to an XML File
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource domSource = new DOMSource(document);
			StreamResult streamResult = new StreamResult(new File(URL_REDIRECT_UPDATE_OUTPUT_XML_FILE));

			// If you use
			// StreamResult result = new StreamResult(System.out);
			// the output will be pushed to the standard output ...
			// You can use that for debugging

			transformer.transform(domSource, streamResult);

			System.out.println("Done creating XML File");

		} catch (ParserConfigurationException pce) {
			pce.printStackTrace();
		} catch (TransformerException tfe) {
			tfe.printStackTrace();
		}
	}

	public void generateURLRedirectDeleteXML() {

		try {

			DocumentBuilderFactory documentFactory = DocumentBuilderFactory.newInstance();

			DocumentBuilder documentBuilder = documentFactory.newDocumentBuilder();

			Document document = documentBuilder.newDocument();

			// root element
			Element root = document.createElement("urlRedirect");
			document.appendChild(root);

			for (int i = 1; i <= 10; i++) {

				// urlRedirectList element
				Element urlRedirectList = document.createElement("urlRedirectList");
				root.appendChild(urlRedirectList);

				// urlId element
				Element urlId = document.createElement("urlId");
				urlId.appendChild(document.createTextNode("92cb0902-9086-4f29-aad7-dc442cde86ca"));
				urlRedirectList.appendChild(urlId);

				// action element
				Element action = document.createElement("action");
				action.appendChild(document.createTextNode("delete"));
				urlRedirectList.appendChild(action);

			}

			// create the xml file
			// transform the DOM Object to an XML File
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource domSource = new DOMSource(document);
			StreamResult streamResult = new StreamResult(new File(URL_REDIRECT_DELETE_OUTPUT_XML_FILE));

			// If you use
			// StreamResult result = new StreamResult(System.out);
			// the output will be pushed to the standard output ...
			// You can use that for debugging

			transformer.transform(domSource, streamResult);

			System.out.println("Done creating XML File");

		} catch (ParserConfigurationException pce) {
			pce.printStackTrace();
		} catch (TransformerException tfe) {
			tfe.printStackTrace();
		}
	}
}
