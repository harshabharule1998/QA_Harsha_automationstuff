Feature: Allocation Logic POST duplicate with Super Admin user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/carriers/_duplicate'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/alloc-logic-post-duplicate.json')
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
    
  
  #REV2-32871
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all fields with valid values
  
    * eval requestPayload.fromDate = toTime()
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('ID Matched')
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
 	
  #REV2-32872
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all of the invalid fields
  
    And request requestPayload
    * eval requestPayload.configName = "holi" + num
    * eval requestPayload.sourceRuleId = requestPayload.sourceRuleId + 'qwweeeee'
    * eval requestPayload.factorFCRating = '5000'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-32873
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for any of the invalid field
  
    And request requestPayload
    * eval requestPayload.configName = "holi" + num
    * eval requestPayload.sourceRuleId = requestPayload.sourceRuleId + 'qwweeeee'
    * eval requestPayload.factorDistance = '1000'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And match response.errors[*].message contains "Invalid_Input_Data"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

	
  #REV2-32874
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all parameters with blank fields 
  
    And request requestPayload
    * eval requestPayload.configName = '   '
    * eval requestPayload.factorCarrierRating = '  '
    * eval requestPayload.factorLeadHours = '  '
    * eval requestPayload.factorManualRating = ' '
    * eval requestPayload.factorShippingPrice = '   '
    * eval requestPayload.fromDate = ' '
    * eval requestPayload.sourceRuleId = '   '
    * eval requestPayload.thruDate = '   '
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
	
  #REV2-32875
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for missing any mandatory field
  
    And request requestPayload
    * eval requestPayload.configName = ''
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
  #REV2-32876
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with Invalid endpoint URL
  
    Given path '/hendrix/v1/allocationrules/_duplicate'
    And request requestPayload
    When method post
    Then status 404
    And print 'Response Errors are :', response.errors
    * def errorResponse = get response.errors[*].message
    And match response.errors[*].message contains errorResponse
    * def status = response.status
    And match status != 500
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
  
  #REV2-32878
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for Unsupported Method
  
    And request requestPayload
    When method patch
    Then status 405
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
    
  
  #REV2-32879
  Scenario: POST - Verify Allocation Logic POST duplicate Rule when Invalid Auth token given
    And request requestPayload
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    And karate.log(requestPayload)
    When method post
    Then status 401
    And karate.log('Response is : ', response.errors)
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
     
  #REV2-32880
  Scenario: POST - Verify Allocation Logic POST duplicate Rule when blank Auth token given
  
    And request requestPayload
    * def invalidAuthToken = loginResult.accessToken + " "
    * header Authorization = invalidAuthToken
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response.errors)
    And match response.errors[0].message contains "Configuration is already exist for specified date-range for baseGeoId and pgId ->[(411001, 4)]"
    And karate.log('Status : 43')
    And karate.log('Test Completed !')
  
  
  #REV2-32881
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with Invalid data in request body
  
    And request requestPayload
    * eval requestPayload.configName = "holi" + num
    * eval requestPayload.sourceRuleId = requestPayload.sourceRuleId + 'qwweeeee'
    * eval requestPayload.factorLeadHours = '1000'
    * eval requestPayload.factorManualRating = '101'
    * eval requestPayload.factorShippingPrice = '150'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response Errors are :', response.errors
    * def responseMessages = get response.errors[*].message
    And match response.errors[*].message contains responseMessages
    * def status = response.status
    And match status != 500
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
 
  #REV2-32882
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with combination of blank,space,invalid,valid values
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.sourceRuleId = requestPayload.sourceRuleId + 'qwweeeee'
    * eval requestPayload.factorCarrierRating = '  '
    * eval requestPayload.factorLeadHours = '  '
    * eval requestPayload.factorManualRating = '72'
    * eval requestPayload.factorShippingPrice = '67'
    * eval requestPayload.fromDate = '22-01-2022'
    * eval requestPayload.thruDate = '26-01-2022'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
 
  #REV2-32883
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with duplicate data in the parameters
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.sourceRuleId = '61c2e6240ebf632ffedea56d'
    * eval requestPayload.factorCarrierRating = '77'
    * eval requestPayload.factorLeadHours = '72'
    * eval requestPayload.factorManualRating = '72'
    * eval requestPayload.factorShippingPrice = '72'
    * eval requestPayload.fromDate = '22-01-2022'
    * eval requestPayload.thruDate = '26-01-2022'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message contains "Configuration is already exist for specified date-range for baseGeoId and pgId ->[(411001, 4)]"
    And karate.log('Test Completed !')
    
  
  #REV2-32884
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with invalid fromDate
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
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
    
  
  #REV2-32885
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with invalid thrDate
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.thruDate = '2020-01'
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
   
  
  #REV2-32886
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with keeping fromDate greater than thruDate 
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.fromDate = '26-01-2023'
    * eval requestPayload.thruDate = '25-01-2023'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And karate.log('ID Matched')
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
  #REV2-32887
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with keeping fromDate and thruDate same
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.fromDate = '01-01-2023'
    * eval requestPayload.thruDate = '01-01-2023'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And karate.log('ID Matched')
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
 	#REV2-32888
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with/without space in duplicate data parameters
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.sourceRuleId = '61c2e6240ebf632ffedea56d'
    * eval requestPayload.factorCarrierRating = ' 77'
    * eval requestPayload.factorLeadHours = '72'
    * eval requestPayload.factorManualRating = '72'
    * eval requestPayload.factorShippingPrice = '72'
    * eval requestPayload.fromDate = '22-01-2022'
    * eval requestPayload.thruDate = '26-01-2022'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message contains "Configuration is already exist for specified date-range for baseGeoId and pgId ->[(411001, 4)]"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-32889
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for FC with space in all duplicate data parameters
  
    And request requestPayload
    * eval requestPayload.configName = 'bday12351'
    * eval requestPayload.sourceRuleId = '61c2e6240ebf632ffedea56d'
    * eval requestPayload.factorCarrierRating = ' 77'
    * eval requestPayload.factorLeadHours = ' 72'
    * eval requestPayload.factorManualRating = ' 72'
    * eval requestPayload.factorShippingPrice = ' 72'
    * eval requestPayload.fromDate = ' 22-01-2022'
    * eval requestPayload.thruDate = ' 26-01-2022'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response is : ', response
    * def status = response.status
    And match status != 500
    And match response.errorId == "#notnull"
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Status : 400')
    And karate.log('Test Completed !')

 
