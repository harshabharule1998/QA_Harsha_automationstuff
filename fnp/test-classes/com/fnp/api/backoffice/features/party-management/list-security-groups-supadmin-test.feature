Feature: GET API test to list Security groups for Login ID

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def invalidPartyLoginId = 'am2aawe2'
    * def invalidSortId = 'am2aj2'
    * def invalidPage = 'am2aj2*'
    * def invalidSize = 'am2aj2%*'
   
      
  #@Regression
  #REV2-18279
	Scenario: GET - Verify all security group for Valid search criteria For All Fields
	
		Given path '/securitygroups/'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And match response.data[*].permissions[*].id == '#notnull'
    And karate.log('Test Completed !')
    
    
  #@Regression
  #REV2-18275
	Scenario: GET - Verify for list of parties for Valid search criteria All Fields
	
		Given path '/permissions/'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And match response.data[*].permissions[*].id == '#notnull'
    And karate.log('Test Completed !')
    
   
   #REV2-18276 
   Scenario: GET - Verify list of parties for Valid search criteria For Size.
   
   
		Given path '/permissions/'
    And param page = 0
    And param size = 10
    When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And match response.data[*].permissions[*].id == '#notnull'
    And karate.log('Test Completed !')
   
  #@Regression 
  #REV2-18277
  Scenario: GET - Verify parties for Valid search criteria Pagination functionality for Search Party GET API
   
    Given path '/permissions/'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:asc'
    When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And match response.data[*].permissions[*].id == '#notnull'
    And karate.log('Test Completed !')
    
   
   #REV2-18289
   Scenario: GET - Verify 404 error for blank partyLoginId
    
    Given path '/securityGroups'
    
    And param page = 0
    And param partyLoginId = " "
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
   
    
   #REV2-18288
   Scenario: GET - Verify 404 error for Invalid partyLoginId
    
    Given path '/securityGroups'
    
    And param page = 0
    And param partyLoginId = invalidPartyLoginId
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    
   #REV2-18287
   Scenario: GET - Verify 404 error for Invalid sorting functionality
    
    Given path '/securityGroups'
    
    And param page = 0
    And param size = 10
    And param sortParam = invalidSortId
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    
   #REV2-18286
   Scenario: GET - Verify 404 error for Invalid Pagination functionality
    
    Given path '/securityGroups'
    
    And param page = invalidPage
    And param partyLoginId = 'U_00002'
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    
   #REV2-18285
   Scenario: GET - Verify 404 error for Invalid size functionality
    
    Given path '/securityGroups'
    
    And param page = 0
    And param partyLoginId = 'U_00002'
    And param size = invalidSize
    And param sortParam = 'securityGroupCode:asc'
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
   
   #REV2-18284
   Scenario: GET - Verify 404 error for all fields blank 
    
    Given path '/securityGroups'
    
    And param page = ' '
    And param partyLoginId = ' '
    And param size = ' '
    And param sortParam = ' '
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
   
   #REV2-18283 and REV2-18282
   Scenario: GET - Verify 404 error for all Invalid fields  
    
    Given path '/securityGroups'
    
    And param page = invalidPage
    And param partyLoginId = invalidPartyLoginId
    And param size = invalidSize
    And param sortParam = invalidSortId
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    
   #REV2-18281
   Scenario: GET - Verify 401 error for authentication
   
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    
    Given path '/securityGroups'
    And param page = 1
    And param partyLoginId = 'U_00002'
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
    
   #REV2-18280
   Scenario: Verify error for Unsupported method all Fields
   
    * def requestPayload = {}
    
    Given path '/securityGroups'
    And param page = 1
    And param partyLoginId = 'U_00002'
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    When request requestPayload 
    And method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[*].message contains "http.request.not.found"
    And karate.log('Test Completed !')
   
    
   #@Regression
   #REV2-18279
   Scenario: Verify list of parties for Valid search criteria
   
    
    Given path '/logins/securityGroups'
    
    And param page = 0
    And param partyLoginId = 'U_00002'
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    
    And method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And match response.data[*].permissions[*].id == '#notnull'
    And karate.log('Test Completed !')
    
    
   #REV2-18278
   Scenario: GET - Verify for Valid search criteria Sorting functionality for Party
   
    
    Given path '/logins/securityGroups'
    
    And param page = 0
    And param partyLoginId = 'U_00003'
    And param size = 10
    And param sortParam = 'securityGroupCode:asc'
    
    And method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And match response.data[*].permissions[*].id == '#notnull'
    And karate.log('Test Completed !')
    
    







    
    
    
    
    
    
    
    
  
    
    
    
    
    
     
    
    
