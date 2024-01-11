Feature: Kitchen Get Shipping Method List API scenarios with Super Admin Access

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/kitchen/v1/campaigns/'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
   
	#REV2-23701
  Scenario: GET - Verify Super admin can fetch Shipping Method List

		Given path 'shippingmethods'
  	When method get
  	Then status 200
  	And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And assert response.total >= 1
    And karate.log('Test Completed !')
   
    