Feature: Category Configuration history feature for Category Manager

	Background: 
		Given url 'https://api-test-r2.fnp.com'
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	  * configure readTimeout = 40000
	
  @Regression
	# REV2-10580
	Scenario: GET - Validate Category Manager can fetch configuration history for category after create
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
						
		# fetch category history
		
		Given path '/galleria/v1/categories/history'
    And param size = 40
    And param sortParam = 'newValue:asc'
    And param categoryId = categoryId
  
    When method get
		Then status 200
		And karate.log('Status: 200')
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by categoryConfig.productMapping.isManualOverride   
    * def filt = function(x){ return x.fieldName == "categoryConfig.productMapping.isManualOverride"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == "false"
				
		# filter history response to get objects by categoryConfig.configSearch.isSearchable   
    * def filt = function(x){ return x.fieldName == "categoryConfig.configSearch.isSearchable"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == "false"
		
		* karate.log('Test Completed !')
	

  @Regression 
	# REV2-10581
	Scenario: GET - Validate Category Manager can fetch configuration history for category after update
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
		
		# Update Category configuration
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-config.json')
      
    * karate.log(requestPayload)
    Given path '/galleria/v1/categories/configurations'
    And param categoryId = categoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * match response.message == "Category configuration updated successfully"
				
		# fetch category history
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
    And param size = 50
    And param sortParam = 'newValue:asc'
    And param categoryId = categoryId
    
    When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by productMapping.isManualOverride   
    * def filt = function(x){ return x.fieldName == "productMapping.isManualOverride"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "false"
		And match res[0].newValue == "true"
				
		# filter history response to get objects by configSearch.isSearchable   
    * def filt = function(x){ return x.fieldName == "configSearch.isSearchable"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "false"
		And match res[0].newValue == "true"
					
		* karate.log('Test Completed !')
