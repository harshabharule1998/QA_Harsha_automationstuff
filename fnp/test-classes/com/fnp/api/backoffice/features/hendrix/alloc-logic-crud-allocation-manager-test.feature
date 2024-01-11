Feature: Create order,get,edit and delete it by Allocation Manager user role.

  Background: 
    Given url backOfficeAPIBaseUrl
    And path 'hendrix/v1/allocation-rules'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocMgr"}
    * def token = loginResult.accessToken
    * header Authorization = token
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
    * def requestPayloadPostFC = read('classpath:com/fnp/api/backoffice/data/allocation-logic-post-fc.json')
    * def requestPayloadPostCR = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')[0]
    * def requestPayloadPostDuplicate = read('classpath:com/fnp/api/backoffice/data/alloc-logic-post-duplicate.json')
    * def requestPayloadPutCR = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')[1]
    * def requestPayloadPutFC = read('classpath:com/fnp/api/backoffice/data/alloc-logic-put-fc.json')


  #******************** POST FC, POST CR *********************#
  
  @postFCgetLogic
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


  #REV2-16982
  Scenario: POST - Verify Allocation Logic POST FC Rule for From Date greater than Thru Date
    
    * eval requestPayloadPostFC.fromDate = '15-12-2022'
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Test Completed !')


  #REV2-16981
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for thruDate
    
    * eval requestPayloadPostFC.thruDate = "12-13-2022"
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC    
    When method post
    Then status 400
    And karate.log('Response is : ', response.errors)
    
    * eval requestPayloadPostFC.thruDate = "12-13-2022"
    * karate.log(requestPayloadPostFC)
    
    * header Authorization = token
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16980
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
    
    * header Authorization = token
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16979
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid data in request body
    
    * eval requestPayloadPostFC.xyz = "xyz"
    * eval requestPayloadPostFC.fromDate1 = "1234"
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16978
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid URL
    
    Given path '/fc'
    And request requestPayloadPostFC
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == "#notnull"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


  #REV2-16977
  Scenario: POST - Verify Allocation Logic POST FC Rule when Auth code not added for Allocation Manager
    
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


  #REV2-16976
  Scenario: POST - Verify Allocation Logic POST FC Rule when Invalid Auth credential given for Allocation Manager
    
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    * eval loginResult.accessToken = token + "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.token
    
    * header Authorization = saveToken
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

	
  #REV2-16975
  Scenario: POST - Verify Allocation Logic POST FC Rule with only mandatory fields
    
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    * eval requestPayloadPostFC.fromDate = toTime()
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Status : 201')
    And karate.log('Response is : ', response)
    And karate.log('POST ID is : ',response.id)
    
    * def resId = response.id
    * def allocGetResult = call read('alloc-logic-crud-allocation-manager-test.feature@postFCgetLogic')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')


  #REV2-16973
  Scenario: POST - Verify Allocation Logic POST FC Rule with duplicate data
    
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'The Config name is already in use.'
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16972
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


  #REV2-16971
  Scenario: POST - Verify Allocation Logic POST FC Rule with combination of valid/Invalid/Spaces/Blank data
    
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num + '&*#'
    * eval requestPayloadPostFC.baseGeoId = ''
    * eval requestPayloadPostFC.factorDistance = '101'
    * eval requestPayloadPostFC.geoId = '  '
    * eval requestPayloadPostFC.pgId = '123#@'
    * karate.log(requestPayloadPostFC)
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16970
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid values
    
    * eval requestPayloadPostFC.configName = "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    * eval requestPayloadPostFC.baseGeoId = '&*#' + requestPayloadPostFC.baseGeoId
    * eval requestPayloadPostFC.factorCapacityDone = 0
    * eval requestPayloadPostFC.factorDistance = 111
    * eval requestPayloadPostFC.factorFCRating = -0
    * eval requestPayloadPostFC.factorManualRating = 2222
    * eval requestPayloadPostFC.factorPrice = -5
    * eval requestPayloadPostFC.geoGroupId = "abc_xyz@a"
    * eval requestPayloadPostFC.geoId = '@@@'
    * eval requestPayloadPostFC.pgId = 'abcd12'
    
    Given path '/fcs'
    And request requestPayloadPostFC
    And karate.log(requestPayloadPostFC)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-16969
  @createAllocLogicFc
  Scenario: POST - Verify Allocation Logic POST FC Rule with Valid values
  
    * eval requestPayloadPostFC.configName = requestPayloadPostFC.configName + num
    * eval requestPayloadPostFC.fromDate = toTime()
    * karate.log('-------------Time is : ------------', toTime())
    
    Given path '/fcs'
    And request requestPayloadPostFC
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-allocation-manager-test.feature@postFCgetLogic')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')
    
    
  @getLogicPostCarrier
  Scenario: GET - To Verify if Created data is getting displayed in GET method
    
    Given path '/carriers'
    And param geoGroupId = requestPayloadPostCR.geoGroupId
    And param geoId = requestPayloadPostCR.geoId
    And param pgId = requestPayloadPostCR.pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    


  #REV2-17077
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for From Date greater than Thru Date
    
    * eval requestPayloadPostCR.configName = "diwali" + num
    * eval requestPayloadPostCR.fromDate = '15-12-2022'
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Test Completed !')


  #REV2-17076
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for thruDate
    
    * eval requestPayloadPostCR.thruDate = "12-13-2022"
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadPostCR.thruDate = "12-13-2022"
    * karate.log(requestPayloadPostCR)
    
    * header Authorization = token
    
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17075
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid Date for fromDate
    
    * eval requestPayloadPostCR.fromDate = "32-12-2022"
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    
    * eval requestPayloadPostCR.fromDate = "32-12-2022"
    * karate.log(requestPayloadPostCR)
    
    * header Authorization = token
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17074
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid data in request body
    
    * eval requestPayloadPostCR.factorCarrierRating = 170
    * eval requestPayloadPostCR.pgId = "wwwww"
    * eval requestPayloadPostCR.baseGeoId = "hghftydfthg"
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == '#notnull'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17073
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid URL
    
    Given path '/hendrix/v1/allocation-rulesrriers'
    And request requestPayloadPostCR
    When method post
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == '#notnull'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


  #REV2-17072
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Auth code not added
    
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    * eval requestPayloadPostCR.configName = "diwali" + num
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errorId == '#notnull'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')


  #REV2-17071
  Scenario: POST - Verify Allocation Logic POST Carrier Rule when Invalid Auth token given for Allocation Manager
    
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

	
  #REV2-17070
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with only mandatory fields
    
    * eval requestPayloadPostCR.configName = requestPayloadPostCR.configName + num
    * eval requestPayloadPostCR.fromDate = toTime()
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Response is :',response)
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-allocation-manager-test.feature@getLogicPostCarrier')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')
    
    
  #REV2-17069
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for duplicate values with spaces
    
    * eval requestPayloadPostCR.baseGeoId = "   " + requestPayloadPostCR.baseGeoId + "       "
    * eval requestPayloadPostCR.configName = "   " + requestPayloadPostCR.configName + "       "
    * eval requestPayloadPostCR.deliveryMode = "   " + requestPayloadPostCR.deliveryMode + "       "
    * eval requestPayloadPostCR.geoGroupId = "   " + requestPayloadPostCR.geoGroupId + "       "
    * eval requestPayloadPostCR.geoId = "   " + requestPayloadPostCR.geoId + "       "
    * eval requestPayloadPostCR.pgId = "   " + requestPayloadPostCR.pgId + "       "
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17068
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with duplicate values
    
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'The Config name is already in use.'
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17067
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with blank values
    
    * eval requestPayloadPostCR.baseGeoId = ""
    * eval requestPayloadPostCR.configName = ""
    * eval requestPayloadPostCR.deliveryMode = ""
    * eval requestPayloadPostCR.factorCarrierRating = ""
    * eval requestPayloadPostCR.factorLeadHours = ""
    * eval requestPayloadPostCR.factorManualRating = ""
    * eval requestPayloadPostCR.factorShippingPrice = ""
    * eval requestPayloadPostCR.geoGroupId = ""
    * eval requestPayloadPostCR.geoId = ""
    * eval requestPayloadPostCR.pgId = ""
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
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
    
    * eval requestPayloadPostCR.configName = "diwali" + num
    * eval requestPayloadPostCR.baseGeoId = requestPayloadPostCR.baseGeoId + '&*#'
    * eval requestPayloadPostCR.factorShippingPrice = '   '
    * eval requestPayloadPostCR.geoId = ''
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-17065
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Invalid values
    
    * eval requestPayloadPostCR.configName = "diwali" + num + '&*#'
    * eval requestPayloadPostCR.baseGeoId = requestPayloadPostCR.baseGeoId + '&*#'
    * eval requestPayloadPostCR.factorShippingPrice = 120
    * eval requestPayloadPostCR.geoId = '@@@'
    * karate.log(requestPayloadPostCR)
    
    Given path '/carriers'
    And request requestPayloadPostCR
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-17064
  @createAllocLogicCarrier
  Scenario: POST - Verify Allocation Logic POST Carrier Rule with Valid values
    
		* eval requestPayloadPostCR.configName = requestPayloadPostCR.configName + num
    * eval requestPayloadPostCR.fromDate = toTime()
    
    Given path '/carriers'
    And karate.log(requestPayloadPostCR)
    And request requestPayloadPostCR
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Response is :',response)
    And karate.log('Status : 201')
    
    * def resId = response.id
    * def allocGetResult = call read('./alloc-logic-crud-allocation-manager-test.feature@getLogicPostCarrier')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')
    
  #*************************POST duplicate *****************************#
  
  #REV2-14751
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

  #REV2-14757
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

  #REV2-14755
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for missing any mandatory field
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds = ''
    * eval requestPayloadPostDuplicate.applyToPgIds = ''
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

  #REV2-14754
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

  #REV2-14753
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

  #REV2-14752
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

  #REV2-14744
  Scenario: POST - Verify Allocation Logic POST duplicate Rule when Invalid Auth token given
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    And karate.log(requestPayloadPostDuplicate)
    When method post
    Then status 401
    And karate.log('Response is : ', response.errors)
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  #************************* GET FC, GET CR ********************#
 	
  #REV2-17980
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with valid values
  
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
    
	
  #REV2-17981
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with invalid values
  
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
    
	
  #REV2-17982
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with spaces in parametres
  
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
   
    
  #REV2-17983
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with blank values
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = 411001
    And param fieldValues = 411003
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
    
    
  #REV2-17984
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with invalid authorization token
  
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
    
	
  #REV2-17985
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api whrere authorization code not added
  
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
    And karate.log('Test Completed !')
    
	
  #REV2-17986
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with  missing any value in optional field
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValue = 411001
    And param fieldValues = 411003
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = ''
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 200
  
   
  #REV2-17987
  Scenario: GET - Verify allocation manager user can fetch records of allocation logic config carrier api with missing values in mandatory field
    
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
    
   
  #********************PUT FC,PUT CR ******************#
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
	
	
  #REV2-14950
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with invalid data in request body
    
    * eval requestPayloadPutFC[0].fromDate = toTime()
    * eval requestPayloadPutFC[0].xyz = "wwww"
    * eval requestPayloadPutFC[0].id1 = "321"
    * karate.log("Updated data - ",requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
  #REV2-14947
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with all blank values
    
    * eval requestPayloadPutFC[0].baseGeoId = ""
    * eval requestPayloadPutFC[0].configName = ""
    * eval requestPayloadPutFC[0].deliveryMode = ""
    * eval requestPayloadPutFC[0].factorCarrierRating = ""
    * eval requestPayloadPutFC[0].factorLeadHours = ""
    * eval requestPayloadPutFC[0].factorManualRating = ""
    * eval requestPayloadPutFC[0].factorShippingPrice = ""
    * eval requestPayloadPutFC[0].geoGroupId = ""
    * eval requestPayloadPutFC[0].geoId = ""
    * eval requestPayloadPutFC[0].id = ""
    * eval requestPayloadPutFC[0].pgId = ""
    * karate.log("Updated data - ",requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method put
    Then status 400
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-14946
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with all invalid values
    
    * eval requestPayloadPutFC[0].configName = "dhgdjgvbdhngvbhndvbncb nvsgdsnvjbjdvbjdvbdhvbdhh@@A"
    * eval requestPayloadPutFC[0].factorCarrierRating = 0
    * eval requestPayloadPutFC[0].factorShippingPrice = 120
    * eval requestPayloadPutFC[0].geoGroupId = "@#@#"
    * eval requestPayloadPutFC[0].id = "123"
    * eval requestPayloadPutFC[0].pgId = "www"
    * karate.log("Updated data - ",requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Test Completed !')
    

  #REV2-14945
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with all valid values
    
    * def postResult = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def resId = postResult.response.id
    * eval requestPayloadPutFC[0].id = resId
    * eval requestPayloadPutFC[0].configName = requestPayloadPutFC[0].configName + num
    * eval requestPayloadPutFC[0].fromDate = toTime()
    * karate.log("Updated data - ",requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
    
    * def allocGetResult = call read('./alloc-logic-crud-allocation-manager-test.feature@getLogicUpdateFC')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Updated Data on the respected ID present in GET method **************")
    And karate.log('Test Completed !')


  #REV2-14943
  Scenario: PUT - Verify Allocation Logic PUT FC Rule when Invalid Auth token given for Allocation Manager
    
    * eval requestPayloadPutFC[0].fromDate = toTime()
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    * karate.log("Updated data - ",requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method put
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

		
  #REV2-14942
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with unsupported method
   
    * eval requestPayloadPutFC[0].fromDate = toTime()
    * karate.log("Updated data - ", requestPayloadPutFC)
    
    Given path '/fcs'
    And request requestPayloadPutFC
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    * header Authorization = token
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayloadPutFC
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

	 
  #REV2-14940
  Scenario: PUT - Verify Allocation Logic PUT FC Rule with Invalid URL
   
    Given path '/carr/:123'
    And request requestPayloadPutFC
    When method put
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
 
    
  @putCarriergetLogic
  Scenario: GET - To Verify if Updated data is getting displayed in GET method

    Given path '/carriers'
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param pgId = 2
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-15208
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with invalid data in request body

    * eval requestPayloadPutCR[0].fromDate = toTime()
    * eval requestPayloadPutCR[0].xyz = "wwww"
    * eval requestPayloadPutCR[0].namee = "321"
    * karate.log("Updated data - ",requestPayloadPutCR)
    
    Given path '/carriers'
    And request requestPayloadPutCR
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-15205
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all blank values
    
    * eval requestPayloadPutCR[0].baseGeoId = ""
    * eval requestPayloadPutCR[0].configName = ""
    * eval requestPayloadPutCR[0].deliveryMode = ""
    * eval requestPayloadPutCR[0].factorCarrierRating = ""
    * eval requestPayloadPutCR[0].factorLeadHours = ""
    * eval requestPayloadPutCR[0].factorManualRating = ""
    * eval requestPayloadPutCR[0].factorShippingPrice = ""
    * eval requestPayloadPutCR[0].geoGroupId = ""
    * eval requestPayloadPutCR[0].geoId = ""
    * eval requestPayloadPutCR[0].id = ""
    * eval requestPayloadPutCR[0].pgId = ""
    * karate.log("Updated data - ",requestPayloadPutCR)
    
    Given path '/carriers'
    And request requestPayloadPutCR
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


  #REV2-15204
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all invalid values
    
    * eval requestPayloadPutCR[0].configName = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    * eval requestPayloadPutCR[0].factorCarrierRating = 0
    * eval requestPayloadPutCR[0].factorShippingPrice = 120
    * eval requestPayloadPutCR[0].geoGroupId = "@#@#"
    * eval requestPayloadPutCR[0].id = "123"
    * eval requestPayloadPutCR[0].pgId = "www"
    * karate.log("Updated data - ",requestPayloadPutCR)
    
    Given path '/carriers'
    And request requestPayloadPutCR
    When method put
    Then status 400
    And karate.log("Response is : ",response)
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid characters found."
    And match response.errors[*].message contains "Carrier rating weightage should be between 1 to 100."
    And match response.errors[*].message contains "Size should be less than 30."
    And match response.errors[*].message contains "Shipping price weightage should be between 1 to 100."
    And karate.log('Test Completed !')

	
  #REV2-15203
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with all valid values
    
    * def postResult = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicCarrier')
    * def resId = postResult.response.id
    
    * eval requestPayloadPutCR[0].configName = requestPayloadPutCR[0].configName + num
    * eval requestPayloadPutCR[0].id = resId
    * eval requestPayloadPutCR[0].fromDate = toTime()
    * karate.log("Updated data - ",requestPayloadPutCR)
    
    Given path '/carriers'
    And request requestPayloadPutCR
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log("Response is : ",response)
    And match response.message == 'Record(s) Updated Successfully.'
    
    * def allocGetResult = call read('./alloc-logic-crud-allocation-manager-test.feature@putCarriergetLogic')
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    #And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Updated Data on the respected ID present in GET method **************")
    And karate.log('Test Completed !')


  #REV2-15201
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule when Invalid Auth token given for Allocation Manager
    
    * eval requestPayloadPutCR[0].fromDate = toTime()
    * eval loginResult.accessToken = "UYGJE763bbmJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    * karate.log("Updated data - ",requestPayloadPutCR)
    
    Given path '/carriers'
    And request requestPayloadPutCR
    When method put
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 401')
    And karate.log('Test Completed !')


  #REV2-15200
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with unsupported method
    
    * eval requestPayloadPutCR[0].fromDate = toTime()
    * karate.log("Updated data - ", requestPayloadPutCR)
    
    Given path '/carriers'
    And request requestPayloadPutCR
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    
    * header Authorization = token
    Given path '/hendrix/v1/allocation-rules/carriers'
    And request requestPayloadPutCR
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')


  #REV2-15198
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule with Invalid URL
    
    Given path '/hendrix/v1/aaaabbbbb'
    And request requestPayloadPutCR
    When method put
    Then status 404
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


  #******************************** DELETE****************************#
  
  #REV2-14523
  Scenario: DELETE - Verify user can delete record with valid  id
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 200
    And karate.log('Response is : ', response)
    And match response.message == "Record(s) Deleted Successfully."
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

  #REV2-14532
  Scenario: DELETE - Validate user can delete id with invalid url
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path 'al/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 404
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')

  #REV2-14528
  Scenario: DELETE - verify that user can delete record with spaces in duplicate values
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 200
    And karate.log('Response is : ', response)
    
    * header Authorization = token
    Given path 'hendrix/v1/allocation-rules/id/'+deletedId+ '  '
    And param vendorType = 'FC'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')

  #REV2-14527
  Scenario: DELETE - verify that user can delete record with duplicate id
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 200
    And karate.log('Response is : ', response)
    
    * header Authorization = token
    Given path 'hendrix/v1/allocation-rules/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')

  #REV2-14526
  @deleteBlankId
  Scenario: DELETE - verify that user can delete record with spaces in parameter
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'F   C'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Vendor Type Has Unknown Value, Allowed Values -> FC,CR"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  #REV2-14525
  Scenario: DELETE - verify that user can delete record with blank id
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@deleteBlankId')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  #REV2-14524
  Scenario: DELETE - verify that user can delete record with invalid id
    * def result = call read('alloc-logic-crud-allocation-manager-test.feature@createAllocLogicFc')
    * def deletedId = result.response.id
    Given path '/id/12555'+deletedId
    And param vendorType = 'FC'
    When method delete
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Invalid Id provided"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
     #*************GET***************#
  
	#REV2-17950/#REV2-29521/#REV2-29524/#REV2-29526/#REV2-29527/#REV2-29534
	Scenario: GET - Verify Allocation manager can fetch Logic Configuration for FC with valid ids
  	
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
  	
  
	#REV2-17952/#REV2-29522/#REV2-29525
	Scenario: GET - Verify Allocation Manager cannot fetch Allocation Logic Configuration for FC - space in the parameters
   	
   	Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1!'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = '  6'
  	And param page = 0
  	And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found."
    And karate.log('Test Completed !')
    
   
	#REV2-17953/#REV2-29523
	Scenario: GET - Verify Allocation Manager cannot fetch records of Allocation Logic configuration FC with blank ids
    
    Given path '/fcs'
    And param fieldName = ' '
  	And param fieldValues = ' '
  	And param fieldValues = ' '
  	And param geoGroupId = ' '
  	And param geoId = ' '
  	And param operator = ' '
  	And param pgId = ' '
  	And param page = ' '
  	And param size = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message == "#notnull"
    And karate.log('Test Completed !')
    
  
	#REV2-17955  
	Scenario: GET - Verify FC with Invalid authorization Credential for Allocation Manager
     
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
    
	 
	#REV2-17956/#REV2-29533
  Scenario: GET - Verify with Blank Authorization code for Allocation Manager 
    
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
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
  
	#REV2-17958
	Scenario: GET - Verify Allocation Manager cannot access FC with Missing any value in optional fields
    
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
  
	#REV2-29528
	Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for FC with operator contains in valid values
  	
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
  	
  
	#REV2-29529
	Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for FC with operator does not contain in valid values
  	
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
  	
 	
  #REV2-29530
	Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for FC with mandatory fields
    
    Given path '/fcs'
    And param fieldName = 'configName'
  	And param fieldValues = 'holi1'
  	And param fieldValues = 'holi2'
  	And param geoGroupId = 'kolkata'
  	And param geoId = 'india'
  	And param operator = 'EQUAL_TO'
  	And param pgId = ' '
  	And param page = 0
  	And param size = 10
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "The Product Group field is mandatory."
    And karate.log('Test Completed !')
   
  
  #REV2-29532
	Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for FC with unsupported methods
	
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
    
    
    #*************GET CARRIER Search Scenarios***************#
    
    
  #REV2-28898
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with valid values
  
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
    
    
  #REV2-28899
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with invalid values
  
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
    
 
  #REV2-28900
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with blank values
  
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
    
   
  #REV2-28901
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with comma separated valid values for fields
  
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
    
    
  #REV2-28903/#REV2-28904/#REV2-28905/#REV2-28906
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier by operator equal with valid values
  
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
    
   
  #REV2-28907
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with missing value in mandatory fields
    
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
    
  
  #REV2-28908
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with editing search values for fields
  
    Given path '/carriers'
    And param fieldName = 'baseGeoId'
    And param fieldValues = '411001'
    And param fieldValues = 'Carrier_105'
    And param geoGroupId = 'Kolkata'
    And param geoId = 'India'
    And param operator = 'EQUAL_TO'
    And param pgId = 2
    And param page = 0
    And param size = 10
    When method get
    Then status 200
    
  
  #REV2-28909
  Scenario: GET - Verify Allocation Manager can search Allocation Logic Configuration for carrier with authorization code not added
  
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
    And karate.log('Test Completed !')
   
	
    
    
   
    
     
