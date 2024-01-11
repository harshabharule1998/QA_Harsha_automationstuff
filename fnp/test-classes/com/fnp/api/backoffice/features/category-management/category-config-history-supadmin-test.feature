Feature: Category Configuration history feature for Super Admin

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	  * configure readTimeout = 40000
	
	@Regression
	@performanceData
	# REV2-10578
	Scenario: GET - Validate Super Admin can fetch configuration history for category after create
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
						
		# fetch category history
		
		Given path '/galleria/v1/categories/history'
    And param size = 40
    And param sortParam = 'newValue:asc'
    And param categoryId = categoryId
    #And param fromDate = '2021-03-26'
    #And param toDate = '2022-04-07'
    
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
	# REV2-10579
	Scenario: GET - Validate Super Admin can fetch configuration history for category after update
		
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
    #And param fromDate = '2021-03-26'
    #And param toDate = '2022-04-07'
    
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
	
	@Regression
	Scenario: GET - Validate pagination implemented to fetch category configuration history for Super Admin 
		
		Given path '/galleria/v1/categories/history'
		And param page = 0
    And param size = 10
    And param sortParam = 'fieldName:asc'
    And param categoryId = '7343439'
    
		When method get
		Then status 200
		And karate.log('Status : 200')	
		And assert response.currentPage == 0
		And assert response.totalPages >= 1
		* karate.log('Test Completed !')
	
	
	@Regression
	Scenario: GET - Validate Super Admin able to sort category configuration history for valid categoryId
		
		* def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def fieldNameList = new ArrayList()
		* def fieldNameSortedList = new ArrayList()
		
		Given path '/galleria/v1/categories/history'
		And param page = 1
    And param size = 10
    And param sortParam = 'fieldName:asc'
    And param categoryId = '7343439'
    
		When method get
		Then status 200
		And karate.log('Status : 200')
		
		* def records = response.data
    
    * karate.repeat(records.length, function(i){ fieldNameList.add(records[i].fieldName) })
		* karate.log('fieldNameList : ', fieldNameList)
		
		* karate.repeat(records.length, function(i){ fieldNameSortedList.add(records[i].fieldName) })
		* karate.log('fieldNameSortedList before sort : ', fieldNameSortedList)
		
		* Collections.sort(fieldNameSortedList)
		* karate.log('fieldNameSortedList after sort : ', fieldNameSortedList)
		
		And match fieldNameList == fieldNameSortedList
		* karate.log('Test Completed !')
		

	Scenario: GET - Validate Super Admin get error message when fetch configuration history with unsupported method
		
		* def requestPayload =
      """
      {
        "categoryName": "updated_name",
        "categoryType": "9270639",
        "categoryUrl": "domainTag/updated_name",
        "comment": "updated comment",
        "isEnabled": true,
        "fromDate": '2021-05-03',
        "thruDate": '2022-07-03'
      }
      """
      
		Given path '/galleria/v1/categories/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param categoryId = "6227114"
    
		* karate.log('Fetching configuration history with unsupported method')
		
		And request requestPayload
		When method post
		Then status 405
		And karate.log('Status : 405')
		Then match response.errors[0].message == "Unsupported request Method. Contact the site administrator"
		* karate.log('Test Completed !')
		
	
	Scenario: GET - Validate Super Admin get error message when fetch configuration history with invalid categoryId
		
		Given path '/galleria/v1/categories/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param categoryId = "abc-123-yrt"
    
		* karate.log('Fetching configuration history with invalid categoryId')
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then match response.errors[0].message == "Invalid category id"
		* karate.log('Test Completed !')
