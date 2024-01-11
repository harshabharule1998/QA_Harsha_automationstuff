Feature: Allocation Logic POST duplicate with Allocation Executive user role for FC


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/fcs/_duplicate'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
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

	
  #REV2-33010
  Scenario: POST - Verify 403 error for invalid user role (Allocation executive)
  
    * eval requestPayload.configName = 'Diwali' + num
    * eval requestPayload.fromDate = toTime()
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    And match response.errorCount == 1
    And karate.log('Test Completed !')

    