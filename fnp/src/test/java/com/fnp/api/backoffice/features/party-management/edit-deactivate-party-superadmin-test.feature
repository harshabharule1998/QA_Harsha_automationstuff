Feature: Edit Deactivate party by partyid super admin scenarios

	Background: 
	
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1/parties'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
    
    * def sleep =
			"""
			function(seconds) {
				for(i = 0; i <= seconds; i++) {
					java.lang.Thread.sleep(1*1000);
				}
			}
			"""
			
	#REV2-33220
	Scenario: PUT - Verify Deactivate Party by partyId with valid partyId for super admin access.
  	 
		* def partyId = "P_01158"
  	 
		Given path '/' + partyId
		And param status = "true"
		And request ''
		When method put
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
    	
    * call sleep 3
		
		* header Authorization = authToken
		
		Given path '/pawri/v1/parties/' + partyId
		And param status = "false"
		And request ''
		When method put
		Then status 200
		And karate.log('Status : 200')
		And karate.log(response)
		And match response.message == "Request Submitted for Disabling Party "
		And karate.log('Test Completed !')
	
		* call sleep 3
		
		* def requestId = response.requestId
		
		* header Authorization = authToken
		
		Given path '/pawri/v1/request-status/' + requestId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(response)
		And karate.log('Test Completed !')
		
	#REV2-33221
	Scenario: PUT - Verify Deactivate Party by partyId with Invalid partyId for super admin access.
  	 
		* def partyId = "P_0115"
  	 
		Given path '/' + partyId
		And param status = "true"
		And request ''
		When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message == "party.id.not_found"
    And karate.log('Test Completed !')
    	
    	
  #REV2-33222	
	Scenario: PUT - Verify Deactivate Party by partyId for leading and trailing spaces in partyId for super admin access.
    	
		* def partyId = " P_01158 "
  	 
		Given path '/' + partyId
  	And param status = "true"
  	And request ''
  	When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
  	And match response.errors[*].message contains "party.id.not_found"
    And karate.log('Test Completed !')
    	
    	
  #Defect:REV2-32583
  #REV2-33223		 
	Scenario: PUT - Verify Deactivate Party by partyId for not allowed values in partyId for super admin access.
    	
		* def partyId = "@#$%25&"
  	 
		Given path '/' + partyId
		And param status = "true"
		And request ''
		When method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "BAD_REQUEST"
  	And match response.errors[*].message contains "http.request.rejected"
    And karate.log('Test Completed !')
    
    
  #Defect:REV2-33215 	
  #REV2-33224	  	
	Scenario: PUT - Verify Deactivate Party by partyId for blank value in partyId for super admin access.
    	
		* def partyId = ""
  	 
  	Given path '/' + partyId
  	And param status = "true"
  	And request ''
  	When method put
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
  	And match response.errors[*].message contains "party.id.not_found"
   	And karate.log('Test Completed !')
   	
    	
  #REV2-33225	
	Scenario: PUT - Verify Deactivate Party by partyId for Invalid Authentication Token for super admin access.
    	
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * def partyId = "P_01158"
  	 
  	Given path '/' + partyId
  	And param status = "true"
  	And request ''
  	When method put
		Then status 403
		And karate.log('Status : 403')
		And match response.errors[*].errorCode contains "access.denied"
  	And match response.errors[*].message contains "Access Denied"
    And karate.log('Test Completed !')
    
   	
  #REV2-33227	  	
	Scenario: PUT - Verify Deactivate Party by partyId for Unsupported Method for super admin access.
    	
		* def partyId = "P_01158"
  	 
  	Given path '/' + partyId
  	And param status = "true"
  	And request ''
  	When method post
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[*].errorCode contains "unsupported.http.method"
  	And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
    
    	
  #REV2-33226	  
	Scenario: PUT - Verify Deactivate Party by partyId with Invalid value in Endpoint (URL) for super admin access.
    	
		* def partyId = "P_01158"
  	 
  	Given path 's/' + partyId
  	And param status = "true"
  	And request ''
  	When method put
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
  	And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    

 
    	