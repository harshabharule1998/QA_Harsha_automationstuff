Feature: API to get Additional Roles scenarios


  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/simsim/v1/get-other-roles'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def validpartyTypeId = 'S_70001'
    * def validroleId = 'U_00102'
    
  
  #REV2-12062
  Scenario: GET - Verify Super admin is able to fetch additional roles for valid partyTypeId and roleId
    * def partyTypeId = validpartyTypeId
    * def roleId = validroleId
    Given path '/' + partyTypeId + '/' + roleId
    When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
		And match response[*].createdBy contains '#notnull'
		And match response[*].createdAt contains '#notnull'
		And match response[*].updatedBy contains '#notnull'
		And match response[*].updatedAt contains '#notnull'
		And match response[*].id contains '#notnull'
		And match response[*].name contains '#notnull'
		And match response[*].description contains '#notnull'
		
		
	#REV2-12063
  Scenario: GET - Verify Super admin is able to fetch additional roles for Invalid partyTypeId 
    * def partyTypeId = 'S_55501'
    * def roleId = validroleId
    Given path '/' + partyTypeId + '/' + roleId
    When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)	
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains ' Party Type Id not found'	
		
		
	#REV2-12063
  Scenario: GET - Verify Super admin is able to fetch additional roles for Invalid roleId 
    * def partyTypeId = validpartyTypeId
    * def roleId = 'U_000152'
    Given path '/' + partyTypeId + '/' + roleId
    When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log(' Records found : ', response)	
		And match response.errors[0].errorCode contains 'BAD_REQUEST'	
		And match response.errors[0].message contains 'Role not found'		
		
		
	#REV2-12064
	Scenario: GET - Verify Super admin is able to fetch additional roles for blank partyTypeId and roleId 
    * def partyTypeId = ''
    * def roleId = ''
    Given path '/' + partyTypeId + '/' + roleId
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)	
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'http.request.not.found'	
		
		
	#REV2-12065
	Scenario: GET - Verify Super admin is able to fetch additional roles for invalid endpoint URL
    * def partyTypeId = validpartyTypeId
    * def roleId = validroleId
    Given path '/simsim/vv1/get-other-roles' + partyTypeId + '/' + roleId
    When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log(' Records found : ', response)	
		And match response.errors[0].errorCode contains 'NOT_FOUND'	
		And match response.errors[0].message contains 'http.request.not.found'	
		
		
	#REV2-12067	
	Scenario: GET - Verify Super admin is able to fetch additional roles for unsupported Method
    * def partyTypeId = validpartyTypeId
    * def roleId = validroleId
    Given path '/' + partyTypeId + '/' + roleId
    When method delete
		Then status 405
		And karate.log('Status : 405')
		And karate.log(' Records found : ', response)	
		And match response.errors[0].errorCode contains 'unsupported.http.method'	
		And match response.errors[0].message contains 'Unsupported request Method. Contact the site administrator'		
		
		
	#REV2-12068
	Scenario: GET - Verify Super admin is able to fetch additional roles for invalid Authentication
    * def partyTypeId = validpartyTypeId
    * def roleId = validroleId
    * def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
    * header Authorization = invalidAuthToken
    Given path '/' + partyTypeId + '/' + roleId
    When method delete
		Then status 401
		And karate.log('Status : 401')
		And karate.log(' Records found : ', response)	
		And match response.errors[0].errorCode contains 'UNAUTHORIZED'	
		And match response.errors[0].message contains 'Token Invalid! Authentication Required'			
		
		
		
		
		
			