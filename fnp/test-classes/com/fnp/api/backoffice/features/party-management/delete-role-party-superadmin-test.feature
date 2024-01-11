Feature: Delete Role by Party API

	Background: 
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def partyId = 'P_00170'
    * def invalidPartyId = 'P_00XX7'
    * def roleId = 'S_00303'
    * def invalidRoleId = 'S_00XX7'
    
    
  #REV2-14408
  Scenario: DELETE - Verify Delete Role by Party for valid values in partyId & roleId
  	
  	Given path '/party-roles/' + partyId
  	And param roleId = roleId
  	When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response == 'Role deleted for party successfully'
		And karate.log('Test Completed !')
		
		
	#REV2-14409
  Scenario: DELETE - Verify Delete Role by Party for invalid values in partyId & roleId
  	
  	Given path '/party-roles/' + invalidPartyId
  	And param roleId = invalidRoleId
  	When method delete
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "BAD_REQUEST"
  	And karate.log('Test Completed !')
  	
  	
	#REV2-14410
  Scenario: DELETE - Verify Delete Role by Party for blank values in partyId & roleId
  	 
  	Given path '/party-roles/' + ""
  	And param roleId = ""
  	When method delete
  	Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
  	And karate.log('Test Completed !')
  	
  
	#REV2-29941
  Scenario: DELETE - Verify Delete Role by Party for leading & trailing spaces in partyId & roleId
  	 
  	Given path '/party-roles/' + " " + partyId + " "
  	And param roleId = " " + roleId + " "
  	When method delete
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].errorCode contains "BAD_REQUEST"
  	And karate.log('Test Completed !')
  	
  	
	#REV2-14411
  Scenario: DELETE - Verify Delete Role by Party for Invalid Endpoint URL.
  	
  	Given path '/partyrol/' + partyId
  	And param roleId = roleId
  	When method delete
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[*].errorCode contains "NOT_FOUND"
		And karate.log('Test Completed !')
  	
  
	#REV2-14412
  Scenario: PUT - Verify Delete Role by Party for Unsupported Method.
  	 
  	Given path '/party-roles/' + partyId
  	And param roleId = roleId
  	And request ''
  	When method put
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[*].message contains "Unsupported request Method. Contact the site administrator"
		And karate.log('Test Completed !')
  	
  	
	#REV2-14413
  Scenario: DELETE - Verify Delete Role by Party for duplicate values in partyId & roleId	
		
  	Given path '/party-roles/' + partyId
  	And param roleId = roleId
  	When method delete
		Then status 400
		And karate.log('Status : 400')
  	And match response.errors[*].errorCode contains "BAD_REQUEST"
  	And match response.errors[*].message contains "Role is not associated with the Party"
  	And karate.log('Test Completed !')
  	
  	
  #REV2-14415	
  Scenario: DELETE - Verify Delete Role by Party for Invalid Authentication Token.
  
  	* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
  	 
  	Given path '/party-roles/' + partyId
  	And param roleId = roleId
  	When method delete
		Then status 401
		And karate.log('Status : 401')
  	And match response.errors[*].errorCode contains "UNAUTHORIZED"
  	And match response.errors[*].message contains "Token Invalid! Authentication Required"
  	And karate.log('Test Completed !')
  
  
  
  
  
  
  
  
  
  
  	