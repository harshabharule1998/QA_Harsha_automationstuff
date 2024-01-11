Feature: Manual alloc preference GET by date ranges with super admin user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    

  #REV2-30660 
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation pref config get-date-ranges api with missing any mandatory value
  
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = ''
    And param size = 10
    And param vendorType = 'FC'
    When method get
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  #REV2-30659
  
  Scenario: GET - Verify super admin user cannot fetch records of manual alloc pref config get-date-ranges API with unsupported method
  
    Given request ''
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = '1'
    And param size = 10
    And param vendorType = 'FC'
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')

  #REV2-30657
  
  Scenario: GET - Verify super admin user cannot fetch records of manual alloc pref config get-date-ranges API with invalid URL
  
    Given path '/date-rangesss'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = '1'
    And param size = 10
    And param vendorType = 'FC'
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

  #REV2-30656
  
  Scenario: GET - super admin user cannot fetch records of manual allocation preference config get-date-ranges api with valid/invalid/blank values
  
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = 'xyz'
    And param size = 10
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  #REV2-30654
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation pref config get-date-ranges api with mandatory values
  
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = ''
    And param pgId = '1'
    And param size = ''
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-30653
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get-date-ranges api with missing values in optional field
    
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = ''
    And param pgId = '1'
    And param size = ''
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-30652 
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get-date-ranges api with missing values in mandatory field
   
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = 'xyz'
    And param size = 10
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  #REV2-30650 
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config GET-date-ranges api with invalid value in mandatory field
    
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = 'xyz'
    And param size = 10
    And param vendorType = 'FC'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  #REV2-30649
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation pref config get-date-ranges api with all invalid fields
  
    Given path '/date-ranges'
    And param baseGeoId = '@##'
    And param page = 11
    And param pgId = 'xyz'
    And param size = 100
    And param vendorType = 'dfg'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  #REV2-30648
  
  Scenario: GET - Verify super admin user can fetch records of manual allocation preference config get-date-ranges api with valid values
  
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = '1'
    And param size =  10
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
