Feature: Allocation Logic Carrier CRUD scenarios with Super Admin

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/carriers'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadUpdate = requestPayload[1]
    
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def toTime =
      """
      	function(s) {
       		var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
       		var sdf = new SimpleDateFormat("dd-MM-yyyy");
       		return sdf.format(new java.util.Date());           
      	}
      """

  @getLogicCarrier
  Scenario: GET - To Verify if Created data is getting displayed in GET method
    
    Given param geoGroupId = requestPayloadCreate.geoGroupId
    And param geoId = requestPayloadCreate.geoId
    And param pgId = requestPayloadCreate.pgId
    And param page = __arg.page
    And param size = __arg.size
    When method get
    Then status 200
    And karate.log('Status : 200')
    * def responseData = response
    And karate.log('Test Completed !')
    
    
  @getLogicCarrierAfterUpdate
  Scenario: GET - To Verify if Updated data is getting displayed in GET method
    
    Given param geoGroupId = requestPayloadCreate.geoGroupId
    And param geoId = requestPayloadCreate.geoId
    And param pgId = requestPayloadCreate.pgId
    And param page = __arg.page
    And param size = __arg.size
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
   
 
  #REV2-17061
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for Same date and time for fromDate and thruDate
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.fromDate = toTime()
    * eval requestPayloadCreate.thruDate = toTime()
    
    And karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

	  
  #REV2-17060
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for From Date greater than Thru Date
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.fromDate = '15-12-2022'
    
    And karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17059
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for thruDate
    
    * eval requestPayloadCreate.thruDate = "12-13-2022"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadCreate.thruDate = "0"
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadCreate
    And karate.log(requestPayloadCreate)
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17058
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for fromDate
    
    * eval requestPayloadCreate.fromDate = "32-12-2022"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadCreate.fromDate = "0"
    * karate.log(requestPayloadCreate)
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17056
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid data in request body
    
    * eval requestPayloadCreate.abc = "wwwww"
    * eval requestPayloadCreate.idddd = "hghftydfthg"
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    * def responseMessages = get response.errors[*].message
    And match response.errors[*].message contains responseMessages
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17053
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid URL
    
    Given path '/hendrix/v1/allocationrules/carriers'
    And request requestPayloadCreate
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    * def errorResponse = get response.errors[*].message
    And match response.errors[*].message contains errorResponse
    And karate.log('Status : 404')
    And karate.log('Test Completed !')

  
  #REV2-17052
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with 500 error
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * karate.log('-------------Time is : ------------', toTime())
    * eval requestPayloadCreate.fromDate = toTime()
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    * def resId = response.id
    And match response.id == "#notnull"
    And karate.log('Response is : ', response)
    And match response.id == resId
    And karate.log('ID Matched')
    And karate.log('Status : 201')
    And karate.log('Test Completed !')


  #BUG - ID - REV2-18549
  #REV2-17051
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Auth code not added  
    
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    * eval requestPayloadCreate.configName = "diwali" + num
    
    Given request requestPayloadCreate
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    * def errorResponse = get response.errors[*].message
    And match response.errors[*].message contains errorResponse
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-17050
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Invalid Auth token given for Super Admin
    
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given request requestPayloadCreate
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-17049
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for Unsupported Method
    
    Given request requestPayloadCreate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

  
  #REV2-17048
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for missing any value in any mandatory field 
    
    * eval requestPayloadCreate.configName = ''
    * eval requestPayloadCreate.geoGroupId = ''
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    * def errors = get response.errors[*].message
    And match response.errors[*].message == errors
    And match response.errorCount == 2
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17046
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with only mandatory fields
    
    * eval requestPayloadCreate.configName = "diwali" + num
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    * def resId = response.id
    And match response.id == "#notnull"
    And karate.log('Response is : ', response)
    And match response.id == resId
    And karate.log('ID Matched')
    And karate.log('Status : 201')
    
    * def allocGetResult = call read('./alloc-logic-carrier-crud-superadmin-test.feature@getLogicCarrier') {page : 0, size : 300}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')

  
  #REV2-17043
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with duplicate values
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'This Carrier Allocation Rule Configuration is already exist for given Vendor'
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17042
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with blank values
    
    * eval requestPayloadCreate.baseGeoId = ""
    * eval requestPayloadCreate.configName = ""
    * eval requestPayloadCreate.deliveryMode = ""
    * eval requestPayloadCreate.factorCarrierRating = ""
    * eval requestPayloadCreate.factorLeadHours = ""
    * eval requestPayloadCreate.factorManualRating = ""
    * eval requestPayloadCreate.factorShippingPrice = ""
    * eval requestPayloadCreate.geoGroupId = ""
    * eval requestPayloadCreate.geoId = ""
    * eval requestPayloadCreate.pgId = ""
    
    And karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[*].message contains "factorManualRating should not be null."
    And match response.errors[*].message contains "factorLeadHours should not be null."
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errors[*].message contains "baseGeoId should not be blank."
    And match response.errors[*].message contains "The Geography field is mandatory."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "factorShippingPrice should not be null."
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And match response.errors[*].message contains "factorCarrierRating should not be null."
    And match response.errorCount == 9
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17041
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with combination of valid/Invalid/Spaces/Blank data
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.baseGeoId = requestPayloadCreate.baseGeoId + '&*#'
    * eval requestPayloadCreate.factorShippingPrice = '   '
    * eval requestPayloadCreate.geoId = ''
    
    And karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17039
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid values
    
    * eval requestPayloadCreate.configName = "diwali" + num + '&*#'
    * eval requestPayloadCreate.baseGeoId = requestPayloadCreate.baseGeoId + '&*#'
    * eval requestPayloadCreate.factorShippingPrice = 120
    * eval requestPayloadCreate.geoId = '@@@'
    
    And karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  @createAllocLogicAdmin
  #REV2-17038
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Valid values
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * karate.log('-------------Time is : ------------', toTime())
    * eval requestPayloadCreate.fromDate = toTime()
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    * def resId = response.id
    And match response.id == "#notnull"
    And karate.log('Response is : ', response)
    And match response.id == resId
    And karate.log('ID Matched')
    And karate.log('Status : 201')
    
    * def allocGetResult = call read('./alloc-logic-carrier-crud-superadmin-test.feature@getLogicCarrier') {page : 0, size : 300}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    #And match allocGetResult.responseData.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')
    
    
	#REV2-17964
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with valid values
    
    Given param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[*].pgId contains "2"
    And match response.data[*].geoGroupId contains "Kolkata"
    And match response.data[*].geoId contains "India"
    And karate.log('Test Completed !')


  #REV2-17965
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier with invalid values
    
    Given param geoGroupId = 'vadgaon'
    And param geoId = 'Indi'
    And param pgId = "xyz"
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Requested pgId doesn't exist -> xyz"
    And karate.log('Test Completed !')


  #REV2-17967
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier with blank values
    
    Given param geoGroupId = ' '
    And param geoId = ' '
    And param pgId = ' '
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "Invalid characters found."
    And karate.log('Test Completed !')


  #REV2-17966
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier with spaces in parameteres
    
    Given param geoGroupId = 'vadgaon'
    And param geoId = 'Indi'
    And param pgId = '   2'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found."
    And karate.log('Test Completed !')


  #REV2-17968
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier API with missing any value in mandatory parameteres
    
    Given param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And karate.log('Test Completed !')


  #REV2-17969
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier API with unsupported method
    
    Given request ''
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = 10
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')


  #REV2-17970
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier API with invalid token authorization
    
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    
    Given param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = 10
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Test Completed !')


  #REV2-17973
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier API with invalid URL
    
    Given path 'hendrix/v1/allocation-rulescarriers'
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = 10
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')


  #REV2-17978
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with missing any value in optional field
    
    Given param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = ''
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-17971
  Scenario: GET - Verify super admin user cannot fetch records of Allocation Logic configuration carrier API where authorization code not added
    
    * def invalidAuthToken = " "
    * header Authorization = invalidAuthToken
    
    Given param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = 10
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
	
	#REV2-15195
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all blank values
    
    * eval requestPayloadUpdate[0].baseGeoId = ""
    * eval requestPayloadUpdate[0].configName = ""
    * eval requestPayloadUpdate[0].deliveryMode = ""
    * eval requestPayloadUpdate[0].factorCarrierRating = ""
    * eval requestPayloadUpdate[0].factorLeadHours = ""
    * eval requestPayloadUpdate[0].factorManualRating = ""
    * eval requestPayloadUpdate[0].factorShippingPrice = ""
    * eval requestPayloadUpdate[0].fromDate = ""
    * eval requestPayloadUpdate[0].geoGroupId = ""
    * eval requestPayloadUpdate[0].geoId = ""
    * eval requestPayloadUpdate[0].id = ""
    * eval requestPayloadUpdate[0].pgId = ""
    * eval requestPayloadUpdate[0].thruDate = ""
    
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')

 	
  #REV2-15194
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all invalid values
 
    * eval requestPayloadUpdate[0].baseGeoId = "abcd123"
    * eval requestPayloadUpdate[0].configName = "abcde@123"
    * eval requestPayloadUpdate[0].deliveryMode = "www#12"
    * eval requestPayloadUpdate[0].factorCarrierRating = -55
    * eval requestPayloadUpdate[0].factorLeadHours = 101
    * eval requestPayloadUpdate[0].factorManualRating = 0
    * eval requestPayloadUpdate[0].factorShippingPrice = 100.0000000001
    * eval requestPayloadUpdate[0].fromDate = "@@@"
    * eval requestPayloadUpdate[0].geoGroupId = "aaa@#$123"
    * eval requestPayloadUpdate[0].geoId = "bcde@abc"
    * eval requestPayloadUpdate[0].id = "11111111111111111111111111"
    * eval requestPayloadUpdate[0].pgId = "aaa"
    * eval requestPayloadUpdate[0].thruDate = "@@@"
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')

  
  #REV2-15193
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all valid values
   
    * def postResult = call read('./alloc-logic-carrier-crud-superadmin-test.feature@createAllocLogicAdmin')
    * def resId = postResult.resId
    
    * eval requestPayloadUpdate[0].id = resId
    * eval requestPayloadUpdate[0].fromDate = toTime()
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
    
    * def allocGetResult = call read('./alloc-logic-carrier-crud-superadmin-test.feature@getLogicCarrierAfterUpdate') {page : 0, size : 500}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Updated Data on the respected ID present in GET method **************")
    And karate.log('Test Completed !')
	