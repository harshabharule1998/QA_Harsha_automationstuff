Feature: Webtools SQL Executor CRUD feature

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And header Accept = 'application/json'
    And path '/cockpit/v1/entitygroups/entities'
    * def loginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * def categoryManagerLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def categoryManagerAuthToken = categoryManagerLoginResult.accessToken
		
		* def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(9)
    
 
	#defect-REV2-7206
	#REV2-5508	
	Scenario: POST - Validate for role other than Entity Admin cannot SELECT entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
       
		* header Authorization = categoryManagerAuthToken
		Given path '/query'
		* param entityGroupName = 'auth'
		* param entityName = 'party'
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')


	#REV2-5509	
	Scenario: POST - Validate message for Entity Admin to SELECT entity data using webtools sql executor with invalid query
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
    
    * eval requestPayload.rawQuery = "Select * from party_activity where id=1"
    * eval requestPayload.queryType = "RAW_QUERY"
       
		* header Authorization = authToken
		Given path '/query'
		* param entityGroupName = 'simsim'
		* param entityName = 'party_activity'
		
		
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
		
		
  
	#REV2-5510	
	Scenario: POST - Validate message for Entity Admin to SELECT entity data using webtools sql executor with invalid table name
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
       
		* header Authorization = authToken
		Given path '/query'
		* param entityGroupName = 'auth'
		* param entityName = 'party_activities'
		And request requestPayload
		When method post
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')

  @Regression
	# REV2-5512	
	Scenario: POST - Validate Entity Admin can SELECT all entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
       
		* header Authorization = authToken
		Given path '/query'
		* param entityGroupName = 'simsim'
		* param entityName = 'party_credential'
		And request requestPayload
		When method post
		Then status 200
		And karate.log('Status : 200')
		And assert response.total >= 0
		And karate.log('Test Completed !')

 @Regression
	#REV2-5513	
	Scenario: POST - Validate message for Entity Admin to INSERT entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[0]
    
    * eval requestPayload.rawQuery = "INSERT INTO demo (name) VALUES ('JB-tester')"
    * eval requestPayload.queryType = "RAW_QUERY"
		* header Authorization = authToken
		Given path '/query'
		* param entityGroupName = 'Galleria'
		* param entityName = 'tag_relation_type'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')

	
	#REV2-5514	
	Scenario: POST - Validate message for Entity Admin to UPDATE entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[2]
    * eval requestPayload.rawQuery = "UPDATE demo SET name = testname, address = addresstest WHERE id = 4"
    * eval requestPayload.queryType = "RAW_QUERY"
       
		* header Authorization = authToken
	  Given path '/query'
		* param entityGroupName = 'Galleria'
		* param entityName = 'tag_relation_type'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')


  
	#REV2-5515	
	Scenario: POST - Validate message for Entity Admin to DELETE entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[3]
    * eval requestPayload.rawQuery = "DELETE from demo where id = 5"
    * eval requestPayload.queryType = "RAW_QUERY" 
       
		* header Authorization = authToken
		Given path '/query'
		* param entityGroupName = 'Galleria'
		* param entityName = 'tag_relation_type'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')
		


	#REV2-5517	
	Scenario: POST - Validate message for invalid auth token to SELECT entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
      
		* header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIxMCIsImF1ZCI6Imh0dHBzOlwvXC93d3cuZm5wLmNvbSIsInVhbCI6IlNHX0VOVElUWV9BRE0iLCJuYmYiOjE2MTM3MjE3MzcsInVuYW1lIjoiZW50aXR5YWRtaW5AY3li"
		Given path '/query'
		* param entityGroupName = 'auth'
		* param entityName = 'party_activity'
		And request requestPayload
		When method post
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')
		

	# REV2-5519	
	Scenario: PATCH - Validate message for unsupported endpoint method to SELECT entity data using webtools sql executor
		
		* def data = read('classpath:com/fnp/api/backoffice/data/webtools-build-query.json')
    * def requestPayload = data[1]
      
		* header Authorization = authToken
		Given path '/query'
		* param entityGroupName = 'auth'
		* param entityName = 'party_activity'
		And request requestPayload
		When method patch
		Then status 405
		And karate.log('Status : 405')
		And karate.log('Test Completed !')