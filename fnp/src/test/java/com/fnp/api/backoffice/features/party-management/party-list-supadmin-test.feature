Feature: Party List API Scenarios feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/logins'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def partyId = 'P_00007'
    * def invalidPartyId = 'P_00XX7'
    
    #@Regression
    #REV2-12041
    Scenario: GET - Verify List of all Logins with valid partyId
    * param page = 0
    * param partyId = partyId
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    Then assert response.total >= 1
    And karate.log('Test Completed !')
    
  
    #REV2-12042
    Scenario: GET - Verify List of all Logins with invalid  partyId
    * param page = 0
    * param partyId = invalidPartyId
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    Then match response.errors[*].message == ["Party Id not found"]
    And karate.log('Test Completed !')
    
    
   
    #REV2-12043
    Scenario: GET - Verify List of all Logins with blank value in partyId
    * param page = 0
    * param partyId = ' '
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    Then match response.errors[*].message == ["Party Id not found"]
    And karate.log('Test Completed !')
      
    
    #REV2-12044
    Scenario: GET - Verify List of all Logins with Invalid value in Endpoint (URL)
  
    Given path  'simsim/v1/loginsaDFzSgzdxg'
  
    * param page = 0
    * param partyId = partyId
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 404
    And karate.log('Status : 404')
    Then match response.errors[*].message == ["http.request.not.found"]
    And karate.log('Test Completed !')
   
    
    #REV2-12044
    Scenario: PUT - Verify List of all Logins with Unsupported Method
    * def requestPayload = {}
    * param page = 0
    * param partyId = partyId
    * param size = 10
    * param sortParam = 'loginName:asc'
    When request requestPayload
    And method put    
    Then status 405
    And karate.log('Status : 405')
    Then match response.errors[*].message == ["Unsupported request Method. Contact the site administrator"]
    And karate.log('Test Completed !')
    
   
    #REV2-12047
    Scenario: GET - Verify List of all Logins with blank value with leading & trailing spaces in partyId.
    * param page = 0
    * param partyId = ' P_00007 '
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    Then match response.errors[*].message == ["Party Id not found"]
    And karate.log('Test Completed !')
    
    
    #REV2-12046
    Scenario: GET - Verify 500 error for GET Listing Usernames APIs
    * param page = 0
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 500
    And karate.log('Status : 500')
    Then match response.errors[*].message == ["Internal server error"]
    And karate.log('Test Completed !')
     
     
     
    #REV2-15382
    Scenario: GET - Verify List of all Logins with not allowed value in partyId
    * param page = 0
    * param size = 10
    * param sortParam = 'loginName:asc'
    When method get
    Then status 500
    And karate.log('Status : 500')
    Then match response.errors[*].message == ["Internal server error"]
    And karate.log('Test Completed !')
    
    
    