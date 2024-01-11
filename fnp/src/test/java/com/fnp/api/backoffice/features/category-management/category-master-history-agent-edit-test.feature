Feature: Category Master history feature for Category Agent with Edit permission

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
    * configure readTimeout = 40000
	
		
	@Regression
	# REV2-10745
	Scenario: GET - Validate Category Agent with Edit permission can fetch history for category after create
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		* def catUrl = result.requestPayload.categoryRequest.categoryUrl
						
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
		
		# filter history response to get objects by categoryUrl   
    * def filt = function(x){ return x.fieldName == "categoryUrl"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue contains catUrl
		
		* karate.log('Test Completed !')
	

	@Regression
	# REV2-10746
	Scenario: GET - Validate Category Agent with Edit permission can fetch history for category after update
		
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
    
		And match res[0].oldValue == "TAX_CATEGORY"
		And match res[*].newValue == ["GOOGLE_BASE_CATEGORY"]
		
		
		# filter history response to get objects by fromDate   
    * def filt = function(x){ return x.fieldName == "fromDate"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "2022-03-13T16:00:00"
		And match res[0].newValue == "2022-03-14T16:00:00"
			
		* karate.log('Test Completed !')
		
