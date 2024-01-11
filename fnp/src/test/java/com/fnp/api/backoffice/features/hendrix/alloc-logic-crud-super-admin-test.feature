 Feature: Allocation Logic create, read, update, delete with Super Admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayloadPostFC = read('classpath:com/fnp/api/backoffice/data/allocation-logic-post-fc.json')
    * def requestPayloadPostCarrier = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')[0]
    * def requestPayloadPutCarrier = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')[1]
    * def requestPayloadPostDuplicate = read(' classpath:com/fnp/api/backoffice/data/alloc-logic-post-duplicate.json')
    * def requestPayloadPutFC = read('classpath:com/fnp/api/backoffice/data/alloc-logic-put-fc.json')
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def page1 = 0
    * def size1 = 1000
    * def toTime =
      """
      	function(s) {
       		var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
       		var sdf = new SimpleDateFormat("dd-MM-yyyy");
       		return sdf.format(new java.util.Date());           
      	}
      """

  #POST FC, POST CR, POST Duplicate 
  @getLogicPostFc
  Scenario: GET - To Verify if Created data is getting displayed in GET method
    
    Given path '/fcs'
    And param geoGroupId = requestPayloadPostFC.geoGroupId
    And param geoId = requestPayloadPostFC.geoId
    And param pgId = requestPayloadPostFC.pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-16966
  Scenario: POST - Verify Allocation Logic POST FC Rule for Same date and time for fromDate and thruDate
    
    * eval requestPayloadPostFC.fromDate = toTime()
    * eval requestPayloadPostFC.thruDate = requestPayloadPostFC.fromDate
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    
    Given path '/fcs'
    And request requestPayloadPostFC
    And karate.log(requestPayloadPostFC)
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

  
  #REV2-16965
  Scenario: POST - Verify Allocation Logic POST FC Rule for From Date greater than Thru Date
  
    * eval requestPayloadPostFC.fromDate = '15-12-2022'
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC   
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16964
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for thruDate
  
  	* eval requestPayloadPostFC.thruDate = "12-13-2022"
  	* karate.log(requestPayloadPostFC)
  	
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response.errors)
    
    * eval requestPayloadPostFC.thruDate = "0"
    * karate.log(requestPayloadPostFC)
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16963
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for fromDate
  
    * eval requestPayloadPostFC.fromDate = "32-12-2022"
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadPostFC.fromDate = "32-12-2022"
    * karate.log(requestPayloadPostFC)
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16961
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid data in request body
  
    * eval requestPayloadPostFC.xyz = "xyz"
    * eval requestPayloadPostFC.idddd = "1234"
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC    
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16958
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid URL
  
    Given path '/fc/aaa'
    And request requestPayloadPostFC
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == "#notnull"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')

 
  #REV2-16956
  Scenario: POST - Verify Allocation Logic POST FC Rule when Auth code not added for Super Admin
  
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
	  
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-16955
  Scenario: POST - Verify Allocation Logic POST FC Rule when Invalid Auth token given for Super Admin
  
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    
    * header Authorization = saveToken
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

   
  #REV2-16954
  Scenario: POST - Verify Allocation Logic POST FC Rule for Unsupported Method
  
    Given path '/fcs'
    And request requestPayloadPostFC
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
   
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayloadPostFC
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

  
  #REV2-16953
  Scenario: POST - Verify Allocation Logic POST FC Rule for missing any value in any mandatory fields
   
    * eval requestPayloadPostFC.configName = ''
    * eval requestPayloadPostFC.geoGroupId = ''
    * eval requestPayloadPostFC.pgId = ''
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "The Geo group field is mandatory"
    And match response.errorCount == 3
    And karate.log('Test Completed !')

 
  #REV2-16951
  Scenario: POST - Verify Allocation Logic POST FC Rule with only mandatory fields
  
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    * eval requestPayloadPostFC.fromDate = toTime()
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-super-admin-test.feature@getLogicPostFc')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')

 	 
  #REV2-16948
  Scenario: POST - Verify Allocation Logic POST FC Rule with duplicate values
  	
  	* karate.log(requestPayloadPostFC)
  	
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'The Config name is already in use.'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16947
  Scenario: POST - Verify Allocation Logic POST FC Rule with blank values
  
    * eval requestPayloadPostFC.baseGeoId = ""
    * eval requestPayloadPostFC.configName = ""
    * eval requestPayloadPostFC.deliveryMode = ""
    * eval requestPayloadPostFC.factorCapacityDone = ""
    * eval requestPayloadPostFC.factorDistance = ""
    * eval requestPayloadPostFC.factorFCRating = ""
    * eval requestPayloadPostFC.factorManualRating = ""
    * eval requestPayloadPostFC.factorPrice = ""
    * eval requestPayloadPostFC.geoGroupId = ""
    * eval requestPayloadPostFC.geoId = ""
    * eval requestPayloadPostFC.pgId = ""
    
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And match response.errors[*].message contains "factorFCRating should not be null."
    And match response.errors[*].message contains "factorPrice should not be null."
    And match response.errors[*].message contains "baseGeoId should not be blank."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "The Geo group field is mandatory"
    And match response.errors[*].message contains "factorManualRating should not be null."
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errors[*].message contains "The Geography field is mandatory."
    And match response.errors[*].message contains "factorDistance should not be null."
    And match response.errors[*].message contains "factorCapacityDone should not be null."
    And karate.log('Test Completed !')

  
  #REV2-16946
  Scenario: POST - Verify Allocation Logic POST FC Rule with combination of valid/Invalid/Spaces/Blank data
  
    * eval requestPayloadPostFC.configName = "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    * eval requestPayloadPostFC.baseGeoId = requestPayloadPostFC.baseGeoId + '&*#'
    * eval requestPayloadPostFC.factorDistance = '   '
    * eval requestPayloadPostFC.geoId = ''
    * eval requestPayloadPostFC.pgId = 'wwr'
    
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
  #REV2-16944
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid values
  
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num + '&*#'
    * eval requestPayloadPostFC.baseGeoId = requestPayloadPostFC.baseGeoId + '&*#'
    * eval requestPayloadPostFC.factorCapacityDone = 101
    * eval requestPayloadPostFC.factorDistance = 0
    * eval requestPayloadPostFC.factorFCRating = -130
    * eval requestPayloadPostFC.factorManualRating = 2222
    * eval requestPayloadPostFC.factorPrice = -555
    * eval requestPayloadPostFC.fromDate = "2021-12-35T10:02:31"
    * eval requestPayloadPostFC.geoGroupId = "abc_xyz@a"
    * eval requestPayloadPostFC.geoId = '@@@'
    * eval requestPayloadPostFC.pgId = 'abcd12'
    * eval requestPayloadPostFC.thruDate = "0T28:65:888"
    
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

    
  #REV2-16943
  @createAllocLogicFc
  Scenario: POST - Verify Allocation Logic POST FC Rule with Valid values
    
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    * eval requestPayloadPostFC.fromDate = toTime()
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-super-admin-test.feature@getLogicPostFc') 
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')

  
  @getLogicPostCarrier
  Scenario: GET - To Verify if Created data is getting displayed in GET method
    
    Given path '/carriers'
    And param geoGroupId = requestPayloadPostCarrier.geoGroupId
    And param geoId = requestPayloadPostCarrier.geoId
    And param pgId = requestPayloadPostCarrier.pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  
  #REV2-17061
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for Same date and time for fromDate and thruDate
  
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num
    * eval requestPayloadPostCarrier.fromDate = toTime()
    * eval requestPayloadPostCarrier.thruDate = requestPayloadPostCarrier.fromDate
    
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

  
  #REV2-17060
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for From Date greater than Thru Date
  
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num
    * eval requestPayloadPostCarrier.fromDate = '15-12-2022'
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    And karate.log(requestPayloadPostCarrier)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17059
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for thruDate
  
    * eval requestPayloadPostCarrier.thruDate = "12-13-2022"
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadPostCarrier.thruDate = "0"
    * karate.log(requestPayloadPostCarrier)
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17058
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for fromDate
  
    * eval requestPayloadPostCarrier.fromDate = "32-12-2022"
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadPostCarrier.fromDate = "0"
    * karate.log(requestPayloadPostCarrier)
    
    * header Authorization = authToken
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17056
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid data in request body
  
    * eval requestPayloadPostCarrier.abc = "wwwww"
    * eval requestPayloadPostCarrier.idddd = "hghftydfthg"
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == '#notnull'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17053
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid URL
  
    Given path '/carrier'
    And request requestPayloadPostCarrier
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
 
  
  #REV2-17051
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Auth code not added
  
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-17050
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Invalid Auth token given for Super Admin
  
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-17049
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for Unsupported Method
  
    Given path '/carriers'
    And request requestPayloadPostCarrier
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
  
    * eval requestPayloadPostCarrier.configName = ''
    * eval requestPayloadPostCarrier.geoGroupId = ''
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == '#notnull'
    And match response.errorCount == 2
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17046
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with only mandatory fields
  
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num
    * eval requestPayloadPostCarrier.fromDate = toTime()
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Response is :',response)
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-super-admin-test.feature@getLogicPostCarrier') 
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')

  
  #REV2-17043
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with duplicate values
  	
  	* karate.log(requestPayloadPostCarrier)
  	
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'The Config name is already in use.'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17042
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with blank values
  
    * eval requestPayloadPostCarrier.baseGeoId = ""
    * eval requestPayloadPostCarrier.configName = ""
    * eval requestPayloadPostCarrier.deliveryMode = ""
    * eval requestPayloadPostCarrier.factorCarrierRating = ""
    * eval requestPayloadPostCarrier.factorLeadHours = ""
    * eval requestPayloadPostCarrier.factorManualRating = ""
    * eval requestPayloadPostCarrier.factorShippingPrice = ""
    * eval requestPayloadPostCarrier.geoGroupId = ""
    * eval requestPayloadPostCarrier.geoId = ""
    * eval requestPayloadPostCarrier.pgId = ""
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier 
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
  
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num
    * eval requestPayloadPostCarrier.baseGeoId = requestPayloadPostCarrier.baseGeoId + '&*#'
    * eval requestPayloadPostCarrier.factorShippingPrice = '   '
    * eval requestPayloadPostCarrier.geoId = ''
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier  
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17039
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid values
  
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num + '&*#'
    * eval requestPayloadPostCarrier.baseGeoId = requestPayloadPostCarrier.baseGeoId + '&*#'
    * eval requestPayloadPostCarrier.factorShippingPrice = 120
    * eval requestPayloadPostCarrier.geoId = '@@@'
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-17038
  @createAllocLogicCarrier
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Valid values
   
    * eval requestPayloadPostCarrier.configName = requestPayloadPostCarrier.configName + num
    * eval requestPayloadPostCarrier.fromDate = toTime()
    * karate.log(requestPayloadPostCarrier)
    
    Given path '/carriers'
    And request requestPayloadPostCarrier
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Response is :',response)
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-super-admin-test.feature@getLogicPostCarrier') 
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')

 
  #REV2-14735
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with valid values
  
    * eval requestPayloadPostDuplicate.fromDate = toTime()
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('ID Matched')
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

  
  #REV2-14743
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for Unsupported Method
  
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

  
  #REV2-14749
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all fields with spaces
  
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds = '   '
    * eval requestPayloadPostDuplicate.applyToPgIds = '  '
    * eval requestPayloadPostDuplicate.baseGeoId = '  '
    * eval requestPayloadPostDuplicate.configName = ' '
    * eval requestPayloadPostDuplicate.fromDate = '   '
    * eval requestPayloadPostDuplicate.sourceRuleId = ' '
    * eval requestPayloadPostDuplicate.thruDate = '   '
    * eval requestPayloadPostDuplicate.vendorType = '   '
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-14747
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with Invalid data in request body
  
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds = 170
    * eval requestPayloadPostDuplicate.pgId = "wwwww"
    * eval requestPayloadPostDuplicate.baseGeoId = "hghftydfthg"
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == '#notnull'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
  #REV2-14741
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with Invalid URL
  
    Given path '/_abcdefgh'
    And request requestPayloadPostDuplicate
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')

 	  
  #REV2-14742(bugid-REV2-25857)
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for missing any value in any mandatory field
  
    * eval requestPayloadPostDuplicate.configName = ''
    * eval requestPayloadPostDuplicate.baseGeoId = ''
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == '#notnull'
    And match response.errorCount == 2
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

    
  #REV2-14738
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all blank fields
  
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds = ''
    * eval requestPayloadPostDuplicate.applyToPgIds = ''
    * eval requestPayloadPostDuplicate.baseGeoId = ''
    * eval requestPayloadPostDuplicate.configName = ''
    * eval requestPayloadPostDuplicate.fromDate = ''
    * eval requestPayloadPostDuplicate.sourceRuleId = ''
    * eval requestPayloadPostDuplicate.thruDate = ''
    * eval requestPayloadPostDuplicate.vendorType = ''
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-14737
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for any of the invalid field
  
    * eval requestPayloadPostDuplicate.configName = "holi" + num
    * eval requestPayloadPostDuplicate.baseGeoId = requestPayloadPostDuplicate.baseGeoId + '&*#'
    * eval requestPayloadPostDuplicate.fromDate = toTime()
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-14736
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all the invalid fields
  
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds = requestPayloadPostDuplicate.baseGeoId + '&*#'
    * eval requestPayloadPostDuplicate.applyToPgIds = requestPayloadPostDuplicate.applyToPgIds + '@#'
    * eval requestPayloadPostDuplicate.configName = requestPayloadPostDuplicate.configName + 'ssdfffffffffffffffff'
    * eval requestPayloadPostDuplicate.baseGeoId = requestPayloadPostDuplicate.baseGeoId + '&*#'
    * eval requestPayloadPostDuplicate.fromDate = toTime()
    * eval requestPayloadPostDuplicate.sourceRuleId = requestPayloadPostDuplicate.sourceRuleId + 'qwweeeee'
    * eval requestPayloadPostDuplicate.thruDate = requestPayloadPostDuplicate.thruDate
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #GET FC, GET CR
  #REV2-17964
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with valid values
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
  #REV2-17965
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier with invalid values
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 'xyz'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Requested pgId doesn't exist -> xyz"
    And karate.log('Test Completed !')

	
  #REV2-17967
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier with blank values
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = ''
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param pgId = 'xyz'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
    And karate.log('Test Completed !')


  #REV2-17966
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier with spaces in parameteres
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = ' India'
    And param operator = 'EQUAL_TO'
    And param pgId = ' 2'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found."
    And karate.log('Test Completed !')

	
  #REV2-17968
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with missing any value in mandatory parameteres
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = ''
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param pgId = ''
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
  	And match response.errors[*].message contains "The Product Group field is mandatory."
    And karate.log('Test Completed !')

	
  #REV2-17969
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with unsupported method
  
    Given request ''
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')

	
  #REV2-17970
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with invalid token authorization
  
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
    
  #REV2-17971
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API where authorization code not added
  
    * def invalidAuthToken = " "
    * header Authorization = invalidAuthToken
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')

	
  #REV2-17973
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with invalid URL
    
    Given path '/cr'
   	And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')

	
  #REV2-17978
  Scenario: GET - Verify super admin user can fetch records of Allocation Logic configuration carrier API with missing any value in optional field
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = ''
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
	

  #PUT FC, PUT CR
  @getLogicUpdateFC
  Scenario: GET - To Verify if Updated data is getting displayed in GET method
    
    Given path '/fcs'
    And param geoGroupId = requestPayloadPutFC[0].geoGroupId
    And param geoId = requestPayloadPutFC[0].geoId
    And param pgId = requestPayloadPutFC[0].pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-14937
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with all blank values
  
    * eval requestPayloadPutFC[0].baseGeoId = ""
    * eval requestPayloadPutFC[0].configName = ""
    * eval requestPayloadPutFC[0].deliveryMode = ""
    * eval requestPayloadPutFC[0].factorCapacityDone = ""
    * eval requestPayloadPutFC[0].factorDistance = ""
    * eval requestPayloadPutFC[0].factorFCRating = ""
    * eval requestPayloadPutFC[0].factorManualRating = ""
    * eval requestPayloadPutFC[0].factorPrice = ""
    * eval requestPayloadPutFC[0].geoGroupId = ""
    * eval requestPayloadPutFC[0].geoId = ""
    * eval requestPayloadPutFC[0].id = ""
    * eval requestPayloadPutFC[0].pgId = ""
    
    Given path '/fcs'
    And request requestPayloadPutFC
    And karate.log("Updated data - ",requestPayloadPutFC)
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And match response.errors[*].message contains "factorFCRating should not be null."
    And match response.errors[*].message contains "factorPrice should not be null."
    And match response.errors[*].message contains "baseGeoId should not be blank."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And match response.errors[*].message contains "factorManualRating should not be null."
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errors[*].message contains "The Geography field is mandatory."
    And match response.errors[*].message contains "factorDistance should not be null."
    And match response.errors[*].message contains "factorCapacityDone should not be null."
    And karate.log('Test Completed !')

	
  #REV2-14936
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with all invalid values

    * eval requestPayloadPutFC[0].baseGeoId = "aabbcc@12"
    * eval requestPayloadPutFC[0].configName = "abcde_*123"
    * eval requestPayloadPutFC[0].deliveryMode = "12@abc"
    * eval requestPayloadPutFC[0].factorCapacityDone = -55
    * eval requestPayloadPutFC[0].factorDistance = 101
    * eval requestPayloadPutFC[0].factorFCRating = 0
    * eval requestPayloadPutFC[0].factorManualRating = 100.0000000001
    * eval requestPayloadPutFC[0].factorPrice = -1.000000001
    * eval requestPayloadPutFC[0].fromDate = "1997-14-12T05:00:41"
    * eval requestPayloadPutFC[0].geoGroupId = "aaa@#$123"
    * eval requestPayloadPutFC[0].geoId = "bcde@abc"
    * eval requestPayloadPutFC[0].id = "1"
    * eval requestPayloadPutFC[0].pgId = "aaa"
    * eval requestPayloadPutFC[0].thruDate = "@@@"
    * karate.log("Updated data - ",requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')


  #REV2-14935
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with all valid values

    * def postResult = call read('./alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def resId = postResult.response.id
    * eval requestPayloadPutFC[0].id = resId
    * eval requestPayloadPutFC[0].configName = requestPayloadPutFC[0].configName + num
    * eval requestPayloadPutFC[0].fromDate = toTime()
    
    Given path '/fcs'
    And request requestPayloadPutFC
    And karate.log("Updated data - ",requestPayloadPutFC)
    When method put
    Then status 200
    And karate.log('Response is :',response)
    And karate.log('Status : 200')
    And match response.message == 'Record(s) Updated Successfully.'
   
    * def allocGetResult = call read('./alloc-logic-crud-super-admin-test.feature@getLogicUpdateFC') 
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Updated Data on the respected ID present in GET method **************")
    And karate.log('Test Completed !')

  
  @getLogicUpdateCR
  Scenario: GET - To Verify if Updated data is getting displayed in GET method
  
    Given path '/carriers'
    And param geoGroupId = requestPayloadPutCarrier[0].geoGroupId
    And param geoId = requestPayloadPutCarrier[0].geoId
    And param pgId = requestPayloadPutCarrier[0].pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-15195
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all blank values
  
    * eval requestPayloadPutCarrier[0].baseGeoId = ""
    * eval requestPayloadPutCarrier[0].configName = ""
    * eval requestPayloadPutCarrier[0].deliveryMode = ""
    * eval requestPayloadPutCarrier[0].factorCarrierRating = ""
    * eval requestPayloadPutCarrier[0].factorLeadHours = ""
    * eval requestPayloadPutCarrier[0].factorManualRating = ""
    * eval requestPayloadPutCarrier[0].factorShippingPrice = ""
    * eval requestPayloadPutCarrier[0].geoGroupId = ""
    * eval requestPayloadPutCarrier[0].geoId = ""
    * eval requestPayloadPutCarrier[0].id = ""
    * eval requestPayloadPutCarrier[0].pgId = ""

    Given path '/carriers'
    And request requestPayloadPutCarrier
    And karate.log("Updated data - ",requestPayloadPutCarrier)
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "factorCarrierRating should not be null."
    And match response.errors[*].message contains "factorShippingPrice should not be null."
    And match response.errors[*].message contains "baseGeoId should not be empty."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "The Geo group field is mandatory."
    And match response.errors[*].message contains "factorLeadHours should not be null."
    And match response.errors[*].message contains "configName should not be empty."
    And match response.errors[*].message contains "The Geography field is mandatory."
    And match response.errors[*].message contains "factorManualRating should not be null."
    And karate.log('Test Completed !')

  
  #REV2-15194
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all invalid values
  
    * eval requestPayloadPutCarrier[0].baseGeoId = "abcd123"
    * eval requestPayloadPutCarrier[0].configName = "abcde@123"
    * eval requestPayloadPutCarrier[0].deliveryMode = "www#12"
    * eval requestPayloadPutCarrier[0].factorCarrierRating = -55
    * eval requestPayloadPutCarrier[0].factorLeadHours = 101
    * eval requestPayloadPutCarrier[0].factorManualRating = 0
    * eval requestPayloadPutCarrier[0].factorShippingPrice = 100.0000000001
    * eval requestPayloadPutCarrier[0].fromDate = "@@@"
    * eval requestPayloadPutCarrier[0].geoGroupId = "aaa@#$123"
    * eval requestPayloadPutCarrier[0].geoId = "bcde@abc"
    * eval requestPayloadPutCarrier[0].id = "11111111111111111111111111"
    * eval requestPayloadPutCarrier[0].pgId = "aaa"
    * eval requestPayloadPutCarrier[0].thruDate = "@@@"
    * karate.log("Updated data - ",requestPayloadPutCarrier)
    
    Given path '/carriers'
    And request requestPayloadPutCarrier
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')

  
  #REV2-15193
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all valid values
  
    * def postResult = call read('./alloc-logic-crud-super-admin-test.feature@createAllocLogicCarrier')
    * def resId = postResult.response.id
    * eval requestPayloadPutCarrier[0].id = resId
    * eval requestPayloadPutCarrier[0].fromDate = toTime()
    * eval requestPayloadPutCarrier[0].configName = "newYear" + num
    
    Given path '/carriers'
    And request requestPayloadPutCarrier
    And karate.log("Updated data - ",requestPayloadPutCarrier)
    When method put
    Then status 200
    And karate.log('Response is :',response)
    And karate.log('Status : 200')
    And match response.message == 'Record(s) Updated Successfully.'
   
    * def allocGetResult = call read('./alloc-logic-crud-super-admin-test.feature@getLogicUpdateCR') 
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Updated Data on the respected ID present in GET method **************")
    And karate.log('Test Completed !')
    
 #Delete
 #REV2-14537
  Scenario: DELETE - Verify user can delete record with valid  id
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 200
    And karate.log('Response is : ', response)
    And match response.message == "Record(s) Deleted Successfully."
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
     
  #REV2-14543   
  Scenario: DELETE - verify that user can delete record with  invalid url
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path 'al/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 404
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
  
  #REV2-14542
  Scenario: DELETE - Validate user can delete id with duplicate id
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/' +deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 200
    And karate.log('Response is : ', response)
    
    * header Authorization = authToken
    Given path 'hendrix/v1/allocation-rules/id/'+deletedId
   
    #Given path '/'+deletedId
    And param vendorType = 'FC'
    
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')
    
  #REV2-14541
  @deleteblankId
  Scenario: DELETE - verify that user can delete record with spaces in param
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'F   C'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Vendor Type Has Unknown Value, Allowed Values -> FC,CR"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
   #REV2-14539
  Scenario: DELETE - verify that user can delete record with blank id
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@deleteblankId')
    * def deletedId = result.response.id
    Given path '/id/' +deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
    #REV2-14538
  Scenario: DELETE - verify that user can delete record with invalid id
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/133333' +deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    #REV2-14536
  Scenario: DELETE - verify that user can delete record with unsupported method
  
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/' +deletedId
    And param vendorType = 'FC'
    When method get
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
    
    #REV2-14529
   Scenario: DELETE - verify that user can delete record with invalid auth token
   
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    * def result = call read('alloc-logic-crud-super-admin-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/' +deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
    
    #**************GET FC ****************#
  	
	#REV2-17933/#REV2-29536/#REV2-29537
	Scenario: GET - Verify Super Admin can fetch Allocation Logic Configuration for FC with valid ids
   	
   	Given path '/fcs'
   	And param fieldName = 'configName'
  	And param fieldValues = 'holi0','holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10
   	When method get
   	Then status 200
   	And karate.log('Status : 200')
  	And karate.log('Test Completed !')
    
   
	#REV2-17935
	Scenario: GET - Verify Super Admin cannot fetch Allocation Logic Configuration for FC with space in parameters
	
		Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = ' 6'
  	And param page = 0
  	And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found."
    And karate.log('Test Completed !')
    
   
 	#REV2-17936
	Scenario: GET - Verify Super Admin cannot access Allocation Logic Configuration for FC with blank ids
    
    Given path '/fcs'
    When method get
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = ' '
  	And param page = 0
  	And param size = 10
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Product Group field is mandatory."
    And karate.log('Test Completed !')
    
 	
	#REV2-17939/#REV2-29541
	Scenario: GET - Verify Super Admin cannot access Allocation Logic Config for FC with Missing value in mandatory fields
    
    Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = ''
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Geography field is mandatory."
    And karate.log('Test Completed !')
    

	#REV2-17940
	Scenario: POST - Verify Super Admin cannot access Allocation Logic FC for Unsupported methods.
	
    Given path '/fcs'
    And request '' 
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
     
 
  #REV2-17941
	Scenario: GET - Verify Super Admin cannot access with Invalid authorization credential for FC
    
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    
    Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10 
    When method get
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
   
	#REV2-17942
	Scenario: GET - Verify Super Admin cannot access with Authorization code not added for FC	
	
    * def invalidAuthToken = " "
    * header Authorization = invalidAuthToken
    
		Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10 
    When method get
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains "Authentication Required"
    And karate.log('Test Completed !')
    
  
	#REV2-17944
  Scenario: GET - Verify Super Admin cannot access Allocation Logic Configuration for FC with Invalid URL
    
    Given path '/cr'
   	And param fieldName = 'configName'
  	And param fieldValues = 'holi1!'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10 
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Test Completed !')
    
  
	#REV2-17949
  Scenario: GET - Verify Super Admin can access Allocation Logic Configuration for FC with Missing value in optional fields
    
    Given path '/fcs'
   	And param fieldName = 'configName'
  	And param fieldValues = ' '
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10 
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
   #*************GET FC Search Scenarios***************#
 	
  #REV2-29535
	Scenario: GET - Verify Super admin can search Allocation Logic Configuration for FC with invalid values
    
    Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi__1a'
  	And param fieldValues = 'holi2!'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = 25
  	And param page = 0
  	And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Requested pgId doesn't exist -> 25"
    And karate.log('Test Completed !')
    
 
	#REV2-29538
	Scenario: GET - Verify Super Admin can search Allocation Logic Configuration for FC with operator not equal to in valid values
   	Given path '/fcs'
   	And param fieldName = 'configName'
  	And param fieldValues = 'holi0','holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'NOT_EQUAL_TO'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10
   	When method get
   	Then status 200
   	And karate.log('Status : 200')
  	And karate.log('Test Completed !') 
  	
 
 	#REV2-29539
	Scenario: GET - Verify Super Admin can search Allocation Logic Configuration for FC with operator contains in valid values
   	
   	Given path '/fcs'
   	And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'CONTAINS'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10
   	When method get
   	Then status 200
   	And karate.log('Status : 200')
  	And karate.log('Test Completed !')  
  
 	
 	#REV2-29540
	Scenario: GET - Verify Super Admin can search Allocation Logic Configuration for FC with operator does not contain in valid values
   	
   	Given path '/fcs'
   	And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param pgId = 6
  	And param page = 0
  	And param size = 10
   	When method get
   	Then status 200
   	And karate.log('Status : 200')
  	And karate.log('Test Completed !')  
  	
  	
  	#*************GET CARRIER SCENARIOS***************#
  	
  	
  #REV2-28910/#REV2-28915/#REV2-28916/#REV2-28917/#REV2-28918 
  Scenario: GET - Verify Super admin can search Allocation Logic Configuration for carrier with valid values
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO','NOT_EQUAL_TO','CONTAINS','DOES_NOT_CONTAIN'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    
    
  #REV2-28911
  Scenario: GET - Verify Super admin can search Allocation Logic Configuration for carrier with invalid values
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 'xyz'
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Requested pgId doesn't exist -> xyz"
    And karate.log('Test Completed !')
    
    
  #REV2-28912
  Scenario: GET - Verify Super admin can search Allocation Logic Configuration for carrier with blank values
  
    Given path '/carriers'
    And param fieldName = ''
    And param fieldValues = ''
    And param fieldValues = ''
    And param geoGroupId = ''
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
    And karate.log('Test Completed !')
    
    
  #REV2-28913
  Scenario: GET - Verify Super admin can search Allocation Logic Configuration for carrier with comma separated valid values for fields
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001','422101','422003'
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    
    
  #REV2-28919
  Scenario: GET - Verify Super admin can search Allocation Logic Configuration for carrier with missing value in mandatory fields
    
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
    And param geoGroupId = ''
    And param geoId = ''
    And param operator = 'EQUAL_TO'
    And param pgId = ''
    And param page = 0
    And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
  	And match response.errors[*].message contains "The Product Group field is mandatory."
    And karate.log('Test Completed !')
  	

    