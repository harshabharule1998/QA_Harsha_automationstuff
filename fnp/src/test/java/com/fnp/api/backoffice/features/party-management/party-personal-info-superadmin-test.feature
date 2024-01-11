Feature: Party Personal Info API scenarios

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1/party-individuals'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
   

	#REV2-15465
	Scenario: GET - Verify Super admin cannot fetch Party Individual Info by partyId with Invalid Authentication
   
		* def invalidAuthToken = loginResult.accessToken + "asdfghghjlkhgtrdh"
		* header Authorization = invalidAuthToken
		* def partyId = 'P_00007'
		
		Given path '/' + partyId
		When method get
	  Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
   
  
	#REV2-15464
	Scenario: GET - Verify Super admin cannot fetch Party Individual Info by partyId with Unsupported Method
  
		* def partyId = 'P_00007'
    * def requestPayload = {}
    
		Given path '/' + partyId
  	When request requestPayload
  	And method patch
  	Then status 405
  	And karate.log('Status : 405')
  	And match response.errors[0].message contains "Unsupported request Method"
  	
  	  
	#REV2-15463
	Scenario: GET - Verify Super admin cannot fetch Party Individual Info by partyId with Invalid value in Endpoint URL
  	
		* def partyId = 'P_00007'
	
		Given path '/abc/' + partyId
		When method get
	  Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message == "http.request.not.found"
		And karate.log('Test Completed !')
  
  
  #REV2-15462
  Scenario: GET - Verify Super admin cannot fetch Party Individual Info with blank partyId
  
 		* def partyId = ' '
  	
		Given path '/' + partyId
  	When method get
  	Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[0].errorCode == "NOT_FOUND"
  	And match response.errors[0].message contains "party.id.not_found_in_party_individual"
  	And match response.errors[0].field contains "partyId"
  
 
  #REV2-15461
  Scenario: GET - Verify Super admin cannot fetch Party Individual Info by with Invalid partyId
  
  	* def partyId = '$@@@###'
  	
  	Given path '/' + partyId
  	When method get
  	Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[0].errorCode == "NOT_FOUND"
  	And match response.errors[0].message contains "party.id.not_found_in_party_individual"
  	
    
	#REV2-15460
	Scenario: GET - Verify Super admin can fetch Party Individual Info with valid value in partyId
    
		* def partyId = 'P_00007'
    
		Given path '/' + partyId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
		
		