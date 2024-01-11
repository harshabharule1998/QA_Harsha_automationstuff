Feature: Allocation Logic POST FC with Allocation Manager

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/fcs'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/allocation-logic-post-fc.json')
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

  @getLogic
  Scenario: GET - To Verify if Created data is getting displayed in GET method
    
    Given param geoGroupId = requestPayload.geoGroupId
    And param geoId = requestPayload.geoId
    And param pgId = requestPayload.pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-16982
  Scenario: POST - Verify Allocation Logic POST FC Rule for From Date greater than Thru Date - with Allocation Manager access
    
    * eval requestPayload.fromDate = '15-12-2022'
    
    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Test Completed !')

 
  #REV2-16981
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for thruDate - with Allocation Manager access
    
    * eval requestPayload.thruDate = "12-13-2022"
    
    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response.errors)
        
    * eval requestPayload.thruDate = "12-13-2022"
    * karate.log(requestPayload)
    
    * header Authorization = authToken
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16980
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for fromDate - with Allocation Manager access
  
    * eval requestPayload.fromDate = "32-12-2022"
    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
   
    * eval requestPayload.fromDate = "32-12-2022"
    * karate.log(requestPayload)
    
    * header Authorization = authToken
    Given path '/hendrix/v1/allocation-rules/fcs'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16979
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid data in request body - with Allocation Manager access
 
    * eval requestPayload.xyz = "xyz"
    * eval requestPayload.fromDate1 = "1234"
    * karate.log(requestPayload)
 		
 		Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
  #REV2-16978
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid URL - with Allocation Manager access
   
    Given path '/fc'
    And request requestPayload
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
    
    * eval requestPayload.configName = requestPayload.configName + num
    
    Given request requestPayload
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-16976
  Scenario: POST - Verify Allocation Logic POST FC Rule when Invalid Auth credential given for Allocation Manager
  
    * eval requestPayload.configName = requestPayload.configName + num
  
    * eval loginResult.accessToken = authToken + "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    * header Authorization = saveToken
    
    Given request requestPayload
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-16975
  Scenario: POST - Verify Allocation Logic POST FC Rule with only mandatory fields - with Allocation Manager access
    
    * eval requestPayload.configName = requestPayload.configName + num
    * eval requestPayload.fromDate = toTime()
    
    Given request requestPayload
    When method post
    Then status 201
    And match response.id == "#notnull"
    * def resId = response.id
    And karate.log('Response is : ', response)
    And karate.log('POST ID is : ',response.id)
    And karate.log('Status : 201')
    
    * def allocGetResult = call read('./alloc-logic-create-fc-allocmanager-test.feature@getLogic') {page1 : 0, size1 : 250}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')


  #REV2-16973
  Scenario: POST - Verify Allocation Logic POST FC Rule with duplicate data - with Allocation Manager access

    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'The Config name is already in use.'
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
  #REV2-16972
  Scenario: POST - Verify Allocation Logic POST FC Rule with blank values - with Allocation Manager access
 
    * eval requestPayload.baseGeoId = ""
    * eval requestPayload.configName = ""
    * eval requestPayload.deliveryMode = ""
    * eval requestPayload.factorCapacityDone = ""
    * eval requestPayload.factorDistance = ""
    * eval requestPayload.factorFCRating = ""
    * eval requestPayload.factorManualRating = ""
    * eval requestPayload.factorPrice = ""
    * eval requestPayload.geoGroupId = ""
    * eval requestPayload.geoId = ""
    * eval requestPayload.pgId = ""
    * karate.log(requestPayload)
 		
 		Given request requestPayload   
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
  Scenario: POST - Verify Allocation Logic POST FC Rule with combination of valid/Invalid/Spaces/Blank data - with Allocation Manager access
  
    * eval requestPayload.configName = requestPayload.configName + num + '&*#'
    * eval requestPayload.baseGeoId = ''
    * eval requestPayload.factorDistance = '101'
    * eval requestPayload.geoId = '  '
    * eval requestPayload.pgId = '123#@'
    * karate.log(requestPayload)
  	
  	Given request requestPayload  
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

    
  #REV2-16970
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid values - with Allocation Manager access
  
    * eval requestPayload.configName = "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    * eval requestPayload.baseGeoId = '&*#' + requestPayload.baseGeoId
    * eval requestPayload.factorCapacityDone = 0
    * eval requestPayload.factorDistance = 111
    * eval requestPayload.factorFCRating = -0
    * eval requestPayload.factorManualRating = 2222
    * eval requestPayload.factorPrice = -5
    * eval requestPayload.geoGroupId = "abc_xyz@a"
    * eval requestPayload.geoId = '@@@'
    * eval requestPayload.pgId = 'abcd12'
    
    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

  
  #REV2-16969
  Scenario: POST - Verify Allocation Logic POST FC Rule with Valid values - with Allocation Manager access
  
    * eval requestPayload.configName = requestPayload.configName + num
    * karate.log('-------------Time is : ------------', toTime())
    * eval requestPayload.fromDate = toTime()
    
    Given request requestPayload
    When method post
    Then status 201
    And match response.id == "#notnull"
    And karate.log('Response is : ', response)
    * def resId = response.id
    And karate.log('Status : 201')
    
    * def allocGetResult = call read('./alloc-logic-create-fc-allocmanager-test.feature@getLogic') {page1 : 0, size1 : 250}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')
