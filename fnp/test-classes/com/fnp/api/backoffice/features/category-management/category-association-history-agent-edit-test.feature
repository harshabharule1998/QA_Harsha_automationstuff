Feature: Category Association history feature for Category Agent with Edit permission

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	  * configure readTimeout = 40000
		
	@Regression
	# REV2-10649
	Scenario: GET - Validate Category Agent with Edit permission can fetch association history for category after create
		
		* def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
						
		# fetch category history
		
		Given path '/galleria/v1/categories/history'
    And param size = 40
    And param sortParam = 'newValue:asc'
    And param categoryId = catId

    When method get
		Then status 200
		And karate.log('Status: 200')
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by associationType 
    * def filt = function(x){ return x.fieldName == "associationType.associationTypeName"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == "Footer Content"
		
		* karate.log('Test Completed !')
	
	
	@Regression
	# REV2-10650
	Scenario: GET - Validate Category Agent with Edit permission can fetch association history for category after update
		
		* def result = call read('./category-association-supadmin-test.feature@createAssociation')
    * def assocId = result.assocId
    * def catId = result.baseCategoryId
    
    * def requestPayload = result.requestPayload
    * eval requestPayload.sequence = "11"
    * eval requestPayload.comment = "Automation update association"
    * eval requestPayload.isEnabled = "true"
    * eval requestPayload.associationType = "228210"
    
    # update association
    Given path '/galleria/v1/categories/associations'
    And param categoryId = catId
    And param associationId = assocId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    And match response.message == "Category association updated successfully"
				
		# fetch category history
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
    And param size = 50
    And param categoryId = catId
    
    When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by sequence 
    * def filt = function(x){ return x.fieldName == "sequence"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "1"
		And match res[0].newValue == "11"

			
		* karate.log('Test Completed !')
