Feature: Party get logged in user profile scenarios for super admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
   
   
  #REV2-33180
  Scenario: GET - Verify super admin for Get logged in user profile for valid Authentication Token.
 	
    Given path '/login-profiles'
    And method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
   
   
  #REV2-33182  
  Scenario: GET - Verify super admin for Get logged in user profile  with Invalid value in Endpoint (URL).
 	
    Given path '/login-profile'
    And method get
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
     And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
   
   
	#REV2-33183    
  Scenario: Verify Unsupported Method for Get logged in user profile with Valid value in Endpoint (URL) for super admin.
 	
    * def requestPayload = {}
     
    Given path '/login-profiles'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
    
    
	#REV2-33181
  Scenario: GET - Verify super admin for Get logged in user profile for invalid Authentication Token.
 	
 		* def invalidAuthToken = loginResult.accessToken
    * header Authorization = invalidAuthToken + "isndshfbfjcj"
    
    Given path '/login-profiles'
    And method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
 
 
 
 
 