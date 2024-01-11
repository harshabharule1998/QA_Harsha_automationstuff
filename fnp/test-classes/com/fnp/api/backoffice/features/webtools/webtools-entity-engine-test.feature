Feature: Webtools Entity Engine CRUD feature

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And header Accept = 'application/json'
    And path '/cockpit/v1'
    * def loginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * def categoryManagerLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def categoryManagerAuthToken = categoryManagerLoginResult.accessToken
		
		* def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(9)  


  @Regression
	#REV2-5490	
	Scenario: GET - Validate Entity Admin can fetch webtools entity engine meta-data
		

		* header Authorization = authToken
		Given path '/entitygroups/entities/meta-data'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.data[0].fieldName == "_id"
		And karate.log('Test Completed !')
		
	
	#defect-REV2-7206
	#REV2-5491	
	Scenario: GET - Validate for role other than Entity Admin cannot fetch webtools entity engine meta-data
		
		* header Authorization = categoryManagerAuthToken
		Given path '/entitygroups/entities/meta-data'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		
		When method get
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')

  
	#REV2-5492	
	Scenario: GET - Validate message for Entity Admin to fetch webtools entity engine meta-data with invalid data
		
		* header Authorization = authToken
		Given path '/entitygroups/entities/meta-data'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tools'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains 'Entity does not exist'
		And karate.log('Test Completed !')	
		
	

	#REV2-5493	
	Scenario: GET - Validate message for Entity Admin to fetch webtools entity engine meta-data with blank data
		

		* header Authorization = authToken
		Given path '/entitygroups/entities/meta-data'
		* param entityGroupName = ' '
		* param entityName = ' '
		
		When method get
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message contains "Config Id does not exist"
		And karate.log('Test Completed !')	

	@Regression
	#REV2-5494	
	Scenario: GET - Validate Entity Admin can fetch webtools entity engine all-entities
		
		* header Authorization = authToken
    Given path '/entitygroups'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And assert response.total > 1
		And karate.log('Test Completed !')
		
		
	#defect-REV2-7206	
	#REV2-5495	
	Scenario: GET - Validate for role other than Entity Admin cannot fetch webtools entity engine all-entities
		
		* header Authorization = categoryManagerAuthToken
	  Given path '/entitygroups'
		When method get
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')
		
	@Regression
	#REV2-5496	
	Scenario: DELETE - Validate Entity Admin can fetch webtools entity engine clear-entitylist-cache
		
		* header Authorization = authToken
		Given path 'entitygroups/cache'
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		
 
	#defect-REV2-7206		
	#REV2-5497	
	Scenario: DELETE - Validate for role other than Entity Admin cannot fetch webtools entity engine clear-entitylist-cache
		
		* header Authorization = categoryManagerAuthToken
		Given path 'entitygroups/cache'
		When method delete
		Then status 403
		And karate.log('Status : 403')
		And match response.errors[0].message == "Access Denied"
		And karate.log('Test Completed !')

	
	#defect-REV2-7206
	#REV2-5498 & REV2-5503
	Scenario: POST - Validate for role other than Entity Admin cannot INSERT entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
    * eval requestPayload.queryPart.parameters[0].value = num
    * eval requestPayload.queryPart.parameters[1].value = requestPayload.queryPart.parameters[1].value + num
    
		* header Authorization = categoryManagerAuthToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		And match response.errors[0].message == "Access Denied"
		And karate.log('Test Completed !')		

  @Regression
	@insertEntity
	#REV2-5499	
	Scenario: POST - Validate Entity Admin can INSERT entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
    * eval requestPayload.queryPart.parameters[0].value = num
    * eval requestPayload.queryPart.parameters[1].value = requestPayload.queryPart.parameters[1].value + num
    
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And assert response.total > 1
		
		* eval index = response.data.length - 1
		* def entities = response.data
		* def entityId = entities[index]._id.$oid
		
		And karate.log('entityId : ', entityId)
		And karate.log('Test Completed !')
		
  @Regression
	#REV2-5500	
	Scenario: POST - Validate Entity Admin can UPDATE entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[2]
        
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'simsim'
		* param entityName = 'party_credential'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And assert response.total >= 0
		And karate.log('Test Completed !')

  
	#REV2-5501	
	Scenario: POST - Validate Entity Admin cannot SELECT entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
       
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'simsim'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')
		
 
	#REV2-5502	
	Scenario: POST - Validate Entity Admin can DELETE entity data using webtools build query
		
		* def result = call read('./webtools-entity-engine-test.feature@insertEntity')
    * def entityId = result.entityId
    
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[3]
    * eval requestPayload.queryPart.condition.id = entityId
       
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'simsim'
		* param entityName = 'party_credential'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')	
		And karate.log('Test Completed !')


	#REV2-5504
	Scenario: POST - Validate message for Entity Admin to INSERT invalid entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
    * eval requestPayload.queryPart.parameters[0].value = num
    * eval requestPayload.queryPart.parameters[1].value = ""
    
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
    * param entityGroupName = 'auth'
		* param entityName = 'product'
		
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		And match response.errors[0].message == 'Config Id does not exist'
		And karate.log('Test Completed !')	
		
	
	#REV2-5505
	Scenario: POST - Validate message for Entity Admin to INSERT blank entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
    * eval requestPayload.queryPart.parameters[0].value = ""
    * eval requestPayload.queryPart.parameters[0].value = ""
    * eval requestPayload.queryPart.parameters[0].value = ""
   
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
    * param entityGroupName = 'simsim'
		* param entityName = 'party_credential'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')
		
  @Regression
	#EV2-5506
	Scenario: POST - Validate message for Entity Admin to INSERT duplicate entity data using webtools build query
		
		* def result = call read('./webtools-entity-engine-test.feature@insertEntity')
    * def entityId = result.entityId
    * def requestPayload = result.requestPayload
    
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')

  @Regression
	#REV2-5507
	Scenario: POST - Validate message for Entity Admin to INSERT duplicate entity data with spaces using webtools build query
		
		* def result = call read('./webtools-entity-engine-test.feature@insertEntity')
    * def entityId = result.entityId
    * def requestPayload = result.requestPayload
    
    * eval requestPayload.queryPart.parameters[0].value = " "
    * eval requestPayload.queryPart.parameters[1].value = requestPayload.queryPart.parameters[1].value + " "
    
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		

	#REV2-5518	
	Scenario: POST - Validate message for invalid auth token to INSERT entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
	
	  * eval requestPayload.queryPart.parameters[0].value = num
    * eval requestPayload.queryPart.parameters[1].value = requestPayload.queryPart.parameters[1].value + num
    
		* header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIxMCIsImF1ZCI6Imh0dHBzOlwvXC93d3cuZm5wLmNvbSIsInVhbCI6IlNHX0VOVElUWV9BRE0iLCJuYmYiOjE2MTM3MjE3MzcsInVuYW1lIjoiZW50aXR5YWRtaW5AY3li"
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		And request requestPayload
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
		
  
	#REV2-5520	
	Scenario: PATCH - Validate message for unsupported endpoint method to INSERT entity data using webtools build query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
	  * eval requestPayload.queryPart.parameters[0].value = num
    * eval requestPayload.queryPart.parameters[1].value = requestPayload.queryPart.parameters[1].value + num
    
		* header Authorization = authToken
		Given path '/entitygroups/entities/query'
		* param entityGroupName = 'BeautyPlus'
		* param entityName = 'url_redirect_tool'
		And request requestPayload
		When method patch
		Then status 405
		And karate.log('Status : 405')
		And karate.log('Test Completed !')
