Feature: Party get all relation types scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    

  #REV2-16327
  Scenario: GET - Verify super admin for relation types with Unsupported Method.
 	
    * def requestPayload = {}
     
    Given path '/relation-types'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
    
    
  #REV2-16326
  Scenario: GET - Verify super admin for relation types with Invalid value in Endpoint (URL).
  
  	Given path '/relation-type'
    When method get
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
     And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
  
	#REV2-16328
	Scenario: GET - Verify super admin for relation types with Invalid Authentication
	
		* def invalidAuthToken = loginResult.accessToken + "agvsfxvsssssssssss"
    * header Authorization = invalidAuthToken
	
    Given path '/relation-types'
		When method get
	  Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
	
	
	Scenario: GET - Verify super admin for relation types with valid value endpoint URL
  
  	Given path '/relation-types'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	
	
	
	
	