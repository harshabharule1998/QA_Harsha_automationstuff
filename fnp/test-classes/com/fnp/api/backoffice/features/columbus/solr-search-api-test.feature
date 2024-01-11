Feature: Solr Search API feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/columbus/v1/search'
	
	
	#@columbusRegression
	#REV2-13620
	Scenario: GET - Verify Solr search API gives 200 response code for active campaign keyword
		
		* def validDomainName = "fnp.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = "stop"
		And param lang = "en"
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
	
	
	#@columbusRegression
	#REV2-13621
	Scenario: GET - Verify Solr search API gives 404 response code for inactive campaign keyword
		
		* def validDomainName = "fnp.com"		
		
		Given param domainId = validDomainName	
		And param geoId = "india"
		And param keyword = "test"
		And param lang = "en"
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
