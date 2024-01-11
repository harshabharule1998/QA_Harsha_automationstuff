Feature: Kitchen default attributes api scenarios with Super Admin

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/publishers/default-attributes'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
	  
	#REV2-22043
	Scenario: GET - Verify Super admin can request for default attributes with valid sort parameter as fieldDisplayName:DESC
	
		Given param sortParam = 'fieldDisplayName:DESC'
		When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
  
   
	#REV2-22042/REV2-22034
	Scenario: GET - Verify Super admin cannot request for default attributes with invalid sort parameter
	
		Given param sortParam = 'abcbd'
		When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid sort parameter"
    And karate.log('Test Completed !')
    
   
	#REV2-22041/REV2-22035
	Scenario: GET - Verify Super admin cannot request for default attributes with blank sort parameter
	
		Given param sortParam = ' '
		When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid sort parameter"
    And karate.log('Test Completed !')
    
   
	#REV2-22040/REV2-22033
	Scenario: GET - Verify Super admin can request for default attributes with valid sort parameter as fieldDisplayName:ASC
	
		Given param sortParam = 'fieldDisplayName:ASC'
		When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is : ', response)
    And karate.log('Test Completed !')
    
    