Feature: Suggestion Capping Search Manager feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/columbus/v1/configurations/suggestiongroups'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"columbusSearchManager"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
	
	
	@columbusRegression	
	#REV2-11062
	Scenario: GET - Verify Search Manager can fetch suggestion capping data for valid domainName
		
		* def validDomainName = "fnp.com"	
		Given param domainId = validDomainName	
		When method get
		Then status 200
		And karate.log('Status : 200')
		And assert response.totalResult > 1
		
		And karate.log('Test Completed !')
		
	
	#REV2-11063
	Scenario: GET - Verify Search Manager error to fetch suggestion capping data for invalid domainName
		
		* def invalidDomainName = "abc123.com"	
		Given param domainId = invalidDomainName	
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
			
	#REV2-11064
	Scenario: GET - Verify Search Manager error to fetch suggestion capping data for blank domainName
		
		* def blankDomainName = ""	
		Given param domainId = blankDomainName	
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
		
	#REV2-11065
	Scenario: GET - Verify Search Manager get 404 error for suggestion capping invalid endpoint
		
		Given path '/abc1'	
		Given param domainId = "fnp.com"	
		When method get
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
	
	
	@columbusRegression
	#REV2-11067
	Scenario: PUT - Verify Search Manager can update suggestion capping data for valid domainName
		
		* def validDomainName = "fnp.com"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json')
		
		* eval requestPayload.recentSearch = 4
		* eval requestPayload.popularSearch = 3
		* eval requestPayload.boostedSearch = 5
		* eval requestPayload.totalResult = 12
			
		Given param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.totalResult == 12
		
		And karate.log('Test Completed !')
		
	
	#REV2-11068
	Scenario: PUT - Verify Search Manager error to update suggestion capping data for invalid domainName
		
		* def invalidDomainName = "abc123.com"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json')
		
		* eval requestPayload.recentSearch = 4
		* eval requestPayload.popularSearch = 3
		* eval requestPayload.boostedSearch = 5
		* eval requestPayload.totalResult = 12
			
		Given param domainId = invalidDomainName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
	
	#REV2-11069
	Scenario: PUT - Verify Search Manager error to update suggestion capping data for blank domainName
		
		* def blankDomainName = ""
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json')
		
		* eval requestPayload.recentSearch = 4
		* eval requestPayload.popularSearch = 3
		* eval requestPayload.boostedSearch = 5
		* eval requestPayload.totalResult = 12
			
		Given param domainId = blankDomainName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
	
	#REV2-11070
	Scenario: PUT - Verify Search Manager error to update suggestion capping data with negative values
		
		* def validDomainName = "fnp.com"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json')
		
		* eval requestPayload.recentSearch = -4
		* eval requestPayload.popularSearch = -3
		* eval requestPayload.boostedSearch = -5
		* eval requestPayload.totalResult = -12
			
		Given param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Negative value not allowed for weightages"
		
		And karate.log('Test Completed !')
		
			
	#REV2-11071
	Scenario: PUT - Verify Search Manager get 404 error for updating suggestion capping data with invalid endpoint
		
		
		* def validDomainName = "fnp.com"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json')
		
		* eval requestPayload.recentSearch = 4
		* eval requestPayload.popularSearch = 3
		* eval requestPayload.boostedSearch = 5
		* eval requestPayload.totalResult = 12
		
		Given path '/abc1'	
		Given param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
		
		
	@columbusRegression
	#REV2-11073
	Scenario: PUT - Verify Search Manager can reset suggestion capping data for valid domainName
		
		* def validDomainName = "fnp.com"
		* def requestPayload = {}
		
		Given path '/reset'
		And param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.totalResult == 7
		
		And karate.log('Test Completed !')
		
	
	#REV2-11074
	Scenario: PUT - Verify Search Manager error to reset suggestion capping data for invalid domainName
		
		* def invalidDomainName = "abc123.com"
		* def requestPayload = {}
		
		Given path '/reset'
		And param domainId = invalidDomainName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
		
	#REV2-11075
	Scenario: PUT - Verify Search Manager error to reset suggestion capping data for blank domainName
		
		* def blankDomainName = ""
		* def requestPayload = {}
		
		Given path '/reset'
		And param domainId = blankDomainName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid domain Id"
		
		And karate.log('Test Completed !')
		
	
	#REV2-11076
	Scenario: PUT - Verify Search Manager get 404 error for resetting suggestion capping data with invalid endpoint
		
		
		* def validDomainName = "fnp.com"
		* def requestPayload = {}
		
		Given path '/reset1'	
		And param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 404
		And karate.log('Status : 404')
		
		And karate.log('Test Completed !')
		
	
	@columbusRegression
	Scenario: PUT - Verify Search Manager update suggestion capping valid data for auto calculated popular search field
		
		* def validDomainName = "fnp.com"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json') 
		
		* eval requestPayload.recentSearch = 3
		* eval requestPayload.popularSearch = 6
		* eval requestPayload.boostedSearch = 2
		* eval requestPayload.totalResult = 11
			
		Given param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.totalResult == 11
		
		And karate.log('Test Completed !')
		

	Scenario: PUT - Verify Search Manager update suggestion capping invalid data for auto calculated popular search field
		
		* def validDomainName = "fnp.com"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/suggestion-capping.json') 
		
		* eval requestPayload.recentSearch = 3
		* eval requestPayload.popularSearch = 6
		* eval requestPayload.boostedSearch = 2
		* eval requestPayload.totalResult = 13
			
		Given param domainId = validDomainName
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Suggestion Groups Update Failed due to Bad data, Sum of boostedSearch, popularSearch and recentSearch should be equal to totalResult"
		
		And karate.log('Test Completed !')