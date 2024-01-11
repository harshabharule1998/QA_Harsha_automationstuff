Feature: Category Master history feature for Super Admin

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	  * configure readTimeout = 40000

	@Regression
	# REV2-10741
	Scenario: GET - Validate Super Admin can fetch history for category after create
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
		* def catUrl = result.requestPayload.categoryRequest.categoryUrl
						
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
		
		# filter history response to get objects by categoryUrl   
    * def filt = function(x){ return x.fieldName == "categoryUrl"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue contains catUrl
		
		* karate.log('Test Completed !')


	@Regression
	@performanceData
	# REV2-10742
	Scenario: GET - Validate Super Admin can fetch history for category after update
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		* def categoryId = baseCategoryId	

		
		# Update Category
		
		* def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
			    "value": "updatedName"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": false,
			    "value": "6370952"
			  },
			  "categoryUrl": "fnp.ae/geo-tag/pt-tag",
			  "comment": "category updated",
			  "fromDate": "2022-03-14T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-13T16:00:00"
			}
      """
      
      
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/galleria/v1/categories/' + baseCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * match response.message == "Category updated successfully"
				
		# fetch category history
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
    And param size = 40
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
		
		# filter history response to get objects by categoryType   
    * def filt = function(x){ return x.fieldName == "categoryType"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[*].oldValue == ["TAX_CATEGORY"]
		And match res[*].newValue == ["GOOGLE_BASE_CATEGORY"]
		
		
		# filter history response to get objects by fromDate   
    * def filt = function(x){ return x.fieldName == "fromDate"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "2022-03-13T16:00:00"
		And match res[0].newValue == "2022-03-14T16:00:00"
		
		* karate.log('Test Completed !')
	
		
	@Regression
	# REV2-10747
	Scenario: GET - Validate pagination implemented to fetch category history for Super Admin 
		
		Given path '/galleria/v1/categories/history'
		And param page = 0
    And param size = 10
    And param sortParam = 'fieldName:asc'
    And param categoryId = '6375163'
    
		When method get
		Then status 200
		And karate.log('Status : 200')	
		And match response.currentPage == 0
		And assert response.totalPages >= 0
		* karate.log('Test Completed !')
	
	@Regression
	# REV2-10748
	Scenario: GET - Validate Super Admin able to sort category history for valid categoryId
		
		* def ArrayList = Java.type('java.util.ArrayList')
		* def Collections = Java.type('java.util.Collections')
		
		* def fieldNameList = new ArrayList()
		* def fieldNameSortedList = new ArrayList()
		
		Given path '/galleria/v1/categories/history'
		And param page = 0
    And param size = 10
    And param sortParam = 'fieldName:asc'
    And param categoryId = '6375163'
    
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
		
	
	# REV2-10749
	Scenario: GET - Validate Super Admin get error message when fetch history with unsupported method
		
		* def requestPayload =
      """
      {
        "categoryName": "updated_name",
        "categoryType": "6370946",
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
    
		* karate.log('Fetching history with unsupported method')
		
		And request requestPayload
		When method post
		Then status 405
		And karate.log('Status : 405')
		Then match response.errors[0].message contains "Unsupported request Method"
		* karate.log('Test Completed !')
		

	# REV2-10750
	Scenario: GET - Validate Super Admin get error message when fetch history with invalid categoryId
		
		Given path '/galleria/v1/categories/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param categoryId = "abc-123-yrt"
    
		* karate.log('Fetching history with invalid categoryId')
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then match response.errors[0].message == "Invalid category id"
		* karate.log('Test Completed !')
