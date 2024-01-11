Feature: Tiffany state Controller Module for Super Admin CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/tiffany/v1'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def countryId = 'IND'
    * def invalidCountryId = 'a12aawe2'
    * def stateId = 'AZ'
    
  
  @Regression
 Scenario: GET - Validate Super Admin can fetch state using countryId
			
	  Given path '/countries/' + countryId + '/states'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And match response[*].countryCode contains "IN"
		And karate.log('Test Completed !')
		
		@Regression
	Scenario: GET - Validate Super Admin can fetch specific state using stateId
			
		Given path '/states/' + stateId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And match response.stateId contains "AZ"
		And karate.log('Test Completed !')
		
		
		Scenario: GET - Validate Super Admin can not  fetch countries using Invalid countryId
			
		Given path '/countries/' + invalidCountryId
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Country Records not found : ', response)
		And assert response.errors[0].message == 'Country Id not exist'
		And karate.log('Test Completed !')
		
		
	
		
	
	