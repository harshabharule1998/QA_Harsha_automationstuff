Feature: Tiffany city Controller Module for Super Admin CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/tiffany/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def cityId = 'agra'
    * def countryId = 'IND'
    * def stateId = 'IN-UP'
    * def invalidCityId = 'am2aawe2'
   
   
   @Regression
	Scenario: GET - Validate Super Admin can fetch countries using countryId
			
		Given path '/cities/' + cityId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
    And match response.cityName contains 'Agra'
    And karate.log('Test Completed !')
		
	
	Scenario: GET - Validate Super Admin can not  fetch cities using Invalid cityId
			
		Given path '/cities/' + invalidCityId
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Country Records not found : ', response)
		And assert response.errors[0].message == 'City Id not exist'
		And karate.log('Test Completed !')
		
		
	Scenario: GET - Validate Super Admin can fetch city using countryId
			
		Given path '/cities/' + 'country/' + countryId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And karate.log('Test Completed !')
		
		
	Scenario: GET - Validate Super Admin can fetch city using stateId
			
		Given path '/states/' + stateId + '/cities'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And karate.log('Test Completed !')