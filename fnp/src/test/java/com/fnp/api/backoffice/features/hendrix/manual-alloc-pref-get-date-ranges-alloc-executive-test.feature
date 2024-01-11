Feature: Manual alloc preference GET by date ranges with Allocation Executive user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
  

  #REV2-30662
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get-date-ranges api with valid values
  
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = '1'
    And param size = 10
    And param vendorType = 'FC'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-30668
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get-date-ranges api with mandatory values
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

  #REV2-30667
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get-date-ranges api with valid/invalid/blank values
  
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

  #REV2-30666
  
  Scenario: GET - Verify allocation executive user can fetch records of manual allocation preference config get-date-ranges api with missing any mandatory value
   
    Given path '/date-ranges'
    And param baseGeoId = '411006'
    And param page = 0
    And param pgId = ''
    And param size = 10
    And param vendorType = 'FC'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "pgId must not be blank"
    And karate.log('Test Completed !')

  #REV2-30665
  
  Scenario: GET - Verify allocation executive user can fetch records of manual allocation preference config get-date-ranges api with invalid authorization token
  
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

  #REV2-30664
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get-date-ranges api with blank values
    
    Given path '/date-ranges'
    And param baseGeoId = " "
    And param page = " "
    And param pgId = " "
    And param size = " "
    And param vendorType = " "
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  #REV2-30663
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get-date-ranges api with invalid values
  
    Given path '/date-ranges'
    And param baseGeoId = " sdf"
    And param page = "sd "
    And param pgId = " sd"
    And param size = "aff "
    And param vendorType = "sfff "
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
