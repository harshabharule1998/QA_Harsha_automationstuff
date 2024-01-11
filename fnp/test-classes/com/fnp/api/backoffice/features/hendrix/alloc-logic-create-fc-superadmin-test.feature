Feature: Allocation Logic POST FC with Super Admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/fcs'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
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
    And param geoGroupId = requestPayload.geoGroupId
    And param geoId = requestPayload.geoId
    And param pgId = requestPayload.pgId
    And param page = page1
    And param size = size1
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')


  #REV2-16966
  Scenario: POST - Verify Allocation Logic POST FC Rule for Same date and time for fromDate and thruDate
		
		* eval requestPayload.configName = "diwali" + num
		* eval requestPayload.fromDate = toTime()
    * eval requestPayload.thruDate = toTime()
    
    Given request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 201
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

	
  #REV2-16965
  Scenario: POST - Verify Allocation Logic POST FC Rule for From Date greater than Thru Date
		
		* eval requestPayload.fromDate = '15-12-2022'
    
    Given request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "thruDate must be greater than or equal to fromDate"
    And karate.log('Test Completed !')

	
  #REV2-16964
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for thruDate
		
		* eval requestPayload.thruDate = "12-13-2022"
		
    Given request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response.errors) 

    And request requestPayload
    * eval requestPayload.thruDate = "0"
    And path '/hendrix/v1/allocation-rules/fcs'
    * header Authorization = authToken
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*] == response.errors
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-16963
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid Date for fromDate

    * eval requestPayload.fromDate = "32-12-2022"
    
    Given request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)

    And request requestPayload
    * eval requestPayload.fromDate = "20-12-2021T05:00:41"
    And path '/hendrix/v1/allocation-rules/fcs'
    * header Authorization = authToken
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-16961
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid data in request body

    * eval requestPayload.xyz = "xyz"
    * eval requestPayload.idddd = "1234"
		
		Given request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-16958
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid URL

    Given path '/hendrix/v1/allocationrules/aabbcc'
    And request requestPayload
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
    * eval requestPayload.configName = requestPayload.configName + num

    Given request requestPayload
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')


  #REV2-16955
  Scenario: POST - Verify Allocation Logic POST FC Rule when Invalid Auth token given for Super Admin

    * eval requestPayload.configName = requestPayload.configName + num
    * eval loginResult.accessToken = "UYGJEFGESJFHBDRHGVRDJ"
    * def saveToken = 'Bearer' + " " + loginResult.accessToken
    
    * header Authorization = saveToken
    
    Given request requestPayload
    When method post
    Then status 401
    And karate.log('Response Errors are :', response.errors)
    And match response.errors[0].message == 'Token Invalid! Authentication Required'
    And karate.log('Status : 401')
    And karate.log('Test Completed !')

  
  #REV2-16954
  Scenario: POST - Verify Allocation Logic POST FC Rule for Unsupported Method
  
    Given request requestPayload
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
  
    And path '/hendrix/v1/allocation-rules/fcs'
    * header Authorization = authToken
    When method delete
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

  
  #REV2-16953
  Scenario: POST - Verify Allocation Logic POST FC Rule for missing any value in any mandatory fields
  
    * eval requestPayload.configName = ''
    * eval requestPayload.geoGroupId = ''
    * eval requestPayload.pgId = ''
    
    Given request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == '#notnull'
    And match response.errorCount == 3
    And karate.log('Status : 400')
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errors[*].message contains "The Product Group field is mandatory."
    And match response.errors[*].message contains "The Geo group field is mandatory"
    And karate.log('Test Completed !')


  #REV2-16951
  Scenario: POST - Verify Allocation Logic POST FC Rule with only mandatory fields

    * eval requestPayload.configName = requestPayload.configName + num
    * eval requestPayload.fromDate = toTime()
    
    Given request requestPayload
    When method post
    Then status 201
    And match response.id == "#notnull"
    * def resId = response.id
    And karate.log('Response is : ', response)
    And karate.log('Status : 201')
    
    * def allocGetResult = call read('./alloc-logic-create-fc-superadmin-test.feature@getLogic') {page1 : 0, size1 : 250}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')


  #REV2-16948
  Scenario: POST - Verify Allocation Logic POST FC Rule with duplicate values

    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'This FC Allocation Rule Configuration is already exist for given Vendor'
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-16947
  Scenario: POST - Verify Allocation Logic POST FC Rule with blank values

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

 
  #REV2-16946
  Scenario: POST - Verify Allocation Logic POST FC Rule with combination of valid/Invalid/Spaces/Blank data
 
    
    * eval requestPayload.configName = "rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"
    * eval requestPayload.baseGeoId = requestPayload.baseGeoId + '&*#'
    * eval requestPayload.factorDistance = '   '
    * eval requestPayload.geoId = ''
    * eval requestPayload.pgId = 'wwr'
    
    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
  #REV2-16944
  Scenario: POST - Verify Allocation Logic POST FC Rule with Invalid values
 
    * eval requestPayload.configName = requestPayload.configName + num + '&*#'
    * eval requestPayload.baseGeoId = requestPayload.baseGeoId + '&*#'
    * eval requestPayload.factorCapacityDone = 101
    * eval requestPayload.factorDistance = 0
    * eval requestPayload.factorFCRating = -130
    * eval requestPayload.factorManualRating = 2222
    * eval requestPayload.factorPrice = -555
    * eval requestPayload.fromDate = "2021-12-35T10:02:31"
    * eval requestPayload.geoGroupId = "abc_xyz@a"
    * eval requestPayload.geoId = '@@@'
    * eval requestPayload.pgId = 'abcd12'
    * eval requestPayload.thruDate = "0T28:65:888"
    
    * karate.log(requestPayload)
    
    Given request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
  #REV2-16943
  Scenario: POST - Verify Allocation Logic POST FC Rule with Valid values
 
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
 
    * def allocGetResult = call read('./alloc-logic-create-fc-superadmin-test.feature@getLogic') {page1 : 0, size1 : 250}
    And karate.log("Total Data --------", allocGetResult.response.total)
    And karate.log("Total Pages --------", allocGetResult.response.totalPages)
    And karate.log("Current Page --------", allocGetResult.response.currentPage)
    And match allocGetResult.response.data[*].id contains resId
    And karate.log("************** Created Data present in GET method **************")
    And karate.log('Test Completed !')
