Feature: Category Attribute history feature for Super Admin

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
    * configure readTimeout = 40000
		
	@Regression
	@performanceData
	# REV2-10715
	Scenario: GET - Validate Super Admin can fetch attribute history for category after create
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
		
		# create category attribute
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "name1"
		* eval requestPayload.attributeValue = "value1"
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.id == "#notnull"
						
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
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by attributeName 
    * def filt = function(x){ return x.fieldName == "attributeName"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == "name1"
		
		# filter history response to get objects by attributeValue 
    * def filt = function(x){ return x.fieldName == "attributeValue"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == "value1"
		
		* karate.log('Test Completed !')
	

	@Regression
	# REV2-10716
	Scenario: GET - Validate Super Admin can fetch attribute history for category after update
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
		# create category attribute
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "name1"
		* eval requestPayload.attributeValue = "value1"
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.id == "#notnull"
		
		* def attributeId = response.id
								
		# Update Category attribute
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "name2"
		* eval requestPayload.attributeValue = "value2"
		* eval requestPayload.comment = "attribute update through automation"
		* eval requestPayload.isEnabled = true
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 202
		And karate.log('Status : 202')
		And match response.message == "Category attribute updated successfully"
				
		# fetch category history
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
    And param size = 50
    And param categoryId = categoryId
    
    When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by attributeName 
    * def filt = function(x){ return x.fieldName == "attributeName"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "name1"
		And match res[0].newValue == "name2"
		
		# filter history response to get objects by attributeValue 
    * def filt = function(x){ return x.fieldName == "attributeValue"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "value1"
		And match res[0].newValue == "value2"
			
		* karate.log('Test Completed !')
	
		
  @Regression
	# REV2-10717
	Scenario: GET - Validate Super Admin can fetch attribute history for category after delete
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
		# create category attribute
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "name1"
		* eval requestPayload.attributeValue = "value1"
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.id == "#notnull"
		
		* def attributeId = response.id
		
		# delete attribute
		* header Authorization = authToken
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message == "Category attribute deleted successfully"
		
		# fetch category attribute history for deleted attribute
		
		* def deletedAttributeCategoryId = categoryId
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
    And param size = 50
    And param categoryId = deletedAttributeCategoryId
    
    When method get
    Then status 200
		And karate.log('Status: 200')
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by attributeName 
    * def filt = function(x){ return x.fieldName == "attributeName"  && x.action == "DELETE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == null
		
		# filter history response to get objects by attributeValue 
    * def filt = function(x){ return x.fieldName == "attributeValue"  && x.action == "DELETE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == null
		
		* karate.log('Test Completed !')
		
