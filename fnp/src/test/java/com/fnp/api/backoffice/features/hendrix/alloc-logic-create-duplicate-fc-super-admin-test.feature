Feature: Allocation Logic POST duplicate with Super Admin user role for FC


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/fcs/_duplicate'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/alloc-logic-post-duplicate-fc.json')
    * def requestPayloadCreate = requestPayload[0]
    * def toTime =
      """
      	function(s) {
       		var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
       		var sdf = new SimpleDateFormat("dd-MM-yyyy");
       		return sdf.format(new java.util.Date());           
      	}
      """
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)

	
  #REV2-32991
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with valid values
  
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = toTime()
    And request requestPayload
    When method post
    Then status 201
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And karate.log('ID Matched')
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
	
  #REV2-32992
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with invalid values
  
    And request requestPayload
    * eval requestPayload.applyToBaseGeoIds = ['&*#']
    * eval requestPayload.applyToPgIds = ['@#']
    * eval requestPayload.configName = requestPayload.configName + 'ssdfffffffffffffffff'
    * eval requestPayload.fromDate = toTime()
    * eval requestPayload.sourceRuleId = requestPayload.sourceRuleId + 'qwweeeee'
    * eval requestPayload.thruDate = requestPayload.thruDate
    * eval requestPayload.factorCapacityDone = '101'
    * eval requestPayload.factorDistance = '1000'
    * eval requestPayload.factorFCRating = '5000'
    * eval requestPayload.factorManualRating = '200'
    * eval requestPayload.factorPrice = '205'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "Manual rating weightage should be between 1 to 100."
    And match response.errors[*].message contains "FC rating weightage should be between 1 to 100."
    And match response.errors[*].message contains "Distance weightage should be between 1 to 100."
    And match response.errors[*].message contains "FC Capacity-done weightage should be between 1 to 100."
    And match response.errors[*].message contains "FC price weightage should be between 1 to 100."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-32993
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with blank values
  
    And request requestPayload
    * eval requestPayload.applyToBaseGeoIds = ''
    * eval requestPayload.applyToPgIds = ''
    * eval requestPayload.configName = ''
    * eval requestPayload.fromDate = ''
    * eval requestPayload.sourceRuleId = ''
    * eval requestPayload.thruDate = ''
    * eval requestPayload.factorCapacityDone = '   '
    * eval requestPayload.factorDistance = '   '
    * eval requestPayload.factorFCRating = '   '
    * eval requestPayload.factorManualRating = '   '
    * eval requestPayload.factorPrice = '   '
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-32994
  Scenario: POST - Verify Allocation Logic POST duplicate Rule  for FC with spaces in the parameters
  
    And request requestPayload
    * eval requestPayload.applyToBaseGeoIds = ['   ']
    * eval requestPayload.applyToPgIds = ['  ']
    * eval requestPayload.configName = ' '
    * eval requestPayload.fromDate = '   '
    * eval requestPayload.sourceRuleId = ' '
    * eval requestPayload.thruDate = '   '
    * eval requestPayload.factorCapacityDone = '   '
    * eval requestPayload.factorDistance = '   '
    * eval requestPayload.factorFCRating = '   '
    * eval requestPayload.factorManualRating = '   '
    * eval requestPayload.factorPrice = '   '
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response Errors are :', response.errors
    * def responseMessages = get response.errors[*].message
    And match response.errors[*].message contains responseMessages
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And match response.errorCount == 1
    And karate.log('Test Completed !')

	
  #REV2-32995
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with Valid/Invalid/Blank values
  
    And request requestPayload
    * eval requestPayload.applyToBaseGeoIds = ['']
    * eval requestPayload.applyToPgIds = ['4','21']
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = toTime()
    * eval requestPayload.sourceRuleId = ''
    * eval requestPayload.thruDate = '01-01-2023'
    * eval requestPayload.factorCapacityDone = '50'
    * eval requestPayload.factorDistance = '50'
    * eval requestPayload.factorFCRating = '500'
    * eval requestPayload.factorManualRating = '400'
    * eval requestPayload.factorPrice = '10'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "must not be blank"
    And match response.errors[*].message contains "sourceRuleId should not be blank."
    And match response.errors[*].message contains "FC rating weightage should be between 1 to 100."
    And match response.errors[*].message contains "Manual rating weightage should be between 1 to 100."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-32996
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with duplicate data without spaces in the parameters
  
    And request requestPayload
    * eval requestPayload.applyToBaseGeoIds = ['411001']
    * eval requestPayload.applyToPgIds = ['1']
    * eval requestPayload.configName = 'Diwali'
    * eval requestPayload.fromDate = '01-01-2023'
    * eval requestPayload.sourceRuleId = '619fd22d42b4340a28a05000'
    * eval requestPayload.thruDate = '15-01-2023'
    * eval requestPayload.factorCapacityDone = '50'
    * eval requestPayload.factorDistance = '50'
    * eval requestPayload.factorFCRating = '50'
    * eval requestPayload.factorManualRating = '50'
    * eval requestPayload.factorPrice = '50'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message contains "Configuration is already exist for specified date-range for baseGeoId and pgId ->[(411001, 1)]"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-32997
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with keeping fromDate and thruDate same
  
    And request requestPayload
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = '01-01-2023'
    * eval requestPayload.thruDate = '01-01-2023'
    And karate.log(requestPayload)
    When method post
    Then status 201
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And karate.log('ID Matched')
    And karate.log('Status : 201')
    And karate.log('Test Completed !')

	
  #REV2-32998
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC where fromDate greater than ThruDate
  
    And request requestPayload
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = '02-01-2023'
    * eval requestPayload.thruDate = '01-01-2023'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message == "thruDate must be greater than or equal to fromDate."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-32999
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with invalid fromDate
  
    And request requestPayload
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = '2020-01'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message == "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-33000
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with invalid thruDate
  
    And request requestPayload
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.thruDate = '01-01-2020'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "thruDate Must Be Of Future or Present."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-33001
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC if missing any value in any mandatory field
  
    And request requestPayload
    * eval requestPayload.configName = ''
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    * def errors = get response.errors[*].message
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errorCount == 1
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-33002
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with Invalid endpoint URL
  
    Given path '/hendrix/v1/allocationrules/_duplicate'
    And request requestPayload
    When method post
    Then status 404
    And print 'Response Errors are :', response.errors
    * def errorResponse = get response.errors[*].message
    And match response.errors[*].message contains "http.request.not.found"
    * def status = response.status
    And match status != 500
    And karate.log('Status : 404')
    And karate.log('Test Completed !')

	
  #REV2-33004
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC for Unsupported Method
  
    And request requestPayload
    When method patch
    Then status 405
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')

	
  #REV2-33005
  Scenario: POST - Verify 401 error for invalid authorization token for Allocation Logic POST duplicate Rule for FC
  
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = toTime()
    And request requestPayload
    When method post
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[0].message == "Token Invalid! Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

	
  #REV2-33006
  Scenario: POST - Verify 401 error if no authorization token added for Allocation Logic POST duplicate Rule for FC
  
    * def invalidAuthToken = ""
    * header Authorization = invalidAuthToken
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = toTime()
    And request requestPayload
    When method post
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Authentication Required"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

	
  #REV2-33008
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with duplicate data with spaces in the parameters
  
    And request requestPayload
    * eval requestPayload.applyToBaseGeoIds = ['411001 ']
    * eval requestPayload.applyToPgIds = ['1 ']
    * eval requestPayload.configName = 'Diwali '
    * eval requestPayload.fromDate = '01-01-2023'
    * eval requestPayload.sourceRuleId = '619fd22d42b4340a28a05000 '
    * eval requestPayload.thruDate = '15-01-2023'
    * eval requestPayload.factorCapacityDone = '50 '
    * eval requestPayload.factorDistance = '50'
    * eval requestPayload.factorFCRating = '50'
    * eval requestPayload.factorManualRating = '50 '
    * eval requestPayload.factorPrice = '50'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message contains "Invalid characters found in sourceRuleId."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-33018
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with Invalid data in request body
  
    And request requestPayload
    * eval requestPayload.test = 'test'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response Errors are :', response.errors
    * def responseMessages = get response.errors[*].message
    And match response.errors[*].message contains "Invalid_Input_Data"
    * def status = response.status
    And match status != 500
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

    