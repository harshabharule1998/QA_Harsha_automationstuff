Feature: Kitchen Get Currency List API scenarios with Super Admin Access

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/tiffany/v1/'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
 
	#REV2-43754
  Scenario: GET - Verify Super admin can fetch Currency List with valid uomType
  
		Given path 'uoms'
  	And param uomType = 'CURRENCY'
  	When method get
  	Then status 200
  	And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
	#REV2-43755
  Scenario: GET - Verify Super admin cannot fetch Currency List with invalid uomType
  
		Given path 'uoms'
  	And param uomType = 'sdfsds'
  	When method get
  	Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid Uom Type"
    And karate.log('Test Completed !')
    
    
	#REV2-43756
  Scenario: GET - Verify Super admin cannot fetch Currency List with blank uomType
  
  	Given path 'uoms'
  	And param uomType = ''
  	When method get
  	Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Uom Type must not be blank"
    And karate.log('Test Completed !')
    
    
	#REV2-43757
  Scenario: GET - Verify Super admin cannot fetch Currency List with invalid or blank Auth token
  	
		* eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
  	
  	Given path 'uoms'
  	And param uomType = 'CURRENCY'
  	When method get
  	Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')    
    
    