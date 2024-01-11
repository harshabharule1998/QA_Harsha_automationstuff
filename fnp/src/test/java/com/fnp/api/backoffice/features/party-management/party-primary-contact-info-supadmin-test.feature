Feature: Party Primary Contact Information scenarios

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1/partycontacts/primary'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
	 
  #REV2-18480
	Scenario: GET - Verify Party Primary Contacts by PartyID with Super Admin access with Invalid authorization token
    
		* def invalidAuthToken = loginResult.accessToken + "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
		* def partyId = 'P_00870'
			
		Given path '/' + partyId
		When method get
	  Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
  
    
	#REV2-18479
	Scenario: GET - Verify Super Admin cannot access Party Primary Contact Information with Unsupported Method
	
		* def partyId = 'P_00870'
		* def requestPayload = {}
    
    Given path '/' + partyId
    When request requestPayload
    And method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    And karate.log('Test Completed !')
    

	#REV2-18478
	Scenario: GET - Verify Super Admin cannot access Party Primary Contact Information with Invalid Endpoint URL
	
		* def partyId = 'P_00870'
	
		Given path '/test/' + partyId
		When method get
	  Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message == "http.request.not.found"
		And karate.log('Test Completed !')
    
      
	#REV2-18477
	Scenario: GET - Verify user cannot fetch Party Primary Contact Information with multiple spaces in partyId
	
		* def partyId = '  P_00 8  70'
		
		Given path '/' + partyId
		When method get
	  Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "party.not_found"
		And karate.log('Test Completed !')
    
 
	#REV2-18476
	Scenario: GET - Verify user cannot fetch Party Primary Contact Information with blank value in partyId
	
		* def partyId = '   '
		
		Given path '/' + partyId
		When method get
	  Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "party.not_found"
		And karate.log('Test Completed !')
		
		  
	#REV2-18475
	Scenario: GET - Verify user cannot fetch Party Primary Contact Information with value not allowed in partyId
	
		* def partyId = '!@#$%'
		
		Given path '/' + partyId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].errorCode == "BAD_REQUEST"
		And match response.errors[0].message contains "http.request.rejected"
		And karate.log('Test Completed !')
		

	#REV2-18474
	Scenario: GET - Verify user cannot fetch Party Primary Contact Information with invalid value in partyId
	
		* def partyId = 'ABC001'
		
		Given path '/' + partyId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "party.not_found"
		And karate.log('Test Completed !')
		
	 	
	#REV2-18473
	Scenario: GET - Verify Super admin can fetch Party Primary Contact Information with valid value in partyId
    
		* def partyId = 'P_00870'
    
		Given path '/' + partyId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
		
		