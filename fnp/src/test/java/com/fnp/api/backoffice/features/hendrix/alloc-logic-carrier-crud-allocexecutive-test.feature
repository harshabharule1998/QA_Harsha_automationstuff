Feature: Allocation Logic Carrier CRUD scenarios with Allocation Executive

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/allocation-rules/carriers'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
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
  
  
  #REV2-17055
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for 403 error with Allocation Executive user 
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * karate.log('-------------Time is : ------------', toTime())
    * eval requestPayloadCreate.fromDate = toTime()
    
    And request requestPayloadCreate
    When method post
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')
    

	#REV2-17979
  Scenario: GET - Verify Allocation Logic carrier GET API cannot fetch all the records with valid values
    
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
		

	#REV2-15202
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule for 403 error with Allocation Executive user

    * eval requestPayloadUpdate[0].fromDate = toTime()
    
    Given request requestPayloadUpdate
    When method put
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')
