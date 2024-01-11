Feature: Party list Contact info Scenarios

	Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
  
	#REV2-19294
	Scenario: GET - Verify roles by PartyList for Super Admin can access- with valid values
	
		* def partyId = 'P_00177'
				
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
		And karate.log('Test Completed !')
		
	 
	#REV2-19295
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- Invalid values for all fields
	
		* def partyId = 'P_001776'
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'true'
		And  param page = "ab"
		And  param size = "abcd"
		And  param sortParam = 'contactType:dsc'
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "invalid.value.forpage"
		And karate.log('Test Completed !')
		
	
	#Defect: REV2-31140
	#REV2-19296
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- with Invalid partyId
	
		* def partyId = '  @P_001776 '
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "invalid.value.forpage"
		And karate.log('Test Completed !')
		
	
	#REV2-19297
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- with Invalid ContactExpired value
	
		* def partyId = 'P_00177'
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 10
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "invalid.value.forisContactExpired"
		And karate.log('Test Completed !')
		
	
	#REV2-19298
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- with Invalid Page value
	
		* def partyId = 'P_00177'
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = "abcd"
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'invalid.value.forpage'
		And karate.log('Test Completed !')
		
	
	#REV2-19299
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- with Invalid Size value
	
		* def partyId = 'P_00177'
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = "sbcd"
		And  param sortParam = 'contactType:asc'
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "invalid.value.forsize"
		And karate.log('Test Completed !')
		
	
	#REV2-19300
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- with Invalid SortParam value
	
		* def partyId = 'P_00177'
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 1234
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid data url param "
		And karate.log('Test Completed !')
		
	
	#REV2-19301
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access- with Multiple spaces in all fields
	
		* def partyId = ' P_0017 7 '
		
		Given path '/partycontacts/' + partyId
		And  param isContactExpired =  ' fal se '
		And  param page =  0
		And  param size =  10
		And  param sortParam = ' contactType:desc '
		When method get
  	Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "invalid.value.forisContactExpired"
		And karate.log('Test Completed !')
		
	
	#REV2-19302
	Scenario: GET - Verify roles by PartyList for Super Admin access- try blank value in all fields
	
		* def partyId = '  '
			
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = '  '
		And  param page = 0 
		And  param size = 0  
		And  param sortParam = '  '
		When method get
	  Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "invalid.value.forisContactExpired"
		And karate.log('Test Completed !')
		
	
	#REV2-19303
	Scenario: GET - Verify roles by PartyList for Super Admin can access- with only partyId value
	
		* def partyId = 'P_00177'
				
		Given path '/partycontacts/' + partyId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
		And karate.log('Test Completed !')
		
		
	#REV2-19304
	Scenario: GET - Verify roles by PartyList for Super Admin can access- with only optional parameters
	
		Given  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And karate.log('Test Completed !')
	
	
	#REV2-19305
	Scenario: GET - Verify roles by PartyList for Super Admin cannot access - with Invalid URL
	
		* def partyId = 'P_00177'
		
		Given path '/partycontac/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message == "http.request.not.found"
		And karate.log('Test Completed !')
		
		
	#REV2-19306
	Scenario: GET - Verify Unsupported Method by PartyList for Super Admin access - Valid value in Endpoint URL
	
		* def partyId = 'P_00177'
		* def requestPayload = {}
			
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When request requestPayload
		And method patch
	  Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		And karate.log('Test Completed !')
		
		
	#REV2-19307
	Scenario: GET - Verify roles by PartyList with Super Admin access- with invalid authentication
	
		* def partyId = 'P_001776'
		* def invalidAuthToken = loginResult.accessToken + "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
			
		Given path '/partycontacts/' + partyId
		And  param isContactExpired = 'false'
		And  param page = 0
		And  param size = 10
		And  param sortParam = 'contactType:asc'
		When method get
	  Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
		
    	
    	