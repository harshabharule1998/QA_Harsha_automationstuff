Feature: Allocation Logic Carrier CRUD scenarios with Allocation Manager

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/carriers'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
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
		
	
  #REV2-17077
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for From Date greater than Thru Date
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.fromDate = '15-12-2022'
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-17076
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for thruDate
    
    * eval requestPayloadCreate.thruDate = "12-13-2022"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadCreate.thruDate = "0"
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
    
    
  #REV2-17075
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
    
 
  #REV2-17074
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid data in request body
   
    * eval requestPayloadCreate.factorCarrierRating = 170
    * eval requestPayloadCreate.pgId = "wwwww"
    * eval requestPayloadCreate.baseGeoId = "hghftydfthg"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message contains "Carrier rating weightage should be between 1 to 100"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
  #REV2-17073
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid URL
    
    Given path '/hendrix/v1/allocation-rulesrriers'
    And request requestPayloadCreate
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
     
  #REV2-17072
  #BUG -ID - REV2-18549
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
    
     
  #REV2-17071
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Invalid Auth token given for Allocation Manager
    
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given request requestPayloadCreate
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    

  #REV2-17070
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with only mandatory fields
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.fromDate = toTime()
    
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
    
   
  #REV2-17069
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for duplicate values with spaces
    
    * eval requestPayloadCreate.baseGeoId = "   " + requestPayloadCreate.baseGeoId + "       "
    * eval requestPayloadCreate.configName = "   " + requestPayloadCreate.configName + "       "
    * eval requestPayloadCreate.deliveryMode = "   " + requestPayloadCreate.deliveryMode + "       "
    * eval requestPayloadCreate.geoGroupId = "   " + requestPayloadCreate.geoGroupId + "       "
    * eval requestPayloadCreate.geoId = "   " + requestPayloadCreate.geoId + "       "
    * eval requestPayloadCreate.pgId = "   " + requestPayloadCreate.pgId + "       "
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid characters found."
    And karate.log('Test Completed !')
    
  
  #REV2-17068
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with duplicate values
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'This Carrier Allocation Rule Configuration is already exist for given Vendor'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
       
  #REV2-17067
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
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
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
    And karate.log('Test Completed !')
    
    
  #REV2-17066
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with combination of valid/Invalid/Spaces/Blank data
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.baseGeoId = requestPayloadCreate.baseGeoId + '&*#'
    * eval requestPayloadCreate.factorShippingPrice = '   '
    * eval requestPayloadCreate.geoId = ''
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
  #REV2-17065
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid values
    
    * eval requestPayloadCreate.configName = "diwali" + num + '&*#'
    * eval requestPayloadCreate.baseGeoId = requestPayloadCreate.baseGeoId + '&*#'
    * eval requestPayloadCreate.factorShippingPrice = 120
    * eval requestPayloadCreate.geoId = '@@@'
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-17064
  @createAllocLogicMgr
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
    And karate.log('Test Completed !')
    
    
	#REV2-17980
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with valid values
    
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


  #REV2-17981
  Scenario: GET - Verify allocation manager user cannot fetch records of allocation logic config carrier api with invalid values
    
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


  #REV2-17983
  Scenario: GET - Verify allocation manager user cannot fetch records of allocation logic config carrier api with blank values
    
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


  #REV2-17982
  Scenario: GET - Verify allocation manager user cannot fetch records of allocation logic config carrier api with spaces in parametres
    
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


  #REV2-17987
  Scenario: GET - Verify allocation manager user cannot fetch records of allocation logic config carrier api with missing values in mandatory field
    
    Given param geoGroupId = ''
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And karate.log('Test Completed !')


  #REV2-17984
  Scenario: GET - Verify allocation manager user cannot fetch records of allocation logic config carrier api with invalid authorization token
    
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


  #REV2-17985
  Scenario: GET - Verify allocation manager user cannot fetch records of allocation logic config carrier api whrere authorization code not added
    
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


  #REV2-17987
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with  missing any value in optional field
    
    Given param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = '2'
    And param page = 0
    And param size = ''
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[*].pgId contains "2"
    And match response.data[*].geoGroupId contains "Kolkata"
    And match response.data[*].geoId contains "India"
    And karate.log('Test Completed !')


	#REV2-15208
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with invalid data in request body
    
    * eval requestPayloadUpdate[0].fromDate = toTime()
    * eval requestPayloadUpdate[0].xyz = "wwww"
    * eval requestPayloadUpdate[0].namee = "321"
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log("Response is : ", response)
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15205
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

    	
  #REV2-15204
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all invalid values
    
    * eval requestPayloadUpdate[0].configName = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    * eval requestPayloadUpdate[0].factorCarrierRating = 0
    * eval requestPayloadUpdate[0].factorShippingPrice = 120
    * eval requestPayloadUpdate[0].geoGroupId = "@#@#"
    * eval requestPayloadUpdate[0].id = "123"
    * eval requestPayloadUpdate[0].pgId = "www"
    
    * karate.log("Updated data - ",requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And match response.errors[*].message contains "Invalid characters found."
    And match response.errors[*].message contains "Carrier rating weightage should be between 1 to 100."
    And match response.errors[*].message contains "Shipping price weightage should be between 1 to 100."
    And match response.errors[*].message contains "Size should be less than 30."
    And karate.log('Test Completed !')

  
  #REV2-15203
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all valid values
    
    * def postResult = call read('./alloc-logic-carrier-crud-allocmanager-test.feature@createAllocLogicMgr')
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


  #REV2-15201
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule when Invalid Auth token given for Allocation Manager
  
    * eval requestPayloadUpdate[0].fromDate = toTime()
    * karate.log("Updated data - ",requestPayloadUpdate)
    
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    
    * header Authorization = saveToken
    
    Given request requestPayloadUpdate
    When method put
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-15200
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with unsupported method
  
    * eval requestPayloadUpdate.fromDate = toTime()
    * karate.log("Updated data - ", requestPayloadUpdate)
    
    Given request requestPayloadUpdate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadUpdate
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

  
  #REV2-15198
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with Invalid URL
  
    Given path '/hendrix/v1/aaaabbbbb'
    And request requestPayloadUpdate
    When method put
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')	
    