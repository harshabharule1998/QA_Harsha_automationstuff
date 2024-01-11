Feature: Get active party for super admin role

	Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
   
    
	#REV2-33247
	Scenario: GET - Verify super admin can fetch active party status with valid value in partyId
	
		* def partyId = 'P_00170'
		
		Given path '/parties/status/' + partyId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
	
	
	#REV2-33249
	Scenario: GET - Verify super admin cannot fetch active party status with not allowed values in partyId
	
		* def partyId = '@#$##'
		
		Given path '/parties/status/' + partyId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[*].errorCode contains "BAD_REQUEST"
		And match response.errors[*].message contains "party.id.not_found"
		And match response.errors[*].field contains "partyId"
    And karate.log('Test Completed !')
  
  
  #REV2-33248
  Scenario: GET - Verify super admin cannot fetch active party status with Invalid value in partyId
  
		* def partyId = 'T_00170'
		
		Given path '/parties/status/' + partyId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[*].errorCode contains "BAD_REQUEST"
		And match response.errors[*].message contains "party.id.not_found"
		And match response.errors[*].field contains "partyId"
    And karate.log('Test Completed !')
    
  
  #REV2-33250 
  Scenario: GET - Verify super admin cannot fetch active party status with leading and trailing spaces in partyId  
  
  * def partyId = '  P_00170  '
		
		Given path '/parties/status/' + partyId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[*].errorCode contains "BAD_REQUEST"
		And match response.errors[*].message contains "party.id.not_found"
		And match response.errors[*].field contains "partyId"
    And karate.log('Test Completed !')
    
  
  #REV2-33251 
  Scenario: GET - Verify super admin cannot fetch active party status with Blank values in partyId.
  
   * def partyId = ''
   
   	Given path '/parties/status/' + partyId
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[*].errorCode contains "NOT_FOUND"
		And match response.errors[*].message contains "party.id.not_found"
		And match response.errors[*].field contains "partyId"
    And karate.log('Test Completed !')
    
	
	#REV2-33252
  Scenario: GET - Verify super admin cannot fetch active party status with Invalid Authentication Token
  
		* def partyId = 'P_00170'
		* def invalidAuthToken = loginResult.accessToken + "asdfghghjlkhgtrdh"
		* header Authorization = invalidAuthToken
		
		Given path '/parties/status/' + partyId
		When method get
		Then status 401
		And karate.log('Status : 401')
    And karate.log('Test Completed !')
  

	#REV2-33254
  Scenario: GET - Verify super admin cannot fetch active party status with Unsupported Method
  
		* def partyId = 'P_00170'
		* def requestPayload = {}
    
		Given path '/parties/status/' + partyId
		When request requestPayload
		And method post
		Then status 405
		And karate.log('Status : 405')
		And karate.log(' Records found : ', response)
		And match response.errors[*].errorCode contains "unsupported.http.method"
		And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
  
  
  #REV2-33253
  Scenario: GET - Verify super admin cannot fetch active party status with Invalid value in Endpoint URL
  
		* def partyId = 'P_00170'
    
		Given path '/parties/status/abc/' + partyId
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[*].errorCode contains "NOT_FOUND"
		And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    