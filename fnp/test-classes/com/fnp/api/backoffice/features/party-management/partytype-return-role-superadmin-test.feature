Feature: Return Role by partyType

	Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/partyTypeRoles'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    

 		#REV2-14442
		Scenario: GET - Verify roles by PartyType for Super Admin access- with valid PartyType
	
			* def partyTypeId = 'S_70002'
		
			Given path '/' + partyTypeId
			When method get
			Then status 200
			And karate.log('Status : 200')
			And karate.log(' Records found : ', response)
    	And karate.log('Test Completed !')
    
 
		#REV2-14443
		Scenario: GET - Verify roles by PartyType for Super Admin access- with Invalid PartyType
	
			* def partyTypeId = 'S_7000'
		
			Given path '/' + partyTypeId
			When method get
  		Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == " Party Type Id not found"
			And karate.log('Test Completed !')
		
		
		#REV2-14444
		Scenario: GET - Verify roles by PartyType for Super Admin access- with blank value for PartyType
	
			* def partyTypeId = '    '
			
			Given path '/' + partyTypeId
			When method get
	  	Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == " Party Type Id not found"
			And karate.log('Test Completed !')
		
		
		#REV2-14445
		Scenario: GET - Verify roles by PartyType for Super Admin access- try blank value with leading and trailing spaces 
	
			* def partyTypeId = '    S_70002    '
			
			Given path '/' + partyTypeId
			When method get
	  	Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == " Party Type Id not found"
			And karate.log('Test Completed !')
		
		
		#REV2-14446
		Scenario: GET - Verify roles by PartyType for Super Admin access- with special character in parttype 
	
			* def partyTypeId = '@#S_70!002'
			
			Given path '/' + partyTypeId
			When method get
	  	Then status 400
			And karate.log('Status : 404')
			And match response.errors[0].message == " Party Type Id not found"
			And karate.log('Test Completed !')
			
			
		#REV2-14447
		Scenario: GET - Verify roles by PartyType for Super Admin access- with Invalid Endpoint URL
	
			* def partyTypeId = 'S_70002'
			
			Given path '/test/' + partyTypeId
			When method get
	  	Then status 404
			And karate.log('Status : 404')
			And match response.errors[0].message == "http.request.not.found"
			And karate.log('Test Completed !')
				
		#REV2-14448
		Scenario: GET - Verify Unsupported Method for Return Role by PartyType with Super Admin access- with Valid value in Endpoint URL
	
			* def partyTypeId = 'S_70002'
			* def requestPayload = {}
			
			Given path '/' + partyTypeId
			When request requestPayload
			And method patch
	  	Then status 405
			And karate.log('Status : 405')
			And match response.errors[0].message contains "Unsupported request Method"
			And karate.log('Test Completed !')
			
			
		#REV2-14450
		Scenario: GET - Verify roles by PartyType with Super Admin access- with invalid authentication
	
			* def partyTypeId = 'S_70002'
			* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
			* header Authorization = invalidAuthToken
			
			Given path '/' + partyTypeId
			When method get
	  	Then status 401
			And karate.log('Status : 401')
			And match response.errors[0].message == "Token Invalid! Authentication Required"
			And karate.log('Test Completed !')
			