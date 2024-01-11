Feature: Allocation Logic POST FC with Allocation Executive

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/fcs'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
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
  
   
  #REV2-16960
  Scenario: POST - Verify Allocation Logic POST FC Rule for 403 error with Allocation Executive user 
    
    * eval requestPayload.configName = requestPayload.configName + num
    * karate.log('-------------Time is : ------------', toTime())
    * eval requestPayload.fromDate = toTime()
    
    Given request requestPayload
    When method post
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')      
