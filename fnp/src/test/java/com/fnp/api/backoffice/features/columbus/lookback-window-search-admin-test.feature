Feature: Lookback Window API Search Admin feature

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
			    "value": "10"
			}
   	"""
	
	@columbusRegression
	#REV2-11024 and REV2-11025
	Scenario: GET - Verify Search Admin can fetch lookbackperiod data for valid domainName and attributeName
		
		* def validDomainName = "fnp.com"	
		* def validAttributeName = "lookbackperiod"	
		
		Given param domainId = validDomainName	
		And param attributeName = validAttributeName
		When method get
		Then status 200
		And karate.log('Status : 200')
		And assert response.value > 1
		
		And karate.log('Test Completed !')
		
	
	#REV2-11026
	Scenario: GET - Verify Search Admin to fetch lookbackperiod data for invalid domainName and attributeName
		
		* def invalidDomainName = "abc.com"	
		* def invalidAttributeName = "test"	
		
		Given param domainId = invalidDomainName	
		And param attributeName = invalidAttributeName
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		

	#REV2-11027
	Scenario: GET - Verify Search Admin to fetch lookbackperiod data for blank domainName and attributeName
		
		* def blankDomainName = ""	
		* def blankAttributeName = ""	
		
		Given param domainId = blankDomainName	
		And param attributeName = blankAttributeName
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
	
	#REV2-11028
	Scenario: GET - Verify Search Admin get 404 error for lookbackperiod invalid endpoint
		
		Given path '/abc1'	
		Given param domainId = "fnp.com"
		And param attributeName = "lookbackperiod"	
		When method get
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
		
	
	@columbusRegression
	#REV2-11030
	Scenario: PUT - Verify Search Admin can update lookbackperiod data for valid domainName and attributeName
		
		* def validDomainName = "fnp.com"	
		* def validAttributeName = "lookbackperiod"	
		
		Given param domainId = validDomainName	
		And param attributeName = validAttributeName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.value == "10"
		
		And karate.log('Test Completed !')
		

	#REV2-11031
	Scenario: PUT - Verify Search Admin to update lookbackperiod data for invalid domainName and attributeName
		
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
		
	
	#REV2-11032
	Scenario: PUT - Verify Search Admin to update lookbackperiod data for blank domainName and attributeName
		
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
	
		
	#REV2-11033
	Scenario: PUT - Verify Search Admin cannot update lookbackperiod data with negative value
		
		* eval requestPayload.value = "-10"
		
		Given param domainId = "fnp.com"	
		And param attributeName = "lookbackperiod"
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message contains "Negative value not allowed"
		
		And karate.log('Test Completed !')
	
	
	#REV2-11034
	Scenario: PUT - Verify Search Admin get 404 error for update lookbackperiod with invalid endpoint
		
		Given path '/abc1'	
		Given param domainId = "fnp.com"
		And param attributeName = "lookbackperiod"	
		When request requestPayload
		And method put
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
		
	
	@columbusRegression
	#REV2-11036
	Scenario: PUT - Verify Search Admin can reset lookbackperiod data for valid domainName and attributeName
		
		* def requestPayload = {}
		* def validDomainName = "fnp.com"	
		* def validAttributeName = "lookbackperiod"	
		
		Given path '/reset'
		And param domainId = validDomainName	
		And param attributeName = validAttributeName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.value == "15"
		
		And karate.log('Test Completed !')
		

	#REV2-11037
	Scenario: PUT - Verify Search Admin to reset lookbackperiod data for invalid domainName and attributeName
		
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
		

	#REV2-11038
	Scenario: PUT - Verify Search Admin to reset lookbackperiod data for blank domainName and attributeName
		
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


	#REV2-11039
	Scenario: PUT - Verify Search Admin get 404 error for reset lookbackperiod with invalid endpoint
		
		* def requestPayload = {}
		
		Given path '/reset/abc1'
		And param domainId = "fnp.com"
		And param attributeName = "lookbackperiod"	
		When request requestPayload
		And method put
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')