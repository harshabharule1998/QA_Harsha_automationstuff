Feature: Image Search Configuration API Search Admin feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/columbus/v1/configurations/configattributes'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"columbusSearchAdmin"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
		
		* def requestPayload = 
   	"""
   		{
			    "value": "true"
			}
   	"""
	
	@columbusRegression
	#REV2-11046
	Scenario: GET - Verify Search Admin can fetch image search data for valid domainName and attributeName
		
		* def validDomainName = "fnp.com"	
		* def validAttributeName = "imagesearch"	
		
		Given param domainId = validDomainName	
		And param attributeName = validAttributeName
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.value == '#notnull'
		
		And karate.log('Test Completed !')
		
	
	#REV2-11047
	Scenario: GET - Verify Search Admin to fetch image search data for invalid domainName and attributeName
		
		* def invalidDomainName = "abc.com"	
		* def invalidAttributeName = "test"	
		
		Given param domainId = invalidDomainName	
		And param attributeName = invalidAttributeName
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		

	#REV2-11048
	Scenario: GET - Verify Search Admin to fetch image search data for blank domainName and attributeName
		
		* def blankDomainName = ""	
		* def blankAttributeName = ""	
		
		Given param domainId = blankDomainName	
		And param attributeName = blankAttributeName
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
	
	#REV2-11049
	Scenario: GET - Verify Search Admin get 404 error for image search invalid endpoint
		
		Given path '/abc1'	
		Given param domainId = "fnp.com"
		And param attributeName = "imagesearch"	
		When method get
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
		
	
	@columbusRegression
	#REV2-11051
	Scenario: PUT - Verify Search Admin can update image search data for valid domainName and attributeName
		
		* def validDomainName = "fnp.com"	
		* def validAttributeName = "imagesearch"	
		
		Given param domainId = validDomainName	
		And param attributeName = validAttributeName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.value == "true"
		
		And karate.log('Test Completed !')
		

	#REV2-11052
	Scenario: PUT - Verify Search Admin to update image search data for invalid domainName and attributeName
		
		* def invalidDomainName = "abc.com"	
		* def invalidAttributeName = "test"	
		
		Given param domainId = invalidDomainName	
		And param attributeName = invalidAttributeName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
	
	#REV2-11053
	Scenario: PUT - Verify Search Admin to update image search data for blank domainName and attributeName
		
		* def blankDomainName = ""	
		* def blankAttributeName = ""	
		
		Given param domainId = blankDomainName	
		And param attributeName = blankAttributeName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
	
		
	#REV2-11054
	Scenario: PUT - Verify Search Admin get 404 error for update image search with invalid endpoint
		
		Given path '/abc1'	
		Given param domainId = "fnp.com"
		And param attributeName = "imagesearch"	
		When request requestPayload
		And method put
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
		
  
  @columbusRegression
	#REV2-11056
	Scenario: PUT - Verify Search Admin can reset image search data for valid domainName and attributeName
		
		* def requestPayload = {}
		* def validDomainName = "fnp.com"	
		* def validAttributeName = "imagesearch"	
		
		Given path '/reset'
		And param domainId = validDomainName	
		And param attributeName = validAttributeName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.value == "false"
		
		And karate.log('Test Completed !')
		

	#REV2-11057
	Scenario: PUT - Verify Search Admin to reset image search data for invalid domainName and attributeName
		
		* def requestPayload = {}
		* def invalidDomainName = "abc.com"	
		* def invalidAttributeName = "test"	
		
		Given path '/reset'
		And param domainId = invalidDomainName	
		And param attributeName = invalidAttributeName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		

	#REV2-11058
	Scenario: PUT - Verify Search Admin to reset image search data for blank domainName and attributeName
		
		* def requestPayload = {}
		* def blankDomainName = ""	
		* def blankAttributeName = ""	
		
		Given path '/reset'
		And param domainId = blankDomainName	
		And param attributeName = blankAttributeName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')		


	#REV2-11059
	Scenario: PUT - Verify Search Admin get 404 error for reset image search with invalid endpoint
		
		* def requestPayload = {}
		
		Given path '/reset/abc1'
		And param domainId = "fnp.com"
		And param attributeName = "imagesearch"	
		When request requestPayload
		And method put
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')