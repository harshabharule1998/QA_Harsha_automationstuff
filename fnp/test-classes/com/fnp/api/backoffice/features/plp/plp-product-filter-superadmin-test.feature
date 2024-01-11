Feature: PLP Module Product Filter config scenarios with Super Admin

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/columbus/v1/productfilterconfigs'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def validProductFilterId = "F_05315"
    * def invalidProductFilterId = "F_05315AB"
    

	#REV2-23850
  Scenario: GET - Verify Super admin to get filter config data with valid productFilterId		
    
    Given path '/' + validProductFilterId
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And match response.id == validProductFilterId
    And assert response.filterAttributes.length > 0
    And karate.log('Test Completed !')
    
	
	#REV2-23851
  Scenario: GET - Verify Super admin to get filter config data with invalid productFilterId		
    
    Given path '/' + invalidProductFilterId
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Filter config not Present"
    And karate.log('Test Completed !')
    
	
	#REV2-23852
  Scenario: GET - Verify Super admin to get filter config data with blank productFilterId		
    
    Given path '/' + ""
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Parameter Missing"
    And karate.log('Test Completed !')
	

	#REV2-23853
  Scenario: GET - Verify Super admin to get filter config data with invalid endpoint		
    
    Given path '/' + validProductFilterId + '/get'
    When method get
    Then status 404
    And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


	#REV2-23854
  Scenario: GET - Verify Super admin to get filter config data with unauthorized credentials		
    
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
    Given path '/' + validProductFilterId
    When method get
    Then status 403
    And karate.log('Response is : ', response)
    And karate.log('Status : 403')
    And match response.errors[0].message contains "Access Denied"
    And karate.log('Test Completed !')
