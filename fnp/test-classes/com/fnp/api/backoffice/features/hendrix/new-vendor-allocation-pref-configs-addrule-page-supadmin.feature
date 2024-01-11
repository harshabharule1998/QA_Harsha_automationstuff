Feature: GET New Vendor Allocation Preference Quota Configuration scenarios for Add Rule page with Super Admin Role


  Background: 
    Given url backOfficeAPIBaseUrl
    And path '/hendrix/v1/new-vendor-allocation-preferences'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def token = loginResult.accessToken
    * header Authorization = token


  #REV2-28811
  Scenario: GET - Verify 401 error for invalid authorization token for New Vendor Allocation Preference Quota Configuration for Add Rule page
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'DOES_NOT_CONTAIN'
    And param page = 0
    And param size = 10
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-28812
  Scenario: GET - Verify 401 error if no authorization token added for New Vendor Allocation Preference Quota Configuration for Add Rule page
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'NOT_EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-28816
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page even if missing any value in optional fields
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param operator = 'CONTAINS'
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
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-28817, REV2-28826
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with BaseGeoID and "Equal to" Operator
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


  #REV2-28818
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with BaseGeoID and "Not Equal to" Operator
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
    And karate.log('Test Completed !')


  #REV2-28819, REV2-28822
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with BaseGeoID and "CONTAINS" Operator
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411'
    And param operator = 'CONTAINS'
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
    And match response.data[0].baseGeoId contains "411001"
    And match response.data[0].quotas[*].pgId == ["1","2","3","4","5","6","10"]
    And match response.data[0].quotas[0].value == null
    And match response.data[0].fromDate == null
    And match response.data[0].thruDate == null
    And match response.currentPage == 0
    And assert response.total >= 1
    And karate.log('Test Completed !')


  #REV2-28820
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with BaseGeoID and "DOES NOT CONTAINS" Operator
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


  #REV2-28821
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with multiple BaseGeoID separated by comma
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


  #REV2-28823
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with only mandatory fields
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


  #REV2-28824
  Scenario: GET - Verify Super admin can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page if no data available
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '0000'
    And param operator = 'EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.data == []
    And match response.currentPage == 0
    And match response.total == 0
    And match response.totalPages == 0
    And karate.log('Test Completed !')


  #REV2-28825
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page after editing the values
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


  #REV2-28827, REV2-28975
  Scenario: GET - Verify Super admin can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with blank values
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


  #REV2-28972
  Scenario: GET - Verify Super admin can fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with valid values
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


  #REV2-28973
  Scenario: GET - Verify Super admin can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with invalid values
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


  #REV2-28974
  Scenario: GET - Verify Super admin can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page if spaces in parameter
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


  #REV2-28977
  Scenario: GET - Verify Super admin can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page if missing any mandatory field
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'NOT_EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "geoId must not be blank"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-28978
  Scenario: GET - Verify 404 error for invalid endpoint URL of New Vendor Allocation Preference Quota Configuration for Add Rule page
    Given path '/onfigs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param operator = 'NOT_EQUAL_TO'
    And param page = 0
    And param size = 10
    When method get
    Then status 404
    And karate.log('status : 404')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "http.request.not.found"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-28979
  Scenario: GET - Verify Super admin can not fetch New Vendor Allocation Preference Quota Configuration on Add Rule page with valid/invalid/blank values
    Given path '/configs'
    And param deliveryMode = 'Courier'
    And param fcId = 'FC_101'
    And param geoId = '1'
    And param geoGroupId = '2'
    And param fieldName = ''
    And param fieldValues = '411001'
    And param operator = ''
    And param page = 0
    And param size = 0
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "must be greater than or equal to 1"
    And match response.errorCount == 1
    And karate.log('Test Completed !')


  #REV2-28810
  Scenario: GET - Verify 405 error for unsupported method for New Vendor Allocation Preference Quota Configuration on Add Rule page
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/new-vendor-alloc-preference.json')
    * eval requestPayload.baseGeoId = "411001"
    * karate.log(requestPayload)
    Given path '/configs'
    When request requestPayload
    And method patch
    Then status 405
    And karate.log('status : 405')
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    