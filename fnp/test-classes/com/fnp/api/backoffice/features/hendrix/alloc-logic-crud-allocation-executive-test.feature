Feature: Create order,get,edit and delete it by Allocation Executive user role.

  Background: 
    Given url backOfficeAPIBaseUrl
    And path 'hendrix/v1/allocation-rules'
    * header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"allocExc"}
    * def token = loginResult.accessToken
    * header Authorization = token
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

  #******************** POST FC, POST CR ************#
 
  #REV2-16960
  Scenario: POST - Verify Allocation Logic POST FC Rule for 403 error with Allocation Executive user
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/allocation-logic-post-fc.json')
    * eval requestPayload.configName = requestPayload.configName + num
    * eval requestPayload.fromDate = toTime()
    
    Given path '/fcs'
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')


  #REV2-17055
  @createAllocLogicCarrier
  Scenario: POST - Verify Allocation Logic POST Carrier Rule for 403 error with Allocation Executive user
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')[0]
    * eval requestPayload.configName = "diwali" + num
    * eval requestPayload.fromDate = toTime()
    
    Given path '/carriers'
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')

  #****************** POST duplicate ************************#
  
  #REV2-14750
  Scenario: POST - Verify Allocation Logic POST duplicate Rule for 403 error with Allocation Executive user
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/alloc-logic-post-duplicate.json')
    * eval requestPayload.configName = "diwali" + num
    * eval requestPayload.fromDate = toTime()
    Given path '/_duplicate'
    And request requestPayload
    When method post
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')

  #********************** GET CR*******************************#
  
  #REV2-17979
  Scenario: GET - Verify Allocation Logic carrier can fetch all the records with valid values
  
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
    

  #*****************  PUT FC, PUT CR *************************#
  
  #REV2-14944
  Scenario: PUT - Verify Allocation Logic PUT FC Rule for 403 error with Allocation Executive user
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/alloc-logic-put-fc.json')
    * eval requestPayload[0].fromDate = toTime()
    
    Given path '/fcs'
    And request requestPayload
    When method put
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')
  
  
  #REV2-15202
  Scenario: PUT - Verify Allocation Logic PUT Carrier Rule for 403 error with Allocation Executive user
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/allocation-logic-carrier.json')[1]
    * eval requestPayload[0].fromDate = toTime()
    
    Given path '/carriers'
    And request requestPayload
    When method put
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')

  #***************** DELETE **************#
  
  #REV2-14534
  Scenario: DELETE - Verify that user should not delete id with allocation executive user role
  
    * def result = call read('alloc-logic-crud-allocation-executive-test.feature@createAllocLogicCarrier')
    * def deletedId = result.response.id
    Given path '/id/'+deletedId
    And param vendorType = 'CR'
    When method delete
    Then status 403
    And karate.log('Response is : ', response)
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Status : 403')
    And karate.log('Test Completed !')
    
  
 	#REV2-17946
  Scenario: GET - Verify that user should not fetch id with allocation executive user role
  
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
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
    
