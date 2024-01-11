Feature: Solr Suggestion API feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/columbus/v1/suggestions'
	
	
	#@columbusRegression
	#REV2-16072
	Scenario: GET - Verify Solr suggestion API gives auto-suggestion items response type
		
		* def validDomainName = "fnp.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = "cake"
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match each response[*].suggestionResponseType == "PR"
		And assert response.length > 0
		And karate.log('Test Completed !')
		
	
	#@columbusRegression
	#REV2-13651
	Scenario: GET - Verify Solr suggestion API gives auto-suggestion items for valid keyword
		
		* def validDomainName = "fnp.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = "cake"
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match each response[*].keyword == "#regex (?i).*cake.*"
		And assert response.length > 0
		And karate.log('Test Completed !')	


	#REV2-13653
	Scenario: GET - Verify Solr suggestion API gives auto-suggestion items for invalid keyword
		
		* def validDomainName = "fnp.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = "abcxyz"
		When method get
		Then status 200
		And karate.log('Status : 200')
		And assert response.length == 0
		And karate.log('Test Completed !')
			

	#REV2-13655
	Scenario: GET - Verify Solr suggestion API gives auto-suggestion items for blank keyword
		
		* def validDomainName = "fnp.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = ""
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Keyword is required"
		And karate.log('Test Completed !')
		

	Scenario: GET - Verify Solr suggestion API gives auto-suggestion items for invalid domainId
		
		* def validDomainName = "abc.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = "cake"
		When method get
		Then status 200
		And karate.log('Status : 200')
		And assert response.length == 0
		And karate.log('Test Completed !')
