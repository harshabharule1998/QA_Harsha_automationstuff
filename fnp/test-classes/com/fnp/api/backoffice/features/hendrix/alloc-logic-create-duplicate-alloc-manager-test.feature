Feature: Allocation Logic POST duplicate with Allocation Manager user role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/carriers/_duplicate'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
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
	
	
	#REV2-32890
  Scenario: POST - Verify Allocation Logic POST duplicate Rule with all valid values
  
    * eval requestPayload.fromDate = toTime()
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('ID Matched')
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  #REV2-32891
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all invalid fields
  
    And request requestPayload
    * eval requestPayload.configName = "holi" + num
    * eval requestPayload.sourceRuleId = requestPayload.sourceRuleId + 'qwweeeee'
    * eval requestPayload.factorFCRating = '5000'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

  #REV2-32892
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
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
  #REV2-32893
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for all blank fields
  
    And request requestPayload
    * eval requestPayload.configName = ''
    * eval requestPayload.factorCarrierRating = ''
    * eval requestPayload.factorLeadHours = ''
    * eval requestPayload.factorManualRating = ''
    * eval requestPayload.factorShippingPrice = ''
    * eval requestPayload.fromDate = ''
    * eval requestPayload.sourceRuleId = ''
    * eval requestPayload.thruDate = ''
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Response is : ', response)
    And match response.errorId == "#notnull"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
  #REV2-32894
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
    
    
  #REV2-32895
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
    
    
  #REV2-32896
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
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
	
