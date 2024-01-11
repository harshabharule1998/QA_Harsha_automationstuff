Feature: GET New Vendor Allocation Preference Quota Configuration scenarios for Add Rule page with Allocation Executive Role


  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-28828
  Scenario: GET - Verify Allocation Executive can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with valid values
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[0].id == null
    And match response.data[0].geoId == "1"
    And match response.data[0].geoGroupId == "2"
    And match response.data[0].deliveryMode == "Courier"
    And match response.data[0].vendorType == "FC"
    And match response.data[0].vendorName == "FC_Name101"
    And match response.data[0].vendorId == "FC_101"
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-28829
  Scenario: GET - Verify Allocation Executive can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with invalid values
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'CONTAIns'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Request Parameter Values are not as Expected operator"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-28830
  Scenario: GET - Verify Allocation Executive can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page if spaces in parameter
    Given path '/configs'
    And param deliveryMode = 'Courier '
    And param fcId = 'FC_101 '
    And param geoId = '1 '
    And param geoGroupId = '2 '
    And param fieldName = 'baseGeoId '
    And param fieldValues = '411001 '
    And param operator = 'CONTAINS '
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Invalid characters found in geoGroupId"
    And match response.errors[*].message contains "Invalid characters found in geoId"
    And match response.errors[*].message contains "Invalid characters found in fcId"
    And match response.errorCount == 3
    And karate.log('Test Completed !')


  #REV2-28831
  Scenario: GET - Verify Allocation Executive can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with blank values
    Given path '/configs'
    And param deliveryMode = ''
    And param fcId = ''
    And param geoGroupId = ''
    And param geoId = ''
    And param fieldName = ''
    And param fieldValues = ''
    And param operator = ''
    And param page = ''
    And param size = ''
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "geoGroupId must not be blank"
    And match response.errors[*].message contains "deliveryMode must not be blank"
    And match response.errors[*].message contains "geoId must not be blank"
    And match response.errors[*].message contains "fcId must not be blank"
    And match response.errorCount == 4
    And karate.log('Test Completed !')


  #REV2-28833
  Scenario: GET - Verify Allocation Executive can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with only mandatory fields
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[0].id == null
    And match response.data[0].geoId == "1"
    And match response.data[0].geoGroupId == "2"
    And match response.data[0].deliveryMode == "Courier"
    And match response.data[0].vendorType == "FC"
    And match response.data[0].vendorName == "FC_Name101"
    And match response.data[0].vendorId == "FC_101"
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-28834
  Scenario: GET - Verify Allocation Executive can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with BaseGeoID and "Equal to" Operator
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[0].id == null
    And match response.data[0].geoId == "1"
    And match response.data[0].geoGroupId == "2"
    And match response.data[0].deliveryMode == "Courier"
    And match response.data[0].vendorType == "FC"
    And match response.data[0].vendorId == "FC_101"
    And match response.data[0].vendorName == "FC_Name101"
    And match response.data[0].baseGeoId == "411001"
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And match response.total == 1
    And match response.totalPages == 1
    And karate.log('Test Completed !')


  #REV2-28835
  Scenario: GET - Verify Allocation Executive can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with BaseGeoID and "DOES NOT CONTAINS" Operator
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411'
    And param operator = 'DOES_NOT_CONTAIN'
    And param page = 0
    And param size = 50
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[*].baseGeoId !contains "411"
    And match response.currentPage == 0
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-28836
  Scenario: GET - Verify Allocation Executive can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with multiple BaseGeoID separated by comma
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001','411003','411005'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[0].id == null
    And match response.data[0].geoId == "1"
    And match response.data[0].geoGroupId == "2"
    And match response.data[0].deliveryMode == "Courier"
    And match response.data[0].vendorType == "FC"
    And match response.data[0].vendorId == "FC_101"
    And match response.data[0].vendorName == "FC_Name101"
    And match response.data[0].baseGeoId == "411001"
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And match response.total == 3
    And match response.totalPages == 1
    And karate.log('Test Completed !')


  #REV2-28837
  Scenario: GET - Verify Allocation Executive can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page after editing the values
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'NOT_EQUAL_TO'
    And param page = 0
    And param size = 50
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[*].baseGeoId !contains "411001"
    And match response.currentPage == 0
    And assert response.total >= 1
    # Edit the values
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/hendrix/v1/new-vendor-allocation-preferences/configs'
    And param deliveryMode = 'Digital'
    And param fcId = 'FC_102'
    And param geoId = '2'
    And param geoGroupId = '3'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '410'
    And param operator = 'CONTAINS'
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data[0].id == null
    And match response.data[0].geoId == "2"
    And match response.data[0].geoGroupId == "3"
    And match response.data[0].deliveryMode == "Digital"
    And match response.data[0].vendorType == "FC"
    And match response.data[0].vendorId == "FC_102"
    And match response.data[0].vendorName == "FC_Name102"
    And match response.data[0].baseGeoId contains "410405"
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And assert response.total >= 1
    And karate.log('Test Completed !')

    