Feature: Webtools Config CRUD feature

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And header Accept = 'application/json'
    And path '/cockpit/v1'
    * def loginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * def categoryManagerLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def categoryManagerAuthToken = categoryManagerLoginResult.accessToken
    
   
    * def encode =
 		"""
 			function(jsonRequest) {
   			var Base64 = Java.type('java.util.Base64');
  			var encodedText = Base64.getEncoder().encodeToString(jsonRequest.getBytes());		
   			return encodedText;
   		}
 		"""


  @Regression
	# REV2-5477	
	Scenario: GET - Validate Entity Admin can fetch all entitygroup names
		
		* header Authorization = authToken
		Given path '/entitygroupnames'
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.data[*] == ["simsim","BeautyPlus","Galleria"]
		And karate.log('Test Completed !')
		

	# REV2-5478	& REV2-5484
	Scenario: GET - Validate error message for Entity Admin to fetch all entitygroup names with invalid url endpoint
		
		* header Authorization = authToken	
		Given path '/entitygroupnames12'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')
		
	@Regressions
	# defect id:REV2-5547
	# REV2-5479	& REV2-5511
	Scenario: GET - Validate pagination and sorting implemented for fetching webtools configuration with Entity Admin user 
		
		* def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def dbTypeList = new ArrayList()
		* def dbTypeSortedList = new ArrayList()
		
		* header Authorization = authToken
		Given path '/entitygroups'
		And param pageSize = 0
		And param pageNumber = 50
		And param sortField = 'dbType'
		And param sortDirection = 'ASC'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		* def records = response.total
    
    * karate.repeat(records.length, function(i){ dbTypeList.add(records[i].dbType) })
		* karate.log('dbTypeList list : ', dbTypeList)
		
		* karate.repeat(records.length, function(i){ dbTypeSortedList.add(records[i].dbType) })
		* karate.log('dbTypeSortedList list before sort : ', dbTypeSortedList)
		
		* Collections.sort(dbTypeSortedList, java.lang.String.CASE_INSENSITIVE_ORDER)
		* karate.log('dbTypeSortedList list after sort : ', dbTypeSortedList)
		
		And match dbTypeList == dbTypeSortedList

		And karate.log('Test Completed !')	

 
	# defect - REV2-7206
	# REV2-5480	
	Scenario: GET - Validate role other than Entity Admin cannot fetch all entitygroup names
		
    * header Authorization = categoryManagerAuthToken
    
		Given path '/entitygroupnames'
		When method get
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')


	
	#defect-REV2-7206
	# REV2-5481	
	Scenario: GET - Validate role other than Entity Admin cannot fetch all entitynames of all entitygroups
		
    * header Authorization = categoryManagerAuthToken
    
		Given path '/entitygroups'
		When method get
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')
		
	
  @Regression
	#defect-REV2-5547
	# REV2-5482	
	Scenario: GET - Validate pagination and sorting implemented for fetching all entitynames of all entitygroups with Entity Admin user 
		
		* def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def dbTypeList = new ArrayList()
		* def dbTypeSortedList = new ArrayList()
		
		* header Authorization = authToken
		Given path '/entitygroups'
		
		And param entityGroupName = 'simsim'
		And param entityName = 'party_credential'
		And param pageSize = 1
		And param pageNumber = 50
		And param sortParam = 'entityGroupName:asc'
		
		When method get
		Then status 200
		And karate.log('Status : 200')

		And karate.log('Test Completed !')

	
	#REV2-5485	
	Scenario: GET - Validate error message for fetching entity-group with blank path param values 
		
    * header Authorization = authToken
    
		Given path '/entitygroups'
		And param entityGroupName = ''
		And param entityName = ''
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		
 
	#REV2-5486	
	Scenario: GET - Validate error message for fetching entity-group with invalid path param values 
		
    * header Authorization = authToken
    
		Given path '/entitygroups'
		And param entityGroupName = 'abc-123'
		And param entityName = '456-auto'
		When method get
		Then status 400
		And karate.log('Status : 400')
		And karate.log('Test Completed !')
		

	
	#REV2-5487	
	Scenario: GET - Validate error message for entity-group with invalid URL  
		
    * header Authorization = authToken
    
		Given path '/config/entity-group'
		And param entityGroupName1 = 'tagmanagement-service'
		And param entity2Name = 'tag'
		When method get
		Then status 404
		And karate.log('Status : 404')
		And karate.log('Test Completed !')		

	
	# REV2-5488	
	Scenario: GET - Validate error for unsupported method request for webtools 
		
		* header Authorization = authToken
		Given path '/entitygroups'
		And request {}
		When method patch
		Then status 405
		And karate.log('Status : 405')
		And karate.log('Test Completed !')
		
	
	# REV2-5489	
	Scenario: GET - Validate error for invalid authorization token for webtools 
		
		* header Authorization = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		Given path '/entitygroups'
		When method get
		Then status 401
		And karate.log('Status : 401')
		And karate.log('Test Completed !')	
		
	 @Regression
	 Scenario: GET - Validate all Database Info.
			
			* header Authorization = authToken
			Given path '/entityGroup/dbInfo'
			When method get
			Then status 200
			And karate.log('Status : 200')
			And match response[0].entityGroup == 'simsim'
			And match response[0].dbType == 'mysql_database'
			And match response[0].dbName == 'simsim'
			And match response[1].entityGroup == 'BeautyPlus'
			And match response[1].dbType == 'mongo_database'
			And match response[1].dbName == 'beautyplus'
			And match response[2].entityGroup == 'Galleria'
			And match response[2].dbType == 'arango_database'
			And match response[2].dbName == 'data_migration_2'
			And karate.log('Test Completed !')
			
			
     @Regression
		 Scenario: GET - Validate select query for auth entity group with NotIn operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')   
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload[0]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'simsim'
    And param entityName = 'party_credential'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')

    And karate.log('Test Completed !')
    
		@Regression	
		Scenario: GET - Validate select query for auth entity group with In operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
   
    * eval requestPayload[0].conditions[0].operation = "In"    
    * karate.log(requestPayload)
    
    # convert json to string
    * string searchRequestString = requestPayload[0]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'simsim'
    And param entityName = 'party_credential'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')

    And karate.log('Test Completed !')				
    
