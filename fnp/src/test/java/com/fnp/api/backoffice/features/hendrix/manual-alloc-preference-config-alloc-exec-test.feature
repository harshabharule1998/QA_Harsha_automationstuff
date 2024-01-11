Feature: Manual Allocation Preference Configuration for Allocation Executive role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocExc'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/manual-alloc-pref-config.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadUpdate = requestPayload[1]
    * def requestPayloadCreateCarrier = requestPayload[2]
    
    * def requestPayloadPostDuplicate = read('classpath:com/fnp/api/backoffice/data/hendrix/manual-alloc-preference-post-duplicate.json')
    
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
   
     * def thruTime =
      """
      	function(s) {
      	
       		var nextDate = new Date();
       		nextDate.setDate(nextDate.getDate() + 2);
       		var date = Java.type('java.util.Date');
       		var temp = new Date(nextDate);
       		var newDate = temp.toLocaleDateString().slice(0,10);
       		return newDate.toString().split("-").reverse().join("-");	
       	}
      """
        
  
	#REV2-14471 and REV2-14472
	@createManualAllocPreferenceConfig
  Scenario: POST - Verify Allocation Executive can create Manual Allocation Preference Configuration for all valid values
    
    * eval requestPayloadCreate.configName = "diwali" + num
    * eval requestPayloadCreate.fromDate = toTime()
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.configName == requestPayloadCreate.configName
    * def prefConfigId = response.id
    And karate.log('Test Completed !')
    
    
  @createManualAllocPreferenceConfigCarrier
  Scenario: POST - Verify Allocation Executive can create Manual Allocation Preference Configuration for Carrier with all valid values
    
    * eval requestPayloadCreateCarrier.configName = "diwali" + num
    * eval requestPayloadCreateCarrier.fromDate = toTime()
    * karate.log(requestPayloadCreateCarrier)
    
    Given request requestPayloadCreateCarrier
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.configName == requestPayloadCreateCarrier.configName
    * def prefConfigId = response.id
    And karate.log('Test Completed !')
	
	
	#REV2-14474
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for all blank values
    
    * eval requestPayloadCreate.baseGeoId = ""
    * eval requestPayloadCreate.configName = ""
    * eval requestPayloadCreate.deliveryMode = ""
    * eval requestPayloadCreate.fromDate = ""
    * eval requestPayloadCreate.geoGroupId = ""
    * eval requestPayloadCreate.geoId = ""
    * eval requestPayloadCreate.pgId = ""
    * eval requestPayloadCreate.quotas = ""
    * eval requestPayloadCreate.thruDate = ""
    * eval requestPayloadCreate.vendorType = ""
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]"
    And karate.log('Test Completed !')
    
	
	#REV2-14475
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for all values with trailing spaces
    
    * eval requestPayloadCreate.baseGeoId = requestPayloadCreate.baseGeoId + " "
    * eval requestPayloadCreate.configName = requestPayloadCreate.configName + " "
    * eval requestPayloadCreate.deliveryMode = requestPayloadCreate.deliveryMode + " "
    * eval requestPayloadCreate.geoGroupId = requestPayloadCreate.geoGroupId + " "
    * eval requestPayloadCreate.geoId = requestPayloadCreate.geoId + " "
    * eval requestPayloadCreate.pgId = requestPayloadCreate.pgId + " "
    * eval requestPayloadCreate.quotas = requestPayloadCreate.quotas + " "
    * eval requestPayloadCreate.vendorType = requestPayloadCreate.vendorType + " "
        
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
	
	
	#REV2-14476
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for all duplicate values
           
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
	
	#REV2-14477 and REV2-14495
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for all duplicate values with spaces
    
    * eval requestPayloadCreate.baseGeoId = " " + requestPayloadCreate.baseGeoId + " "
    * eval requestPayloadCreate.configName = " " + requestPayloadCreate.configName + " "
    * eval requestPayloadCreate.deliveryMode = " " + requestPayloadCreate.deliveryMode + " "
    * eval requestPayloadCreate.geoGroupId = " " + requestPayloadCreate.geoGroupId + " "
    * eval requestPayloadCreate.geoId = " " + requestPayloadCreate.geoId + " "
    * eval requestPayloadCreate.pgId = " " + requestPayloadCreate.pgId + " "
    * eval requestPayloadCreate.quotas = " " + requestPayloadCreate.quotas + " "
    * eval requestPayloadCreate.vendorType = " " + requestPayloadCreate.vendorType + " "
        
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
    

	#REV2-14478
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid configName
    
    * eval requestPayloadCreate.configName = "12345-diwali"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
	
	#REV2-14479
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid deliveryMode
    
    * eval requestPayloadCreate.deliveryMode = "12345-home"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found in deliveryMode."
    And karate.log('Test Completed !')
    
	
	#REV2-14480
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid geoGroupId
    
    * eval requestPayloadCreate.geoGroupId = "home-123"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found in geoGroupId."
    And karate.log('Test Completed !')
    
 
	#REV2-14481
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid geoId
    
    * eval requestPayloadCreate.geoId = "home-123"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
	

	#REV2-14482
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid pgId
    
    * eval requestPayloadCreate.pgId = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
	
	#REV2-14483
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid baseGeoId
    
    * eval requestPayloadCreate.baseGeoId = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
	
	#REV2-14484
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid quotas
    
    * eval requestPayloadCreate.quotas[0].value = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')  
  	
	
	#REV2-14485
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid vendorId
    
    * eval requestPayloadCreate.quotas[0].vendorId = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
  
	#REV2-14486
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid vendorType
    
    * eval requestPayloadCreate.vendorType = "ABC"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
	
	#REV2-14487
  Scenario: POST - Verify unsupported method for Allocation Executive to create Manual Allocation Preference Configuration
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method put
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
	
	
	#REV2-14488
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid auth token
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVk"
    
    Given request requestPayloadCreate
    When method post
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')
    
	
	#REV2-14492
	Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid endpoint url
    
    * karate.log(requestPayloadCreate)
    
    Given path '/id'
    And request requestPayloadCreate
    When method post
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
  
 
	#REV2-14496
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid fromDate
    
    * eval requestPayloadCreate.fromDate = "2022-09-04"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
   
	#REV2-14497
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration for invalid thruDate
    
    * eval requestPayloadCreate.thruDate = "2022-11-04"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
	
	#REV2-14498
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration with fromDate greater than thruDate
    
    * eval requestPayloadCreate.fromDate = "2022-11-04T05:47:15"
    * eval requestPayloadCreate.thruDate = "2022-09-04T05:47:15"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
	
	
	#REV2-14499
  Scenario: POST - Verify Allocation Executive to create Manual Allocation Preference Configuration with fromDate same as thruDate
    
    * eval requestPayloadCreate.fromDate = "2022-11-04T05:47:15"
    * eval requestPayloadCreate.thruDate = "2022-11-04T05:47:15"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
  
	
  #REV2-15933
  #BUG ID - REV2-24868
  Scenario: POST - Verify duplicate rule with Allocation Executive access with all values in only Mandatory fields
    
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds[0] = "411003"
    * eval requestPayloadPostDuplicate.configName = "christmas" + num
    * eval requestPayloadPostDuplicate.applyToPgIds[0] = "2"
    * eval requestPayloadPostDuplicate.fromDate = toTime()
    * def totime = toTime()
		* def newDate = thruTime(totime)
    * eval requestPayloadPostDuplicate.thruDate = newDate
    
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 403
    And karate.log('Status : 403')
    And match response == "#notnull"
    And karate.log('Test Completed !')  

	
  #REV2-15929
  Scenario: POST - Verify duplicate rule with Allocation Executive access for missing value in any Mandatory field
    
    * eval requestPayloadPostDuplicate.configName = ""
    * eval requestPayloadPostDuplicate.vendorType = ""
    * eval requestPayloadPostDuplicate.sourceRuleId = ""
    * eval requestPayloadPostDuplicate.applyToPgIds[0] = ""
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errorId == "#notnull"
    And karate.log('Test Completed !')       
    
   	 
  #REV2-15928
  Scenario: POST - Verify duplicate rule with Allocation Executive access with all blank fields
    
    * eval requestPayloadPostDuplicate.applyToBaseGeoIds[0] = ""
    * eval requestPayloadPostDuplicate.applyToPgIds[0] = ""
    * eval requestPayloadPostDuplicate.baseGeoId = ""
    * eval requestPayloadPostDuplicate.configName = ""
    * eval requestPayloadPostDuplicate.fromDate = ""
    * eval requestPayloadPostDuplicate.sourceRuleId = ""
    * eval requestPayloadPostDuplicate.thruDate = ""
    * eval requestPayloadPostDuplicate.vendorType = ""
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errorId == "#notnull"
    And karate.log('Test Completed !')    
    
  
  #REV2-15927
  Scenario: POST - Verify duplicate rule with Allocation Executive access with invalid value for any field
    
    * eval requestPayloadPostDuplicate.applyToPgIds[0] = "chocolates"
    * eval requestPayloadPostDuplicate.baseGeoId = "123&*"
    * eval requestPayloadPostDuplicate.configName = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    * eval requestPayloadPostDuplicate.vendorType = "abcde123@"
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errorId == "#notnull"
    And karate.log('Test Completed !')   
    
    
  #REV2-15847
  Scenario: PUT - Verify Allocation Executive can update Manual Allocation Preference Configuration for all valid values
    
    * def result = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def prefConfigId = result.prefConfigId
    
    * eval requestPayloadUpdate.configName = "holi" + num
    * karate.log(requestPayloadUpdate)
    
    Given path '/id/' + prefConfigId
    And request requestPayloadUpdate
    When method put
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Updated Successfully"
    And karate.log('Test Completed !')
  

  #REV2-15848
  Scenario: PUT - Verify Allocation Executive cannot update Manual Allocation Preference Configuration for all invalid values
    
    * def prefConfigId = "614319a162188428b2b851f9"
    
    * eval requestPayloadUpdate.configName = "holi-123"
    * eval requestPayloadUpdate.quotas[0].value = "abc"
    * eval requestPayloadUpdate.quotas[0].vendorId = "abc"
    * eval requestPayloadUpdate.thruDate = "2022-03-03"
    
    * karate.log(requestPayloadUpdate)
    
    Given path '/id/' + prefConfigId
    And request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
  

  #REV2-15849
  Scenario: PUT - Verify Allocation Executive cannot update Manual Allocation Preference Configuration for invalid quotas value
    
    * def prefConfigId = "614319a162188428b2b851f9"
    
    * eval requestPayloadUpdate.quotas[0].value = "abc"
    
    * karate.log(requestPayloadUpdate)
    
    Given path '/id/' + prefConfigId
    And request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')
  

  #REV2-15850
  Scenario: PUT - Verify Allocation Executive cannot update Manual Allocation Preference Configuration for all blank values
    
    * def prefConfigId = "614319a162188428b2b851f9"
    
    * eval requestPayloadUpdate.configName = ""
    * eval requestPayloadUpdate.quotas[0].value = ""
    * eval requestPayloadUpdate.quotas[0].vendorId = ""
    
    * karate.log(requestPayloadUpdate)
    
    Given path '/id/' + prefConfigId
    And request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "vendor Id should not be empty"
    And match response.errors[*].message contains "configName should not be blank."
    And match response.errors[*].message contains "value should not be empty!"
    And karate.log('Test Completed !')
    	
	
  #REV2-15851
  Scenario: PUT - Verify Allocation Executive cannot update Manual Allocation Preference Configuration for blank quotas value
    
    * def prefConfigId = "614319a162188428b2b851f9"
    
    * eval requestPayloadUpdate.quotas[0].value = ""
    
    * karate.log(requestPayloadUpdate)
    
    Given path '/id/' + prefConfigId
    And request requestPayloadUpdate
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "value should not be empty"
    And karate.log('Test Completed !')
    
    
	#REV2-16047
  Scenario: DELETE - Verify Allocation Executive can delete Manual Allocation Preference Configuration for valid prefConfigId
    
    * def result = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def prefConfigId = result.prefConfigId
    
    Given path '/id/' + prefConfigId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Deleted Successfully"
    And karate.log('Test Completed !')
    
    	
	#REV2-16048
  Scenario: DELETE - Verify Allocation Executive to delete Manual Allocation Preference Configuration for invalid prefConfigId
    
    * def invalidPrefConfigId = "61304d41621"
    
    Given path '/id/' + invalidPrefConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "This Manual Allocation Preference Configuration does not exist for given Vendor"
    And karate.log('Test Completed !')
    
	
	#REV2-16049
  Scenario: DELETE - Verify Allocation Executive to delete Manual Allocation Preference Configuration for blank prefConfigId
    
    * def blankPrefConfigId = ""
    
    Given path '/id/' + blankPrefConfigId
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')


	#REV2-16051
  Scenario: DELETE - Verify Allocation Executive to delete Manual Allocation Preference Configuration for duplicate prefConfigId
    
    * def deletedPrefConfigId = "6131b95f62188428b2b84f8c"
    
    Given path '/id/' + deletedPrefConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "This Manual Allocation Preference Configuration does not exist for given Vendor"
    And karate.log('Test Completed !')
    

	#REV2-16052
  Scenario: DELETE - Verify Allocation Executive to delete Manual Allocation Preference Configuration for duplicate prefConfigId with spaces
    
    * def deletedPrefConfigId = " 6131b95f62188428b2b84f8c "
    
    Given path '/id/' + deletedPrefConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "This Manual Allocation Preference Configuration does not exist for given Vendor"
    And karate.log('Test Completed !')


	#*********************************GET FC Scenarios*********************************
	
	
	 #REV2-16103
	 Scenario: GET - Verify Allocation Executive cannot fetch data for Manual-Allocation-Preference Quota Configuration with Invalid URL
		
		Given path '/fc'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
  	When method get
  	Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[*].message contains "http.request.not.found"  
 
	
  #REV2-16099
  Scenario: GET - Verify Allocation Executive cannot fetch  Manual-Allocation-Preference Quota Configuration data with Combination of blank and Valid values
  
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = ''
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
		And match response.errors[*].message contains "The Geography field is mandatory."
		And match response.errors[*].message contains "vendorType must not be blank."
	

  #REV2-16098
	Scenario: GET - Verify Allocation Executive cannot fetch Manual-Allocation-Preference Quota Configuration with blank values
	
		Given path '/fcs'
		And param deliveryMode = ' '
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = ' '
  	And param geoGroupId = ' '
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = ' '
  	When method get
  	Then status 400
  	And karate.log('Status : 400')  
  	And match response.errors[*].message contains "The Delivery mode field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
 		And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "vendorType must not be blank."
  	
 		
  #REV2-16097
	Scenario: GET - Verify Allocation Executive cannot fetch Manual-Allocation-Preference Quota Configuration with Combination of invalid and valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 20
  	And param size = 10
		And param vendorType = 'FC'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Requested pgId doesn't exist -> 20"
  
  
  #REV2-16095
	Scenario: GET - Verify Allocation Executive can fetch Manual-Allocation-Preference Quota Configuration with valid values
	
		Given path '/fcs'
  	And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
  	When method get
  	Then status 200
  	And karate.log('Status : 200')
  	
  	
	#*****************GET Carriers Scenarios*********************************
	
	#REV2-16359
	Scenario: GET - Verify Alloction Executive cannot fetch carrier Manual-Allocation-Preference Quota Config using Invalid URL
  
		Given path '/carris'	
		And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name111'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
		Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[*].message contains "http.request.not.found"
  	
   
  #REV2-16358
  Scenario: GET - Verify Alloction Executive cannot fetch Manual-Alloc-Preference Quota Config carriers with Combination of blank and Invalid values
  
  	Given path '/carriers'
   	And param deliveryMode = ' '
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name111'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'KR'
		And param vendorId = 'GFC_104'
		
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].errorCode contains "BAD_REQUEST"
  	
  
  #REV2-16357
	Scenario: GET - Verify Alloction Executive cannot fetch carrier Manual-Allocation-Preference Quota Config with blank values
	
		Given path '/carriers'	
		And param deliveryMode = ' '
		And param fieldName = ''
		And param fieldValues = ''
		And param fieldValues = ''
  	And param geoId = ''
  	And param geoGroupId = ''
  	And param operator = ''
  	And param page = ''
  	And param pgId = ''
  	And param size = ''
		And param vendorType = ''
		And param vendorId = ''
		
  	When method get
  	Then status 400
  	And karate.log('Status : 400')  
  	And match response.errors[*].message contains 'vendorType must not be blank.'
  	And match response.errors[*].message contains 'The Geo group field is mandatory.'
 		And match response.errors[*].message contains 'The Geo group field is mandatory.'
  	And match response.errors[*].message contains 'The Delivery mode field is mandatory.'
  	And match response.errors[*].message contains 'The Geography field is mandatory.'
  	And match response.errors[*].errorCode contains 'BAD_REQUEST'
 
  	
  #REV2-16356
	Scenario: GET - Verify Alloction Executive cannot fetch Manual-Alloc-Preference Quota Config carriers with Combination of invalid and valid values

		Given path '/carriers'
		And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name111'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CRP'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 400
  	And karate.log('Status : 400')
		And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> CR"
		
		
	#REV2-16355
	Scenario: GET - Verify Alloction Executive cannot fetch Manual-Alloc-Preference Quota Config carriers with All invalid values
	
		Given path '/carriers'
   	And param deliveryMode = 'hcourier'
		And param fieldName = 'rendorName'
		And param fieldValues = 'carrier_'
		And param fieldValues = '_name102'
  	And param geoId = 'abc'
  	And param geoGroupId = 'ccpune'
  	And param operator = 'EQUALTO'
  	And param page = '0'
  	And param pgId = '9'
  	And param size = '10'
		And param vendorType = 'CRP'
		And param vendorId = 'FC_1034'
		
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == "#notnull"
		
	
	#REV2-16354
	Scenario: GET - Verify Alloction Executive can fetch Manual-Allocation-Preference Quota Config for carrier with valid values
	
		Given path '/carriers'	
		And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name111'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
  	When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And karate.log('Response is : ', response)
  	And match response[*].id == "#notnull"
  	And karate.log('Test Completed !')
  	
  	
 	#***************GET FC Config Scenario****************
	 
	#REV2-29838
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with multiple FC name/ID separated by comma
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'FC_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
   
	#REV2-29837
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with FC ID OR FC Name field to be performed using Does not contain operator
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
	
	 
	#REV2-29836
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with FC ID OR FC Name field to be performed using Equal to operator
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
   
  #REV2-29835
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Invalid authorization token added for Allocation Executive
	
		* header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVk"
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
  	And match response.errors[0].message == "Token Invalid! Authentication Required"
  	
   
	#REV2-29834
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule page with Unsupported methods for endpoints
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		And request ''
		When method patch
  	Then status 405
  	And karate.log('Status : 405')
  	And match response.errors[0].message == "METHOD_NOT_ALLOWED"
  	
   
	#REV2-29832
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with missing any mandatory values
	
		Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = null
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors == '#notnull'
  	
  
	#REV2-29831
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Blank Mandatory values
	
		Given path '/configs'	
		And param baseGeoId = '411005'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = ''
		And param size = 20
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors == '#notnull'
  	
 
	#REV2-29830 | BUG ID - REV2-34111
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Invalid FC ID OR FC Name
	
		Given path '/configs'	
		And param baseGeoId = '411005'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'FC_Name182'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.errors == '#notnull'
  	
   
	#REV2-29829
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Invalid mandatory and optional values 
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendor_Name'
  	And param fieldValues = 'FC_Name182'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'abcr'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors == '#notnull'
  	
   
	#REV2-29828
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with valid Values 
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'FC_Name102'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	
 	#***************GET Carrier Config Scenario****************
	
	#REV2-29577
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with only mandatory field
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = ''
  	And param pgId = 3
		And param size = ''
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  
	
	#REV2-29576
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with multiple Carrier name/ID separated by comma
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_102','Carrier_108','Carrier_111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'	
  	
  	
	#REV2-29575
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with Carrier Name/ID and Does not contain Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_102','Carrier_108','Carrier_111'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	
	#REV2-29574
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with Carrier Name/ID and Contains Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_14'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
	
	
	#REV2-29573
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with Carrier Name/ID and Not equal to Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_101','carrier_102'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	
	#REV2-29572
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with Carrier Name/ID and Equal to Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name101','carrier_Name112','carrier_NAME111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	
	#REV2-29571
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with Missing any value in mandatory fields
	
		Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name101','carrier_Name112','carrier_NAME111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
  	
  	
	#REV2-29570
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with Combination of Valid/Invalid/Blank values
	
		Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name101','carrier_Name112','carrier_NAME111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 'abc'
		And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
  	
  	
	#REV2-29569
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with blank ids
	
		Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = ''
  	And param pgId = ''
		And param size = ''
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
  	
  	
	#REV2-29568
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with invalid values
	
		Given path '/configs'	
		And param baseGeoId = 'ab411005'
  	And param fieldName = 'vendor'
  	And param fieldValues = 'Carrier_111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 'abc'
		And param size = 11
		And param vendorType = 'xyz'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
  	
  	
	#REV2-29567
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule Page with valid values
	
		Given path '/configs'	
		And param baseGeoId = '411005'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name12'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = 3
		And param size = 15
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	
  	#******************GET Config-Id FC Scenarios**************************** 
      
  #REV2-30012
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with - multiple FC name/ID separated by comma
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_103', 'Fc_101', 'FC_102'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-30011
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - FC ID OR FC Name field to be performed using Equal to operator
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-30010
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with Invalid authorization token
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    * def invalidAuthToken = "abcdefghijklmno153454163"
    * header Authorization = invalidAuthToken
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And match response.errors[0].message contains 'Authentication Required'
    And karate.log('Test Completed !')
    
        
  #REV2-30009
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with Unsupported methods for endpoints
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		And request ''
		When method patch
  	Then status 405
  	And karate.log('Status : 405')
    And match response.errors[0].message contains 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
    
        
  #REV2-30007
	Scenario: GET - Verify Allocation Executive can search search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - missing values in any optional fields
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-30006
	Scenario: GET - Verify Allocation Executive can search search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - blank mandatory values
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
         
  #REV2-30005
	Scenario: GET - Verify Allocation Executive can search search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - Invalid FC ID OR FC Name 
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_nae101','c_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
        
  #REV2-30004
	Scenario: GET - Verify Allocation Executive can search search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - Invalid  mandatory and optional values 
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_nae101','c_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'aa'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
  #REV2-30003
	Scenario: GET - Verify Allocation Executive can search search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - valid Values 
	
		* def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
    
    #******************GET Config-Id Carrier Scenarios**************************** 
          
  #REV2-30108
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - No authorization token added
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    * def blankAuthToken = ""
    * header Authorization = blankAuthToken
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And match response.errors[0].message contains "Authentication Required"
    And karate.log('Test Completed !')
    
        
  #REV2-30106
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Unsupported methods for endpoints
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		And request ''
		When method patch
  	Then status 405
  	And karate.log('Status : 405')
    And match response.errors[0].message contains 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
    
       
  #REV2-30149
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Only mandatory fields
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = ''
  	And param size = ''
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
       
  #REV2-30148
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Carrier Name/ID and Equal to Operator
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
       
  #REV2-30147
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Missing any value in mandatory field
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
       
  #REV2-30146
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Combination of Valid/Invalid/Blank values
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = ''
  	And param fieldValues = 'Caier_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
       
  #REV2-30145
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Blank ids
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = 0
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
       
  #REV2-30144
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Invalid values
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Caier_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
      
  #REV2-30143
	Scenario: GET - Verify Allocation Executive can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with - Valid Values
	
	  * def postResult = call read('./manual-alloc-preference-config-alloc-exec-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103', 'carrier_105'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
    
     #******************GET FC SEARCH SCENARIOS**************************** 
     
     
  #REV2-29296
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration with valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
		When method get
		Then status 200
  	And karate.log('Status : 200')
  	
  	
  #REV2-29297
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration with invalid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
  	
  	
	#REV2-29298
	Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration with blank values
	
		Given path '/fcs'
		And param deliveryMode = ''
  	And param fieldName = ''
  	And param fieldValues = ''
  	And param fieldValues = ''
		And param geoId = ''
  	And param geoGroupId = ''
  	And param operator = ''
  	And param page = ''		
  	And param pgId = ''
  	And param size = ''
		And param vendorType = ''
  	When method get
  	Then status 400
  	And karate.log('Status : 400')  
  	And match response.errors[*].message contains "The Delivery mode field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
 		And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "vendorType must not be blank."
  
  
  #REV2-29299
	Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration with missing value in mandatory fields
	
		Given path '/fcs'
		And param deliveryMode = ''
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = ''
  	And param geoGroupId = ''
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = ''
  	When method get
  	Then status 400
  	And karate.log('Status : 400')  
  	And match response.errors[*].message contains "The Delivery mode field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
 		And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "vendorType must not be blank."
  	
 		
  #REV2-29300
	Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration with missing value in optional fields
	
		Given path '/fcs'
		And param deliveryMode = ''
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = ''
  	And param geoGroupId = ''
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = ''
  	When method get
  	Then status 400
  	And karate.log('Status : 400')  
  	And match response.errors[*].message contains "The Delivery mode field is mandatory."
  	And match response.errors[*].message contains "The Geo group field is mandatory."
 		And match response.errors[*].message contains "The Geography field is mandatory."
  	And match response.errors[*].message contains "vendorType must not be blank."
  	
  	
 	#REV2-29301
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator contains with valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'CONTAINS'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
		When method get
		Then status 200
  	And karate.log('Status : 200')
  	
	 	
  #REV2-29302
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator does not contains with valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
		When method get
		Then status 200
  	And karate.log('Status : 200')
  	
 
  #REV2-29303
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator equal to with valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
		When method get
		Then status 200
  	And karate.log('Status : 200')
  	
  
  #REV2-29304
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator not equal to with valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
		When method get
		Then status 200
  	And karate.log('Status : 200')
  	
 	
  #REV2-29305
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator contains with invalid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'CONTAINS'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
  	
  
  #REV2-29307
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator equal to with invalid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1@'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
  
  	
  #REV2-29308
  Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration in operator not equal to with invalid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1!'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
  	
  
  #REV2-29310
	Scenario: GET - Verify allocation exec can search Manual-Allocation-Preference Quota Configuration with invalid authorization token.
	
		* def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
  	* header Authorization = invalidAuthToken
  	
  	Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = 'Kolkata'
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FC'
  	When method get
  	Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].message contains "Token Invalid! Authentication Required"
  	
  	
  	
  	
  	