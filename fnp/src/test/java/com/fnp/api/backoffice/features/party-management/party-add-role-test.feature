Feature: API to Add role by partyId scenarios


  Background:
  	Given url backOfficeAPIBaseUrl
  	And header Accept = 'application/json'
  	And path '/simsim/v1/partyroles'
 	 	* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
  	* def authToken = loginResult.accessToken
  	* header Authorization = authToken
 	 	* def validPartyId = 'P_00939'
  	* def requestPayload = read('classpath:com/fnp/api/backoffice/data/addrolebypartyId.json')
  
  
  #REV2-14429
  Scenario: Add role by patyId for Invalid partyId
    * def partyId = 'P_00999'
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00102'
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Party Id not found'	
		
		
	#REV2-14428
	Scenario: Add role by patyId for valid data
    * def partyId = validPartyId
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00202'
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 201
		And karate.log('Status : 201')
		And karate.log(' Records found : ', response)
		And match response[0].partyId contains 'P_00939'
		And match response[0].active contains true
		And match response[0].roleId contains 'U_00202'
		And match response[0].primary contains false
		
		
	#REV2-14430
	Scenario: Add role by patyId for Invalid roleId in request body
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_0010200'
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Role not found'
		
		
	#REV2-14430
	Scenario: Add role by patyId for Invalid primary in request body
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = 'fal'
    * eval requestPayload[0].roleId = 'U_00102'
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'unprocessable.input.data'	
		And match response.errors[0].message contains 'Invalid input data'
		
		
		
	#REV2-14437
	Scenario: Add role by patyId for Unsupported method.
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00102'
    Given path '/' + partyId 
    And request requestPayload 
    When method put
		Then status 405
		And karate.log('Status : 405')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'unsupported.http.method'	
		And match response.errors[0].message contains 'Unsupported request Method. Contact the site administrator'
		
		
	#REV2-14436
	Scenario: Add role by patyId for Invalid endpoint URL method.
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00102'
    Given path '/simsim/vv1/partyroles/' + partyId 
    And request requestPayload 
    When method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'http.request.not.found'
		
		
	#REV2-14435
	Scenario: Add role by patyId for spaces in request body
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = '  false'
    * eval requestPayload[0].roleId = '  U_00102'
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Role not found'
		
		
	#REV2-14434
  Scenario: Add role by patyId for spaces in partyId
    * def partyId = '  P_00999'
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00102'
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Party Id not found'
		
		
	#REV2-14433
	# BugId : REV2-29875
	Scenario: Add role by patyId for blank values in request body
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = ''
    * eval requestPayload[0].roleId = ''
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Role not found'
		
		
	#REV2-14432
	Scenario: Add role by patyId for blank partyId.
    * def partyId = ''
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00102'
    Given path + '/' + partyId 
    And request requestPayload 
    When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Party Id not found'
		
		
	#REV2-14439
	Scenario: Add role by patyId for Invalid Authentication 
    * def partyId = 'P_00939'
    * eval requestPayload[0].primary = 'false'
    * eval requestPayload[0].roleId = 'U_00102'
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    Given path '/' + partyId 
    And request requestPayload 
    When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log(' Records found : ', response)
		And match response.errors[0].errorCode contains 'UNAUTHORIZED'	
		And match response.errors[0].message contains 'Token Invalid! Authentication Required'
		
	
		
		
		
    

 
