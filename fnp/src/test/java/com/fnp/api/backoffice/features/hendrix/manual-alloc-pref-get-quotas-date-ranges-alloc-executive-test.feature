Feature: Manual alloc preference GET by qquotas date ranges with Allocation Executive user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
  
   #REV2-30801
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with mandatory values
  
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = ''
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
    #REV2-30799
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with missing value in optional field 
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
      
    #REV2-30798
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with missing value in mandatory field 
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ''
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = ' '
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
     #REV2-30797
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with valid/invalid/blank values 
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = 'ASw@@@'
    And param configName = ' '
    And param fromDate = '10-11-2021'
    And param page = ''
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
      
    #REV2-30796
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with blank values
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ' '
    And param configName = ' '
    And param fromDate = ' '
    And param page = ''
    And param pgId = ' '
    And param size = ' '
    And param thruDate = ' '
    And param vendorType = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
     #REV2-30795
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with invalid values
   
    Given path '/quotas-date-ranges'
    And param baseGeoId = ' !@#'
    And param configName = 'as!## '
    And param fromDate = ' fghhds234567'
    And param page = '-122'
    And param pgId = ' dd'
    And param size = ' ss'
    And param thruDate = ' a1222'
    And param vendorType = ' ssd'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
     #REV2-30794
  
  Scenario: GET - Verify  allocation executive user can fetch records of manual allocation preference config get quotas-date-ranges api with valid values
  
    Given path '/quotas-date-ranges'
    And param baseGeoId = '411006'
    And param configName = 'party'
    And param fromDate = '10-11-2021'
    And param page = '1'
    And param pgId = '1'
    And param size = '10'
    And param thruDate = '11-11-2021'
    And param vendorType = 'CR'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
    
    
    
    
    
    
    