Feature: Party GET returns all permissions assigned to partyLogin scenarios

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/logins'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
 
  #REV2-18147
	Scenario: GET - Verify super admin that returns all permissions assigned to partyLogin for all valid values
	
		Given path '/permissions'
			
 		And param page = 0
 		And param partyLoginId = 'U_01006'
    And param size = 10
    And param sortParam = 'permissionCode:asc'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
	
	#REV2-18148
	Scenario: GET -  Verify super admin returns all permissions assigned to partyLogin for all Invalid values
	
		Given path '/permissions'
		
		And param page = 'ab'
 		And param partyLoginId = 'P$00170'
    And param size = 'cd'
    And param sortParam = 'abc:asc'
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message contains 'invalid.value.forpage'
    And karate.log('Test Completed !')
	
	   
	#REV2-18149
	Scenario: GET - Verify super admin returns all permissions assigned to partyLogin for all Blank fields
			
		Given path '/permissions'
	
		And param page = ' '
 		And param partyLoginId = ' '
    And param size = ' '
    And param sortParam = ' '
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
	
	
	#REV2-18151
	Scenario: GET -  Verify super admin returns all permissions assigned to partyLogin for try inserting with leading and trailing spaces in partyLoginId.
			
		Given path '/permissions'
	
		And param page = 0
 		And param partyLoginId = " " + 'U_01006' + " "
    And param size = 10
    And param sortParam = 'permissionCode:asc'
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
	
	#REV2-18154
	Scenario: GET - Verify super admin to returns all permissions assigned to partyLogin for only required fields partyLoginId.
	
		Given path '/permissions'

 		And param partyLoginId = 'U_01006'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
	 
	#REV2-18155
	Scenario: GET -  Verify super admin returns all permissions assigned to partyLogin for only optional fields.
			
		Given path '/permissions'
	
		And param page = 0
    And param size = 10
    And param sortParam = 'permissionCode:asc'
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
	
	 
	#REV2-18156
  Scenario: GET -  Verify super admin returns all permissions assigned to partyLogin for with Invalid value in Endpoint (URL).

		Given path '/permission'
		And param page = 0
 		And param partyLoginId = 'U_01006'
    And param size = '10'
    And param sortParam = 'permissionCode:asc'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
	  And match response.errors[0].message contains "party.login_id_not_found"
    And karate.log('Test Completed !')
	
	
	#REV2-18157
	 Scenario: GET -  Verify super admin returns all permissions assigned to partyLogin for with unsupported methods.
	 
		* def requestPayload = {}

		Given path '/permissions'
		And param page = 0
 		And param partyLoginId = 'U_01006'
    And param size = '10'
    And param sortParam = 'permissionCode:asc'
    When request requestPayload
		And method post
		Then status 405
		And karate.log('Status : 405')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message contains "Unsupported request Method. Contact the site administrator"
    And karate.log('Test Completed !')
	
	
	#REV2-18158
	Scenario: GET -  Verify super admin returns all permissions assigned to partyLogin for with Invalid authentication.

		* def invalidAuthToken = loginResult.accessToken + "kjsgsahshdj"
    * header Authorization = invalidAuthToken
    
		Given path '/permissions'
		And param page = 0
 		And param partyLoginId = 'U_01006'
    And param size = '10'
    And param sortParam = 'permissionCode:asc'
		When method get
		Then status 401
		And karate.log('Status : 401')
		And karate.log(' Records found : ', response)
		And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
	