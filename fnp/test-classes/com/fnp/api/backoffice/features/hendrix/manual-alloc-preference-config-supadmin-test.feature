Feature: Manual Allocation Preference Configuration for Super Admin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
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

 	#REV2-14501 and REV2-14502
	@createManualAllocPreferenceConfig
  Scenario: POST - Verify Super Admin can create Manual Allocation Preference Configuration for all valid values
    
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
  Scenario: POST - Verify Super Admin can create Manual Allocation Preference Configuration for Carrier with all valid values
    
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
	
	
	#REV2-14503
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for all blank values
    
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
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
 	
	#REV2-14504
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for all duplicate values with spaces
    
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
    
	
	#REV2-14505
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid configName
    
    * eval requestPayloadCreate.configName = "12345-diwali"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found"
    And karate.log('Test Completed !')
    
	
	#REV2-14506
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid pgId
    
    * eval requestPayloadCreate.pgId = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
	
	#REV2-14507
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid baseGeoId
    
    * eval requestPayloadCreate.baseGeoId = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid characters found in baseGeoId."
    And karate.log('Test Completed !')
    

	#REV2-14508
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid quotas
    
    * eval requestPayloadCreate.quotas[0].value = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid_Input_Data"
    And karate.log('Test Completed !')  
  	
	
	#REV2-14509
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid vendorId
    
    * eval requestPayloadCreate.quotas[0].vendorId = "abc"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    
    
	#REV2-14510
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid vendorType
    
    * eval requestPayloadCreate.vendorType = "ABC"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "fromDate must be of future or present."
    And karate.log('Test Completed !')
    

	#REV2-14511
	Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid endpoint url
    
    * karate.log(requestPayloadCreate)
    
    Given path '/id'
    And request requestPayloadCreate
    When method post
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
	
	#REV2-14512
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid request body
  
    And request requestPayload
    * eval requestPayload.test = 'test'
    And karate.log(requestPayload)
    When method post
    Then status 400
    And print 'Response Errors are :', response.errors
    * def responseMessages = get response.errors[*].message
    And match response.errors[*].message contains "Invalid_Input_Data"
    * def status = response.status
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    

	#REV2-14513
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid fromDate
    
    * eval requestPayloadCreate.fromDate = "2022-09-04"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
  	
	#REV2-14514
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration for invalid thruDate
    
    * eval requestPayloadCreate.thruDate = "2022-11-04"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
	
	#REV2-14515
  Scenario: POST - Verify Super Admin to create Manual Allocation Preference Configuration with fromDate greater than thruDate
    
    * eval requestPayloadCreate.fromDate = "2022-11-04T05:47:15"
    * eval requestPayloadCreate.thruDate = "2022-09-04T05:47:15"
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Date fields having invalid value or format[Valid Format (ex. dd-MM-yyyy)]."
    And karate.log('Test Completed !')
    
   
  #REV2-15834
  Scenario: PUT - Verify Super Admin can update Manual Allocation Preference Configuration for all valid values
    
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
  

  #REV2-15835
  Scenario: PUT - Verify Super Admin cannot update Manual Allocation Preference Configuration for all invalid values
    
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
  
  	
  #REV2-15836
  Scenario: PUT - Verify Super Admin cannot update Manual Allocation Preference Configuration for invalid quotas value
    
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
  
	
  #REV2-15837
  Scenario: PUT - Verify Super Admin cannot update Manual Allocation Preference Configuration for all blank values
    
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
    And karate.log('Test Completed !')
    	

  #REV2-15838
  Scenario: PUT - Verify Super Admin cannot update Manual Allocation Preference Configuration for blank quotas value
    
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
    
    
  #REV2-15841
  Scenario: PUT - Verify Super Admin to update Manual Allocation Preference Configuration for invalid endpoint url
    
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    
    Given path '/id/' + prefConfigId + '/update'
    And request requestPayloadUpdate
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
      
     
	#REV2-15843
  Scenario: PUT - Verify Super Admin cannot update Manual Allocation Preference Configuration for Unsupported Methods
      
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    
    Given path '/id/' + prefConfigId 
    And request requestPayloadUpdate
    When method get
    Then status 405
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
      
      
	#REV2-15844
  Scenario: PUT - Verify Super Admin to update Manual Allocation Preference Configuration for invalid auth token
    
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVk"
    Given path '/id/' + prefConfigId
    And request requestPayloadUpdate
    When method put
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')
    
    
  #REV2-15924
  #BUG ID - REV2-24868
  Scenario: POST - Verify duplicate rule with Super Admin access with all values in only Mandatory fields
    
    * eval requestPayloadPostDuplicate.configName = requestPayloadPostDuplicate.configName + num
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response == "#notnull"
    And karate.log('Test Completed !')  
    
 
  #REV2-15921
  Scenario: POST - Verify duplicate rule with Super Admin access with Invalid data in request body
    
    * eval requestPayloadPostDuplicate.GEO = "abcdefgh"
    * eval requestPayloadPostDuplicate.idds = "1234abc"
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid_Input_Data"
    And karate.log('Test Completed !')
    

  #REV2-15918
  Scenario: POST - Verify duplicate rule with Super Admin access for Invalid Authorization Token
    
    * def invalidAuthToken = loginResult.accessToken + "aaaaasssssssssdddddd"
    * header Authorization = invalidAuthToken
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')   
    
        
  #REV2-15917
  Scenario: POST - Verify duplicate rule with Super Admin access with Unsupported methods for endpoint
    
    * eval requestPayloadPostDuplicate.configName = requestPayloadPostDuplicate.configName + num
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method patch
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
   
    * header Authorization = authToken
    Given path '/hendrix/v1/manual-allocation-preferences/_duplicate'
    And request requestPayloadPostDuplicate
    When method put
    Then status 405
    And karate.log('Response is : ', response)
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Status : 405')
    And karate.log('Test Completed !')
    
  
  #REV2-15915
  Scenario: POST - Verify duplicate rule with Super Admin access for Invalid endpoint URL
    
    Given path '/Duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 404
    And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
       
  #REV2-15913
  Scenario: POST - Verify duplicate rule with Super Admin access for missing value in any Mandatory field
    
    * eval requestPayloadPostDuplicate.configName = ""
    * eval requestPayloadPostDuplicate.vendorType = ""
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errorId == "#notnull"
    And karate.log('Test Completed !')  
  
    
  #REV2-15912
  Scenario: POST - Verify duplicate rule with Super Admin access with all blank fields
    
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
    

  #REV2-15911
  Scenario: POST - Verify duplicate rule with Super Admin access with invalid value for any field
    
    * eval requestPayloadPostDuplicate.applyToPgIds[0] = "sweets"
    * eval requestPayloadPostDuplicate.baseGeoId = "123&*"
    * eval requestPayloadPostDuplicate.configName = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    * karate.log(requestPayloadPostDuplicate)
    
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errorId == "#notnull"
    And karate.log('Test Completed !')  
       
            
	#REV2-16034
  Scenario: DELETE - Verify Super Admin can delete Manual Allocation Preference Configuration for valid prefConfigId
    
    * def result = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def prefConfigId = result.prefConfigId
    
    Given path '/id/' + prefConfigId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And match response.message contains "Deleted Successfully"
    And karate.log('Test Completed !')
    
    	
	#REV2-16035
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for invalid prefConfigId
    
    * def invalidPrefConfigId = "61304d41621"
    
    Given path '/id/' + invalidPrefConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "This Manual Allocation Preference Configuration does not exist for given Vendor"
    And karate.log('Test Completed !')
    
	
	#REV2-16036
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for blank prefConfigId
    
    * def blankPrefConfigId = ""
    
    Given path '/id/' + blankPrefConfigId
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')

		
	#REV2-16037
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for prefConfigId with only spaces
    
    * def prefConfigIdWithSpaces = "   "
    
    Given path '/id/' + prefConfigIdWithSpaces
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
	

	#REV2-16038
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for duplicate prefConfigId
    
    * def deletedPrefConfigId = "6131b95f62188428b2b84f8c"
    
    Given path '/id/' + deletedPrefConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "This Manual Allocation Preference Configuration does not exist for given Vendor"
    And karate.log('Test Completed !')
    

	#REV2-16039
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for duplicate prefConfigId with spaces
    
    * def deletedPrefConfigId = " 6131b95f62188428b2b84f8c "
    
    Given path '/id/' + deletedPrefConfigId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "This Manual Allocation Preference Configuration does not exist for given Vendor"
    And karate.log('Test Completed !')
    
	
	#REV2-16040
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for invalid endpoint url
    
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    
    Given path '/id/' + prefConfigId + '/delete'
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
	
	#REV2-16042 and REV2-15842
  Scenario: DELETE - Verify unsupported method for Super Admin to delete Manual Allocation Preference Configuration
    
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    
    Given path '/id/' + prefConfigId
    When method get
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message == 'METHOD_NOT_ALLOWED'
    And karate.log('Test Completed !')
    

	#REV2-16043
  Scenario: DELETE - Verify Super Admin to delete Manual Allocation Preference Configuration for invalid auth token
    
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVk"
    Given path '/id/' + prefConfigId
    When method delete
    Then status 401
    And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')
    
    
  #******************GET FC Scenarios****************************
  
	
  #REV2-16112/#REV2-29280
  Scenario: GET - Verify Super Admin cannot access Manual-Allocation-Preference Quota Configuration with Invalid URL
	
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
  	
    
  #REV2-16111/#REV2-29273
  Scenario: GET - Verify Super Admin cannot fetch Manual-Allocation-Preference Quota Configuration with Combination of blank and Invalid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = 'bday1'
  	And param fieldValues = 'bday2'
		And param geoId = 'India'
  	And param geoGroupId = ''
  	And param operator = 'EQUAL_TO'
  	And param page = 0		
  	And param pgId = 4
  	And param size = 10
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "The Geo group field is mandatory."
	
	
	#REV2-16110/#REV2-29272/#REV2-29274
	Scenario: GET - Verify Super Admin cannot fetch Manual-Allocation-Preference Quota Configuration with blank values
	
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
 
 	
  #REV2-16109
  Scenario: GET - Verify Super Admin cannot fetch Manual-Allocation-Preference Quota Configuration with Combination of invalid and valid values
	
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
 

  #REV2-16108/#REV2-29270
  Scenario: GET - Verify Super Admin cannot fetch Manual-Allocation-Preference Quota Configuration with invalid values
	
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
 
 
  #REV2-16107/#REV2-29269
  Scenario: GET - Verify Super Admin can fetch Manual-Allocation-Preference Quota Configuration with valid values
	
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
  
  
	#REV2-16100/#REV2-29279
	Scenario: GET - Verify request with Invalid authorization Credential
	
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


	 #******************GET Carrier Scenarios****************************
	
	
	#REV2-16352
	Scenario: GET - Verify cannot fetch Manual-Allocation-Preference Quota Configuration carrier with only spaces in the parameter
	
		Given path '/carriers'	
		And param deliveryMode = ' '
		And param fieldName = ' '
		And param fieldValues = ' '
		And param fieldValues = ' '
  	And param geoId = ' '
  	And param geoGroupId = ' '
  	And param operator = ' '
  	And param page = ' '
  	And param pgId = '  '
  	And param size = ' '
		And param vendorType = ' '
		And param vendorId = '  '
		
	 	When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errorId == "#notnull"
    
  
	#REV2-16351
	Scenario: GET - Verify cannot fetch Manual-Allocation-Preference Quota Configuration carrier with Missing Mandatory Parameters
	
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
		
	 	When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains 'VendorId must not be blank.'
    And match response.errors[*].message contains 'vendorType must not be blank.'
    
  
  #REV2-16350
	Scenario: GET - Verify can fetch Manual-Allocation-Preference Quota Configuration carrier with Missing Optional Parameters
	
		Given path '/carriers'	
		And param deliveryMode = 'courier'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'	
  	And param pgId = '4'
  	And param vendorType = 'CR'
		And param vendorId = 'FC_104'
  	
	 	When method get
    Then status 200
    And karate.log('Status : 200')
    
      
	#REV2-16349/REV2-30048
	Scenario: GET - Verify can fetch Manual-Allocation-Preference Quota Configuration carrier with Missing any value in Optional fields
	
		Given path '/carriers'	
		And param deliveryMode = 'courier'
		And param fieldName = ''
		And param fieldValues = ''
		And param fieldValues = ''
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'EQUAL_TO'
  	And param page = ''
  	And param pgId = '4'
  	And param size = ''
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
	 	When method get
    Then status 200
    And karate.log('Status : 200')
    
 
  #REV2-16348/REV2-30047
	Scenario: GET - Verify cannot fetch Manual-Allocation-Preference Quota Configuration carrier with Missing any value in Mandatory fields
	
		Given path '/carriers'	
		And param deliveryMode = ''
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
		And param vendorId = ''
		
	 	When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "VendorId must not be blank."
    And match response.errors[*].message contains "The Delivery mode field is mandatory."
    
  
  #REV2-16347/REV2-29913
	Scenario: GET - Verify super admin cannot fetch Manual-Allocation-Preference Quota Configuration carrier API with Unsupported Methods for endpoints
  
		Given request ''
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
		
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "METHOD_NOT_ALLOWED"
    And karate.log('Test Completed !')
    
     
  #REV2-16344/REV2-29909
	Scenario: GET - Verify Super Admin cannot access Manual-Allocation-Preference Quota Config for carrier with Invalid URL
  
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
    
   
	#REV2-16341/REV2-29910
	Scenario: GET - Verify request with Invalid authorization Credential
	
		* def invalidAuthToken = loginResult.accessToken + "ddddddeeeeeyyyyrrr"
  	* header Authorization = invalidAuthToken
  	
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
  	Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].message contains "Token Invalid! Authentication Required"
 
     
	#REV2-16340
  Scenario: GET - Verify Super Admin cannot fetch Manual-Alloc-Preference Quota Config carriers with Combination of blank and Valid values
  
  	Given path '/carriers'
   	And param deliveryMode = ' '
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name111'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = ''
  	And param operator = 'EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == "#notnull"
  	And match response.errors[*].message contains 'The Geo group field is mandatory.'
   	And match response.errors[*].message contains 'The Delivery mode field is mandatory.'
   
   
	#REV2-16339
	Scenario: GET - Verify Super Admin cannot fetch Manual-Alloc-Preference Quota Config carriers with blank values
	
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
	
	
	#REV2-16338/REV2-29921
	Scenario: GET - Verify Super Admin cannot fetch Manual-Alloc-Preference Quota Config carriers with Combination of invalid and valid values
		
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
		
	 
	#REV2-16337
	Scenario: GET - Verify Super Admin cannot fetch Manual-Alloc-Preference Quota Config carriers with All invalid values
	
		Given path '/carriers'
   	And param deliveryMode = 'hcourier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'cr102'
  	And param geoId = 'abc'
  	And param geoGroupId = 'ccpune'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = '0'
  	And param pgId = '9'
  	And param size = '10'
		And param vendorType = 'CRP'
		And param vendorId = 'FC_1034'
		
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == "#notnull"


	#REV2-16336/REV2-29917/REV2-29906/REV2-29900
  Scenario: GET - Verify Super Admin can fetch Manual-Allocation-Preference Quota Configuration with valid values
	
		Given path '/carriers'
		And param deliveryMode = 'hd'
		And param fieldName = 'vendorName'
		And param fieldValues = ['carrier_name101','carrier_name102']
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
  	
   
  #REV2-29911
	Scenario: GET - Verify request with authorization code not added for super admin
	
		* def invalidAuthToken = ""
  	* header Authorization = invalidAuthToken
  	
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
  	Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].message contains "Token Invalid! Authentication Required"
		

	#REV2-29922/REV2-29905
	Scenario: GET - Verify Super Admin can search Manual-Alloc-Pref Quota Config carriers with invalid value in fieldname with Not equal to Operator

		Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'rendorName'
		And param fieldValues = 'cr102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
	
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')

	  	
  #REV2-29921
	Scenario: GET - Verify Super Admin can search Manual-Alloc-Pref Quota Config carriers with invalid value in fieldname with equal to Operator
	
		Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'rendorName'
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
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  	
	
	#REV2-29920/REV2-29903
	Scenario: GET - Verify Super Admin can search Manual-Alloc-Pref Quota Config carriers with invalid value in fieldname with Does Not Contains Operator
	
		Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'rendorName'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  	

  #REV2-29919/REV2-29902
	Scenario:  GET - Verify search Manual-Alloc-Pref Quota Config carriers with invalid value in fieldname with Contains Operator for super admin
  	
  	Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'rendorName'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'CONTAINS'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  	

	#REV2-29918/REV2-29901
	Scenario: GET - Verify search Manual-Alloc-Pref Quota Config carriers with valid value in fieldname and Not equal to Operator for super admin
  
  	Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  
  
	#REV2-29916/REV2-29899
	Scenario: GET - Verify search Manual-Alloc-Pref Quota Config carriers with valid value in fieldname and Does Not Contains Operator for super admin
		
		Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  
 
	#REV2-29915/REV2-29898/REV2-29897
	Scenario: GET - Verify search Manual-Alloc-Pref Quota Config carriers with valid value in fieldname and Contains Operator for super admin
		
		Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'carrier_name102'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'CONTAINS'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  
 
	#REV2-29914
	Scenario: GET - Verify search Manual-Alloc-Pref Quota Config carriers with blank fieldValues for super admin
	
		Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = ''
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'CONTAINS'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  	
	 
  #REV2-30046
  Scenario: GET - Verify super admin can search Manual-Alloc-Pref Quota Config carriers with combination of multiple valid and invalid values for fieldValues
  
  	Given path '/carriers'
   	And param deliveryMode = 'courier'
		And param fieldName = 'vendorName'
		And param fieldValues = 'cr108','carrier_name111'
  	And param geoId = 'India'
  	And param geoGroupId = 'pune'
  	And param operator = 'CONTAINS'
  	And param page = '0'
  	And param pgId = '4'
  	And param size = '10'
		And param vendorType = 'CR'
		And param vendorId = 'FC_104'
		
		When method get
  	Then status 200
  	And karate.log('Response is : ', response)
  	And karate.log('Status : 200')
  	
  
  #******************GET Config FC Scenarios****************************
	   
	#REV2-29826
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule page with Only Mandatory fields
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = null
  	And param pgId = 3
		And param size = null
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
	  
	#REV2-29825
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule page with Editing Existing values
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name102'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
    
	#REV2-29824
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with multiple FC name/ID separated by comma
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name102', 'FC_Name101', 'Fc_name103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  
     
  #REV2-29823
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with FC ID OR FC Name field to be performed using Does not contain operator
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name10'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
       
  #REV2-29822
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with FC ID OR FC Name field to be performed using Contains operator
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_11'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
       
  #REV2-29821
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with FC ID OR FC Name field to be performed using Not Equal To operator
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_103'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[*] !contains "fc_103"
  	
      
  #REV2-29820
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with FC ID OR FC Name field to be performed using Equal To operator
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
      
  #REV2-29819
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with invalid authorization token
	
    * header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiJTXzAwMDAyIiwiYXVk"
    Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')
    
     
  #REV2-29818
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with No authorization token added
	
    * header Authorization = ""
    Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And karate.log('Test Completed !')
    
       
  #REV2-29816
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule page with Unsupported methods for endpoints
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		And request ''
		When method patch
  	Then status 405
  	And karate.log('Status : 405')
  	And match response.errors[0].message == "METHOD_NOT_ALLOWED"
  	
     
  #REV2-29814
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule page with Invalid Endpoint URL
	
		Given path '/config/abcd'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[0].message == "http.request.not.found"
  	
    
  #REV2-29813
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with missing any mandatory values
	
		Given path '/configs'	
		And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = null
		And param size = 20
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors == '#notnull'
  	
    
  #REV2-29812
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Combination of Valid/Invalid/Blank values
	
		Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = ''
  	And param page = 0
  	And param pgId = 'abcd'
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors == '#notnull'
  	
  	  
  #REV2-29810
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Invalid values 
	
		Given path '/configs'	
		And param baseGeoId = '411008abc'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102', 'Fc_103','fc_101'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = 'abc'
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors == '#notnull'
  	
    
  #REV2-29809
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule Page with Missing any value in optional fields 
	
		Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_10'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = '3'
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
    
  #REV2-29808
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Add Rule page with valid Values 
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'FC_Name102', 'fc_name105'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'fc'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	
  #******************GET Config Carrier Scenarios****************************
  
	#REV2-29566
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - where no data available for combination
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name152', 'carrier_name155'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#[]'
  	
    
	#REV2-29565
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with only mandatory field
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = ''
  	And param pgId = 5
		And param size = ''
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    
      
	#REV2-29564
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with editing the search values
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_104'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	  
	#REV2-29563
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with multiple Carrier name/ID separated by comma
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name104', 'Carrier_Name108', 'Carrier_Name111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
  	    
  #REV2-29562
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with Carrier Name/ID and DOES_NOT_CONTAIN Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_104', 'Carrier_101', 'Carrier_102'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
      
  #REV2-29561
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with Carrier Name/ID and CONTAINS Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name15'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
      
  #REV2-29560
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with Carrier Name/ID and NOT_EQUAL_TO Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103','Carrier_101','Carrier_108','Carrier_105'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
  	
      
  #REV2-29559
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with Carrier Name/ID and EQUAL_TO Operator
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name151','carrier_name111','Carrier_Name121','carrier_Name141'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.total == 4
  	
   
  #REV2-29558
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - Missing any value in optional fields
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name151','carrier_name111','Carrier_Name121','carrier_Name141'
  	And param operator = 'EQUAL_TO'
  	And param page = ''
  	And param pgId = 5
		And param size = ''
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.total == 4
  	
  	    
  #REV2-29555
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - Invalid URL
	
		Given path '/conf'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_name151','carrier_name111','Carrier_Name121','carrier_Name141'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 5
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[*].message contains 'http.request.not.found'
  	
  	    
  #REV2-29553
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - where Authorization code not added
	
	  * header Authorization = ""
    Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-29552
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with Invalid authorization Credential for Super Admin
	
	  * header Authorization = "rfsegrdhfhgfjgj"
    Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And match response.errors[0].message contains 'Token Invalid! Authentication Required'
    And karate.log('Test Completed !')
  	
  	     
  #REV2-29551
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - with Unsupported methods
	
	  Given path '/configs'	
		And param baseGeoId = '411003'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_102', 'carrier_103','CARRIER_101'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'cr'
		And request ''
		When method patch
  	Then status 405
  	And karate.log('Status : 405')
  	And match response.errors[0].message == "METHOD_NOT_ALLOWED"
    
        
  #REV2-29550
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - Missing any value in mandatory fields
	
	  Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_102', 'carrier_103','CARRIER_101'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param pgId = ''
		And param size = 20
		And param vendorType = 'cr'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errors[*] == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-29549
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - Combination of Valid/Invalid/Blank values
	
	  Given path '/configs'	
		And param baseGeoId = ''
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Cr_102', 'carrier_103','CARRIER_101'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 'abc'
		And param size = 20
		And param vendorType = 'cr'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errors[*] == '#notnull'
    And karate.log('Test Completed !')
  	
  	    
  #REV2-29548
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - blank ids
	
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
    And match response.errors[*] == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-29546
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - invalid values
	
	  Given path '/configs'	
		And param baseGeoId = '411003abc'
  	And param fieldName = 'vendor___Name'
  	And param fieldValues = 'cr_111'
  	And param operator = 'equal_to'
  	And param page = 0
  	And param pgId = 'abc'
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errors[*] == '#notnull'
    And karate.log('Test Completed !')
    
      
  #REV2-29545
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Add Rule page - valid values
	
	  Given path '/configs'	
		And param baseGeoId = '411005'
  	And param fieldName = 'vendorName'
  	And param fieldValues = 'carrier_Name111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = '5'
		And param size = 10
		And param vendorType = 'cr'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
    #******************GET Config-Id FC Scenarios**************************** 
     
  #REV2-30001
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with - Combination of Valid/Invalid/Blank values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId + num
		And param fieldName = 'vendorName'
  	And param fieldValues = ''
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
    
  #REV2-30000
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with - Spaces added in field values
	
	  Given path '/configs/id/' + '    '
		And param fieldName = '     '
  	And param fieldValues = '    '
  	And param operator = '    '
  	And param page = 0
  	And param size = 10
		And param vendorType = '    '
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !') 
    
      
  #REV2-29999
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with - Editing Existing values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
       
  #REV2-29998
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - FC ID OR FC Name field with multiple FC name/ID separated by comma
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    
        
  #REV2-29997
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - FC ID OR FC Name field to be performed using Does not contain operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_103', 'Fc_101', 'FC_102'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
         
  #REV2-29996
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - FC ID OR FC Name field to be performed using Contains operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_14'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-29995
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - FC ID OR FC Name field to be performed using Not Equal to operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data[*] == '#notnull'
    And karate.log('Test Completed !')
    
            
  #REV2-29994
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - FC ID OR FC Name field to be performed using Equal to operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    
       
  #REV2-29992
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with No authorization token added
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    * def blankAuthToken = ""
    * header Authorization = blankAuthToken
    
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
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
          
  #REV2-29991
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with Invalid authorization token
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
            
  #REV2-29990
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with Unsupported methods for endpoints
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
            
  #REV2-29988
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page with Invalid Endpoint URL
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/config/id/' + resId + num 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 404
  	And karate.log('Status : 404')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
            
  #REV2-29987
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - missing any mandatory values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    
            
  #REV2-29986
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - Blank values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    
            
  #REV2-29985
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - Invalid values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'fc_name101','Fc_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'aa'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
        
  #REV2-29984
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - Entering only Mandatory values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    
        
  #REV2-29983
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - missing values in any optional fields
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
    
       
  #REV2-29982
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - valid Values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
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
     
  #REV2-30107
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Invalid authorization token
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    * def invalidAuthToken = "abcdefghijklmno153454163"
    * header Authorization = invalidAuthToken
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 401
  	And karate.log('Status : 401')
    And match response.errors[0].message contains "Authentication Required"
    And karate.log('Test Completed !')
    
      
  #REV2-30142
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page where no data available for combination
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name158'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == []
    And karate.log('Test Completed !') 
     
   
  #REV2-30141
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with only mandatory field
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
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
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
   
     
  #REV2-30139
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with multiple Carrier name/ID separated by comma
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name111', 'carrier_name118', 'CARRIER_NAME121'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
    
      
  #REV2-30138
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Carrier Name/ID and Does not contain Operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_10'
  	And param operator = 'DOES_NOT_CONTAIN'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
   
     
  #REV2-30137
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Carrier Name/ID and Contains Operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_14'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
   
     
  #REV2-30136
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Carrier Name/ID and Not equal to Operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_101', 'carRieR_102'
  	And param operator = 'NOT_EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
   
     
  #REV2-30135
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Carrier Name/ID and Equal to Operator
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_151', 'carRieR_142'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
    
      
  #REV2-30134
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Missing any value in optional fields
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data[0].quota == '#notnull'
    And karate.log('Test Completed !') 
    
       
  #REV2-30132
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Invalid URL
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/conf/id/' + num 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_151', 'carRieR_142'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 404
  	And karate.log('Status : 404')
  	And match response.errors[0].message == 'http.request.not.found'
    And karate.log('Test Completed !')
    
      
  #REV2-30131
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Missing any value in mandatory fields
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId  
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_151', 'carRieR_142'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains 'must not be blank'
    And karate.log('Test Completed !')
   
     
  #REV2-30130
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Combination of Valid/Invalid/Blank values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId  
		And param fieldName = 'vendorId'
  	And param fieldValues = 'carrier_151', 'carRieR_142'
  	And param operator = ''
  	And param page = 0
  	And param size = 10
		And param vendorType = 'abc'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
      
  #REV2-30129
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with blank ids
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId  
		And param fieldName = ''
  	And param fieldValues = ''
  	And param operator = ''
  	And param page = ''
  	And param size = ''
		And param vendorType = ''
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains 'must not be blank'
    And karate.log('Test Completed !')
    
      
  #REV2-30128
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with space in the parameters
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId  
		And param fieldName = '   '
  	And param fieldValues = '   '
  	And param operator = '    '
  	And param page = '    '
  	And param size = '         '
		And param vendorType = ' CR     '
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
      
  #REV2-30127
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with invalid values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name102', 'carrier_name101', 'carrier_name103'
  	And param operator = 'EQUAL'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'abc'
		When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errorId == '#notnull'
    And karate.log('Test Completed !')
    
     
  #REV2-30126
	Scenario: GET - Verify Super Admin can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page with Valid values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorName'
  	And param fieldValues = 'Carrier_Name102', 'carrier_name101', 'carrier_name103'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
    #******************GET FC SEARCH SCENARIOS**************************** 
 	
  #REV2-29271
	Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc with only spaces in the parameter
	
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
		And param vendorType = 'F C'
	 	When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
    
  
  #REV2-29275
	Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc with Unsupported methods
	
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
		And request ''
    When method patch
  	Then status 405
  	And karate.log('Status : 405')
  	And match response.errors[0].message == "METHOD_NOT_ALLOWED"
  
  	
  #REV2-29276
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc with missing value in optional field
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = ''
  	And param fieldValues = ''
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
  
  
 	#REV2-29278
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc with Authentication code not added
  
  	* header Authorization = ""
  	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName'
  	And param fieldValues = ''
  	And param fieldValues = ''
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
  	And match response.errors[0].message == "Token Invalid! Authentication Required"
  
  
 	#REV2-29281
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator Contains with valid values
	
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
  	
 
  #REV2-29282
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator Does not Contains with valid values
	
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
  	
  	
 	#REV2-29283
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator Equal to with valid values
	
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
  	
 	
  #REV2-29284
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator not Equal to with valid values
	
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
  
 
  #REV2-29285
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator contains with invalid values
	
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
  
  	
  #REV2-29286
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator does not contains with invalid values
	
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
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
  	
  	
 	#REV2-29287
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator equal to with invalid values
	
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
  	
  	
  #REV2-29288
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator not equal to with invalid values
	
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
		And param vendorType = 'FCP'
  	When method get
  	Then status 400
  	And karate.log('Status : 400')
  	And match response.errors[0].message contains "Vendor Type Has Unknown Value, Allowed Values -> FC"
  	
  	
 	#REV2-29289/#REV2-29290/#REV2-29291/#REV2-29292
  Scenario: GET - Verify Super admin can search Manual-Allocation-Preference Configuration fc in operator Contains with valid values
	
		Given path '/fcs'
		And param deliveryMode = 'courier'
  	And param fieldName = 'configName','configName1','configName3'
  	And param fieldValues = 'bday1','bday2'
  	And param fieldValues = 'bday3'
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
  	
  	
    