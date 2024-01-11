Feature: Manual Allocation Preference Configuration for Allocation Manager role

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/hendrix/v1/manual-allocation-preferences'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'allocMgr'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/hendrix/manual-alloc-pref-config.json')
    * def requestPayloadCreate = requestPayload[0]
    * def requestPayloadUpdate = requestPayload[1]
    
    * def requestPayloadPostDuplicate = read('classpath:com/fnp/api/backoffice/data/hendrix/manual-alloc-preference-post-duplicate.json')
	
		* def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    
  #REV2-15926
  Scenario: POST - Verify Allocation Manager can create Manual Allocation Preference Configuration Duplicate Rule
  
  	* eval requestPayloadPostDuplicate.configName = requestPayloadPostDuplicate.configName + num
  	
    Given path '/_duplicate'
    And request requestPayloadPostDuplicate
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response == "#notnull"
    And karate.log('Test Completed !') 
    
	
	#REV2-14494
  Scenario: POST - Verify 403 error for Allocation Manager to create Manual Allocation Preference Configuration
    
    * karate.log(requestPayloadCreate)
    
    Given request requestPayloadCreate
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "fromDate must be of future or present."
    And karate.log('Test Completed !')
    

  #REV2-15846
  Scenario: PUT - Verify  Allocation Manager can update Manual Allocation Preference Configuration
    
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
  
    
	#REV2-16046
  Scenario: DELETE - Verify 403 error for Allocation Manager to delete Manual Allocation Preference Configuration
  
    * def prefConfigId = "6131b95f62188428b2b84f8c"
    Given path '/id/' + prefConfigId
    When method delete
    Then status 403
    And karate.log('Status : 403')
    And match response.errors[0].message == "Access_Denied"
    And karate.log('Test Completed !')

    
   #*************GET  FC Scenario ****************


	#REV2-16105/REV2-29311
	Scenario: GET - Verify 403 error for Manual-Allocation-Preference Quota Configuration FC for Allocation Manager role
	
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
  		
	
	#***************GET Carrier Scenario****************
	

	#REV2-16353/REV2-29923
	Scenario: GET - Verify Allocation Manager can fetch Manual-Allocation-Preference Quota Configuration Carrier 
	
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
	
	#REV2-29839
	Scenario: GET - Verify 403 error for Manual-Allocation-Preference Quota Configuration FC for Search on Add Rule Page for Allocation Manager role
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'FC_102'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'FC'
		When method get
  	Then status 403
  	And karate.log('Status : 403')
  	And match response.errors[0].message contains "Access_Denied"
  	
  	
  #***************GET Carrier Config Scenario****************
	
	#REV2-29556
	Scenario: GET - Verify 403 error for Manual-Allocation-Preference Quota Configuration Carrier for Search on Add Rule Page for Allocation Manager role
	
		Given path '/configs'	
		And param baseGeoId = '411001'
  	And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param pgId = 3
		And param size = 20
		And param vendorType = 'CR'
		When method get
  	Then status 403
  	And karate.log('Status : 403')
  	And match response.errors[0].message contains "Access_Denied"
  	
  	
  	#******************GET Config-Id FC Scenarios**************************** 
  	 
  #REV2-29993
	Scenario: GET - Verify Allocation Manager can search Manual-Allocation-Preference Quota Configuration FC on Edit/Duplicate rule page for - valid Values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfig')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'fc_151','Fc_132'
  	And param operator = 'CONTAINS'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'FC'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
    And match response.data == '#notnull'
    And karate.log('Test Completed !')
    
    
    #******************GET Config-Id Carrier Scenarios**************************** 
    
  #REV2-30133
	Scenario: GET - Verify Allocation Manager can search Manual-Allocation-Preference Quota Configuration Carrier on Edit/Duplicate rule page for - valid Values
	
		* def postResult = call read('./manual-alloc-preference-config-supadmin-test.feature@createManualAllocPreferenceConfigCarrier')
    * def resId = postResult.response.id
    
	  Given path '/configs/id/' + resId 
		And param fieldName = 'vendorId'
  	And param fieldValues = 'Carrier_102', 'carrier_151', 'CARRIER_111'
  	And param operator = 'EQUAL_TO'
  	And param page = 0
  	And param size = 10
		And param vendorType = 'CR'
		When method get
  	Then status 200
  	And karate.log('Status : 200')
  	And match response.data == '#notnull'
    And karate.log('Test Completed !')
  
  	