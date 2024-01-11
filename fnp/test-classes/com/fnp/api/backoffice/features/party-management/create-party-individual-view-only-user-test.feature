Feature: Create new party individual API for view only user

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    
    * def loginResultViewOnly = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyViewOnly"}
    * def authTokenViewOnly = loginResultViewOnly.accessToken
    
    * header Authorization = authTokenViewOnly
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(4)
       
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/party/create-party-individual.json')
    
  	
	#REV2-21425
  Scenario: POST - Validate Party View Only user can create party individual for valid values
    	
		* eval requestPayload.loginEmailId = "test" + num + "@cybage.com"
		* eval requestPayload.loginPhoneNumber = num
		
		Given path '/parties'
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Test Completed !')
		
