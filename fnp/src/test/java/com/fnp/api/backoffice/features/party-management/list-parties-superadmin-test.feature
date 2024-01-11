Feature: Party - GET parties APIs scenarios for super admin user.

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
   
    
    * def supAdmloginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def supAdmauthToken = supAdmloginResult.accessToken
    * header Authorization = supAdmauthToken
   
   
	#REV2-13235
	Scenario: GET - Verify list of parties for super admin with View , Create , Edit, Delete Permission Access for all Valid fields

    Given path '/parties'
 		And param page = 0
    And param size = 10
    And param sortParam = 'firstName:asc'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
 
	#REV2-13236
	Scenario: GET - Verify list of parties for super admin  with View , Create , Edit ,Delete Permission Access for all invalid fields
	
	* header supAdmAuthorization = supAdmauthToken
    
    Given path '/parties'
 		And param page = 5
    And param size = 5
    And param sortParam = "firstName:7"
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')	
	
	
	#REV2-13237
	Scenario: GET - verify list of parties for super admin  with View , Create , Edit , Delete Permission Access for all blank fields
	
		* header supAdmAuthorization = supAdmauthToken
    
    Given path '/parties'
 		And param page = ' '
    And param size = ' '
    And param sortParam = " "
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')	
	

	
	
			