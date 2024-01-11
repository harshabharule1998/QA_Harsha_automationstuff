Feature: Allocation Logic POST duplicate with Allocation Executive user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
   	And path '/hendrix/v1/allocation-rules/carriers/_duplicate'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/alloc-logic-post-duplicate.json')
	
	
  #REV2-32897
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for 403 error with Allocation Executive user
  
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    * def status = response.status
    And match status != 500
    And karate.log('Status : 403')
    And karate.log('Test Completed !')

 