@Regression
		Scenario: GET - Validate select query for auth entity group with EqualTo operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
   
    * eval requestPayload[0].conditions[0].operation = "EqualTo"    
    * karate.log(requestPayload[0])
    
    # convert json to string
    * string searchRequestString = requestPayload[0]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'simsim'
    And param entityName = 'party_credential'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')

    And karate.log('Test Completed !')	
    

@Regression
    Scenario: GET - Validate select query for Galleria entity group with NotIn operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json') 

    * karate.log(requestPayload[1])
    
    # convert json to string
    * string searchRequestString = requestPayload[1]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'Galleria'
    And param entityName = 'category'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')

    And karate.log('Test Completed !')
    
    
     
     @Regression		
		 Scenario: GET - Validate select query for Galleria entity group with In operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
   
    * eval requestPayload[1].conditions[0].operation = "In" 
	  * eval requestPayload[1].conditions[0].name == "category_name"
	  * eval requestPayload[1].conditions[0].values[0] == "gift"
	
    * karate.log(requestPayload[1])
    
    # convert json to string
    * string searchRequestString = requestPayload[1]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'Galleria'
    And param entityName = 'category'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')

    And karate.log('Test Completed !')	
    
  @Regression
    Scenario: GET - Validate select query for beauty plus entity group with NotIn operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')

    * karate.log(requestPayload[2])
    
    # convert json to string
    * string searchRequestString = requestPayload[2]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'BeautyPlus'
    And param entityName = 'url_redirect_tool'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')
    
    @Regression
    Scenario: GET - Validate select query for beauty plus entity group with In operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
    * eval requestPayload[2].conditions[0].operation = "In" 
    * karate.log(requestPayload[2])
    
    # convert json to string
    * string searchRequestString = requestPayload[2]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'BeautyPlus'
    And param entityName = 'url_redirect_tool'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')	
    
    
   @Regression
    Scenario: GET - Validate select query for beauty plus entity group with EqualTo operator.		
				
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
    * eval requestPayload[2].conditions[0].operation = "EqualTo" 
    * karate.log(requestPayload[2])
    
    # convert json to string
    * string searchRequestString = requestPayload[2]
    * def encodedText = encode(searchRequestString)
    
    And karate.log('encodedText : ' + encodedText)
    
    * header Authorization = authToken
    Given path '/entitygroups/entities/query/select'
	  And param entityGroupName = 'BeautyPlus'
    And param entityName = 'url_redirect_tool'
    And param page = 0
    And param size = 10
    And param sortParam = 'id:ASC'
    And param filter = encodedText       

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')	
    
    
 
    Scenario: GET - Validate select query for beauty plus entity group with blank value in operator.		
					
		  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
	    * eval requestPayload[2].conditions[0].operation = " " 
	    * eval requestPayload[2].conditions[0].name = " " 
	    * karate.log(requestPayload[2])
	    
	    # convert json to string
	    * string searchRequestString = requestPayload[2]
	    * def encodedText = encode(searchRequestString)
	    
	    And karate.log('encodedText : ' + encodedText)
	    
	    * header Authorization = authToken
	    Given path '/entitygroups/entities/query/select'
		  And param entityGroupName = 'BeautyPlus'
	    And param entityName = 'url_redirect_tool'
	    And param page = 0
	    And param size = 10
	    And param sortParam = 'id:ASC'
	    And param filter = encodedText       
	
	    When method get
	    Then status 200
	    And karate.log('Status : 200')
	    And karate.log('Test Completed !')	
	    
	     
    Scenario: GET - Validate select query for beauty plus entity group with Invalid value in operator.		
					
		  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/webtools-db.json')
	    * eval requestPayload[2].conditions[0].operation = "testqww" 
	    * eval requestPayload[2].conditions[0].name = "Xyz" 
	    * karate.log(requestPayload[2])
	    
	    # convert json to string
	    * string searchRequestString = requestPayload[2]
	    * def encodedText = encode(searchRequestString)
	    
	    And karate.log('encodedText : ' + encodedText)
	    
	    * header Authorization = authToken
	    Given path '/entitygroups/entities/query/select'
		  And param entityGroupName = 'BeautyPlus'
	    And param entityName = 'url_redirect_tools'
	    And param page = 0
	    And param size = 10
	    And param sortParam = 'id:ASC'
	    And param filter = encodedText       
	
	    When method get
	    Then status 404
	    And karate.log('Status : 404')
	    And karate.log('Test Completed !')	