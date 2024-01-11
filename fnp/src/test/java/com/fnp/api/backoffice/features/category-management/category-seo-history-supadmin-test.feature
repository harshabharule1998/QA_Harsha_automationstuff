Feature: Category SEO history feature for Super Admin

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	  * configure readTimeout = 40000
	
	@Regression
	# REV2-9842
	Scenario: PUT - Verify Category History for Category SEO Configuration after Update operation
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
		
		# create category SEO
		* def requestPayload =
      """
      {
	     "canonical": {
	     "type": "REFERENCE",
	     "url": ""
	      },
	     "relAltAssociations": []
       }
     """
	  * eval requestPayload.canonical.url = 'https://www.' + result.responseData.categoryUrl
		Given path '/galleria/v1/categories/seo'
	  And param categoryId = categoryId
	  And request requestPayload
   
		When method PUT
		Then status 202
		And karate.log('Status : 202')
		And match response.message == "Category SEO updated successfully"
						
		# fetch category seo history
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
		And param size = 50
    And param sortParam = 'fieldName:asc'
    And param categoryId = categoryId
    
    When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by canonical   
    * def filt = function(x){ return x.fieldName == "canonical" && x.action == "UPDATE" && x.section == "SEO_CONFIGURATION" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue contains "SELF"
		And match res[0].newValue contains "REFERENCE"
		
		* karate.log('Test Completed !')
	
	
	@Regression
	# REV2-9841
	Scenario: GET - Verify Category History for Category SEO Configuration after Add operation
		
		# Create Category
		
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id	
		
	  # fetch category seo history
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/history'
		And param size = 50
    And param sortParam = 'fieldName:asc'
    And param categoryId = categoryId
    
    When method get
		Then status 200
		And karate.log('Status: 200')
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by categorySeoConfiguration.canonical   
    * def filt = function(x){ return x.fieldName == "categorySeoConfiguration.canonical" && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue contains "SELF"
		
		* karate.log('Test Completed !')
		
		
	