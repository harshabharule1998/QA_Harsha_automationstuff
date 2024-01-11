Feature: Tiffany country Controller Module for Category Manager CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/tiffany/v1/countries'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def countryId1 = 'IND'
    * def countryId2 = 'CO_00001'
    * def invalidCountryId = 'a12aawe2'
   
   @Regression
	Scenario: GET - Validate Category Manager can fetch countries using countryId
			
		Given path '/' + countryId1
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
    And match response.countryCode contains 'IN'
    And karate.log('Test Completed !')
		
	
	Scenario: GET - Validate Category Manager can not  fetch countries using Invalid countryId
			
		Given path '/' + invalidCountryId
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Country Records not found : ', response)
		And assert response.errors[0].message == 'Country Id not exist'
		And karate.log('Test Completed !')
		
		
	Scenario: GET - Validate Category Manager can fetch countries using countryId
			
		Given path '/' 
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And karate.log('Test Completed !')