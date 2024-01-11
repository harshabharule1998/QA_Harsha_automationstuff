Feature: Tiffany pincode Controller Module for Category Agent with Edit CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/tiffany/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def pincodeNumber = 110001
    * def cityId = 'agra'
    * def invalidPincode = 'a12aawe2'
  
   @Regression
	Scenario: GET - Validate Category Agent with Edit can fetch state using pincode
			
		Given path '/countries/states/cities/pincode/' + pincodeNumber
		
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Pincode Record found : ', response)
    And match response.countryName contains 'India'
    And karate.log('Test Completed !')
		
	
	Scenario: GET - Validate Category Agent with Edit can not  fetch countries using Invalid pinCode
			
		Given path '/countries/states/cities/pincode/' + invalidPincode
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Country Records not found : ', response)
		And assert response.errors[0].message == 'Pincode not exist'
		And karate.log('Test Completed !')
		
	@Regression	
	Scenario: GET - Validate Category Agent with Edit can fetch pincode details based on pincode
			
		Given path '/pincode/' + pincodeNumber 
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And karate.log('Test Completed !')
		
		
	Scenario: GET - Validate Category Agent with Edit can fetch pincode details based on pincode
			
		Given path '/pincode/city/' + cityId
	
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Country Records found : ', response)
		And karate.log('Test Completed !')