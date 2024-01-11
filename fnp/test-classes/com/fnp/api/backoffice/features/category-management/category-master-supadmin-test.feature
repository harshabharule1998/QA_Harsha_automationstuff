Feature: Create category, search, edit and delete it.

	Background: 
		Given url backOfficeAPIBaseUrl
		And path '/galleria/v1'
		And header Accept = 'application/json'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
		* configure readTimeout = 50000
		* def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def domaintagName = 'fnp.com'
    * def prodtagName = 'tagName: test'+num+'-tag-product'
    * def categoryName = 'testCategory'+num
    * def domainTagId = 'fnp.com'
    * def derivedDomainTagId = 'fnp.sg'
    * def geoTagId = 'india'
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
    
		* def randomNum = 
			"""
			function() { 
				return Math.floor(Math.random() * 99) 
			}
			"""
			

 	@Regression
	Scenario: GET - Validate user can fetch all categories
		
		Given path '/categories'
		And param page = 0
		And param simpleSearchValue = "testCategory"
		And param size = 10
		And param sortParam = "categoryName:asc"
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Total Records found : ', response.total)
		And assert response.total > 1
		And karate.log('Test Completed !')
	
	 
	@Regression
	Scenario: GET - Validate user can fetch specific category
	
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
    Given path '/categories/' + categoryId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category search for Id : ', categoryId)
		And karate.log('Category found for Id : ', response.id)
		And match response.id == categoryId
		And karate.log('Test Completed !')


	@Regression
  #REV2-4161
	Scenario: PATCH - Validate user can update Derived URL Category with Valid data
		
		* def result = call read('./category-master-supadmin-test.feature@createDerivedURLCategory')
		* def derivedCategoryId = result.derivedCategoryId
		* def categoryId = derivedCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
			    "value": "testDerivedUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": false,
          "value": "6370946"

			  },
			  "categoryUrl": "tagautotqvtooqt.com/tag-auto-1103334/tag-auto-1103397",
			  "comment": "Updated derived category",
			  "fromDate": "2022-04-13T16:00:00",
			  "isEnabled": false,
			  "propagationChildCategories": [],
			  "thruDate": "2022-10-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + derivedCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated')
    
    # Verify updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')    
  

  @Regression
  #REV2-4162
	Scenario: PATCH - Validate user can update Derived Non URL Category with Valid data
	
	 	* def result = call read('./category-master-supadmin-test.feature@createDerivedNonURLCategory')
		* def derivedCategoryId = result.derivedCategoryId
		* def categoryId = derivedCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
			    "value": "testDerivedNonUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": false,
          "value": "6370946"

			  },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated derived category",
			  "fromDate": "2022-04-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-10-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + derivedCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated') 
    
    # Verify updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')   
  
  
  #REV2-4163
	Scenario: PATCH - Validate user can try update with Duplicate data
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": true,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": true,
          "value": "6370946"

			  },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated base category",
			  "fromDate": "2022-03-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + baseCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "update"
    And karate.log('Category updated')   

 
  #REV2-4163
	Scenario: PATCH - Validate user can try update with blank value and invalid data
   
   	* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": true,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": true,
          "value": "6370946"

			  },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated base category",
			  "fromDate": "2022-03-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-12T16:00:00"
			}
      """
      
    * eval requestPayload.categoryName.value = '  '
    * eval requestPayload.categoryType.value = '  '
    * eval requestPayload.categoryUrl = '  ' 
    * eval requestPayload.comment = '  '
    * eval requestPayload.isEnabled = '  '
    * eval requestPayload.fromDate = '  '
    * eval requestPayload.thruDate = '  '
    
    * karate.log(requestPayload)
    Given path '/categories/' + baseCategoryId
    And request requestPayload
    When method patch
    Then status 400
    And karate.log('Status : 400')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Invalid date format"
   
 @Regression  
  #REV2-4158
  Scenario: PATCH -Validate User can Update Base URL Category with Valid data - and inheritValueFromBase flag = true
  
  * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		* def categoryId = baseCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": true,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": true,
			    "value": "6370946"

			  },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated base category",
			  "fromDate": "2022-03-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + baseCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "update"
    And karate.log('Category updated') 
    
    # Verify updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !') 
   
	
  #REV2-4159
	Scenario: PATCH - Validate user can update inheritValueFromBase flag equal true
	  
	  * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": true,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": true,
          "value": "6370946"
         },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated base category",
			  "fromDate": "2022-03-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + baseCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "update"
    And karate.log('Category updated')    
  

  #REV2-4160
	Scenario: PATCH - Validate user can update inheritValueFromBase flag equal false
	  * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def baseCategoryId = result.responseData.id
		* def categoryId = baseCategoryId
		
	  * def requestPayload =
      """
      {
			  "categoryName": {
			    "inheritedValueFromBase": false,
			    "value": "testUrlCategoryUpdated"
			  },
			  "categoryType": {
			    "inheritedValueFromBase": true,
          "value": "6370946"

			  },
			  "categoryUrl": "tagautobnntking.com/tag-auto-10207/tag-auto-10282",
			  "comment": "Updated base category",
			  "fromDate": "2022-03-13T16:00:00",
			  "isEnabled": true,
			  "propagationChildCategories": [],
			  "thruDate": "2022-11-12T16:00:00"
			}
      """
    
    * eval requestPayload.categoryUrl = result.requestPayload.categoryRequest.categoryUrl
    * eval requestPayload.categoryName.value = result.requestPayload.categoryRequest.categoryName
    
    * karate.log(requestPayload)
    Given path '/categories/' + baseCategoryId
    And request requestPayload
    When method patch
    Then status 202
    And karate.log('Status : 202')
    * def responseData = response
    And karate.log('Response is:', response)
    And match response.message contains "Category updated successfully"
    And karate.log('Category updated')  
    
    #Verify updated category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')  
   
   @Regression 
	 #REV2-4165
	 Scenario: DELETE - Validate user can delete valid category id
	  
	  * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
		Given path '/categories/' + categoryId  
	 	When method delete
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Category deleted for Id : ', categoryId)
		And match response.message == 'Category deleted successfully'
		And karate.log('category deleted !')
		
		 # Verify Deleted category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 400
		And karate.log('Status : 400')
	  And karate.log('Response is:', response)
    And match response.errors[0].message contains 'category'
    And karate.log('Test Completed !')
		
   
   #REV2-4166
	 Scenario: DELETE - Validate user can delete invalid category id
	  Given path '/categories/@@@33333'
	 	When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid category id'
		And karate.log('Test Completed !')
    
    
    #REV2-4132
		Scenario: GET - Validate for superadmin by using blank categoryID
		Given path '/categories/    '
		When method get
		Then status 400
		And karate.log('Status : 400')
	  And karate.log('Response is:', response)
	  And match response.errors[0].message == 'must not be blank'
	  And karate.log('Test Completed !')
    
   
   #REV2-4131
   Scenario: GET - Validate for superadmin by using invalid categoryID
		Given path '/categories/@@@@@'
		When method get
		Then status 400
		And karate.log('Status : 400')
	  And karate.log('Response is:', response)
	  And match response.errors[0].message == 'Invalid category id'
	  And karate.log('Test Completed !')
  
  
 	 @Regression
   #REV2-4133
   Scenario: POST- Validate request to create Base URL Category for superAdmin
    
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
    And match result.responseData.id == "#notnull"
    * def categoryId = result.responseData.id
    And karate.log('Response is:', result.responseData)
    And karate.log('Test created !')
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
 
   
   @Regression
   #REV2-4134
   Scenario: POST- Validate request to create Base NON-URL Category for superAdmin
    
    * def result = call read('./category-master-supadmin-test.feature@createBaseNonURLCategory')
    And match result.responseData.id == "#notnull"
    And karate.log('Response is:', result.responseData)
    * def categoryId = result.responseData.id
    And karate.log('Test created !')
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
 
  
   @Regression	
   @createDerivedURLCategory
   #REV2-4135
   Scenario: POST- Validate request to create Derived URL Category for superAdmin
    
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And karate.log('Base Category Response is:', response)
    
    * def baseCategoryId = response.id
    
    
    * eval requestPayload.categoryRequest.baseCategory = baseCategoryId
    * eval requestPayload.categoryRequest.categoryName = categoryName + "der"
    * eval requestPayload.categoryRequest.domain = derivedDomainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryUrl = derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    * header Authorization = authToken
    Given path '/galleria/v1/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.baseCategory == baseCategoryId
    And karate.log('Derived Category Response is:', response)
    * def derivedCategoryId = response.id
   # * def categoryId = response.id
    
    And karate.log('Test completed !')
    

   @Regression
   @performanceData
   @createDerivedNonURLCategory
   #REV2-4136
   Scenario: POST- Validate request to create Derived NON-URL Category for superAdmin
   

		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
		
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And karate.log('Base Category Response is:', response)
    
    * def baseCategoryId = response.id
    * def categoryId = baseCategoryId
     
    * eval requestPayload.categoryRequest.baseCategory = baseCategoryId
    * eval requestPayload.categoryRequest.categoryName = categoryName + "der"
    * eval requestPayload.categoryRequest.domain = derivedDomainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.categoryUrl = derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + derivedDomainTagId + '/' + geoTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    * header Authorization = authToken
    Given path '/galleria/v1/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    And match response.baseCategory == baseCategoryId
    And karate.log('Derived Category Response is:', response)
    * def derivedCategoryId = response.id
    
    And karate.log('Test Completed !')
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
    
   #REV2-4139
   Scenario: POST- Validate request to create Category for blank values in parameters
     
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/category.json')
   
    * eval requestPayload.categoryRequest.baseCategory = ""
    * eval requestPayload.categoryRequest.categoryName = ""
    * eval requestPayload.categoryRequest.categoryClassification = ""
    * eval requestPayload.categoryRequest.categoryType = ""
    * eval requestPayload.categoryRequest.categoryUrl = ""
    #* eval requestPayload.categoryRequest.fromDate = ""
    #* eval requestPayload.categoryRequest.thruDate = ""
    * eval requestPayload.categoryRequest.domain = ""
    * eval requestPayload.categoryRequest.geography = ""
    * eval requestPayload.categoryRequest.party = ""
    * eval requestPayload.categoryRequest.productType = ""
    * eval requestPayload.categoryRequest.occasion = ""
    * eval requestPayload.categoryRequest.city = ""
    * eval requestPayload.categoryRequest.recipient = ""
    
    * karate.log(requestPayload)
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Category name should not be empty"
    And match response.errors[*].message contains "Geography should not be empty"
    And match response.errors[*].message contains "Category classification should not be empty"
    And match response.errors[*].message contains "Category type should not be empty"
    And karate.log('Test Completed !') 
    
    
   #REV2-4140
   Scenario: POST- Validate request to create Category for Duplicate data 
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
   
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    
    #Duplicate data category
    * header Authorization = authToken
    Given path '/galleria/v1/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Category name and domain combination already exists"
    And karate.log('Test Completed !')
   
    
   #REV2-4141
   Scenario: POST- Validate request to create Category for Invalid baseCategoryId
    
    * def invalidBaseCategoryId = "121"
   
    * eval requestPayload.categoryRequest.baseCategory = invalidBaseCategoryId
    * eval requestPayload.categoryRequest.domain = "fnp.com"
    * eval requestPayload.categoryRequest.productType = "tag-auto-1234"
    * eval requestPayload.categoryRequest.categoryClassification = 'URL' 
    * eval requestPayload.categoryRequest.categoryName = "testCategory123"
    * eval requestPayload.categoryRequest.categoryUrl = "fnp.ae/india/tag-auto-1234"
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid base category id"
    And karate.log('Response is:', response)
   
  
   @regression
   #REV2-4142
   Scenario: POST- Validate request to create Category for Invalid categoryClassification
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "@@@"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/'  + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category classification"
    And karate.log('Response is:', response)
   
 
   #REV2-4143
   Scenario: POST- Validate request to create Category for Invalid categoryName
		
		* def domainTagId = 'fnp.com'
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = num
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    * def categoryId = response.id
    And karate.log('Response is:', response)
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
    
    
   #REV2-4144
   Scenario: POST- Validate request to create Category for Invalid categoryType
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.categoryType = 123
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * karate.log(requestPayload)
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category type"
    And karate.log('Response is:', response)
    
   
   #REV2-4145
   Scenario: POST- Validate request to create Category for Invalid categoryUrl
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = "@@" + domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid category url"
    And karate.log('Response is:', response)
   
  
   #REV2-4146
   Scenario: POST- Validate request to create Category for Invalid city
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.city = "@@@@@@@@@@@"
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid taxonomy attributes"
    And karate.log('Response is:', response)
  

   @regression
   #REV2-4147
   Scenario: POST- Validate request to create Category for Invalid domain
   	
		#Create geoTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'G',token: "#(authToken)"}
		* def geoTagId = result.requestPayload.tagName
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = "@@@@@@@@@@@"
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = "@@@@@@@@@@@" + '/' + geoTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + "@@@@@@@@@@@" + '/' + geoTagId + '/' + productTagId
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid taxonomy attributes"
    And karate.log('Response is:', response)
  
    
   #REV2-4148
   Scenario: POST- Validate request to create Category for Invalid geography
    
    #Create domainTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'D',token: "#(authToken)"}
		* def domainTagId = result.requestPayload.tagName
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = "@@@@@@@@@"
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + "@@@@@@@@@" + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + "@@@@@@@@@" + '/' + productTagId
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid taxonomy attributes"
    And karate.log('Response is:', response)
   
    
   #REV2-4149
   Scenario: POST- Validate request to create Category for Invalid occasion
   
    #Create domainTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'D',token: "#(authToken)"}
		* def domainTagId = result.requestPayload.tagName
		
		#Create geoTag
	  * def result = call read('../../common/create-tag.feature') {tagType: 'G',token: "#(authToken)"}
		* def geoTagId = result.requestPayload.tagName
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + geoTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + geoTagId + '/' + productTagId
    * eval requestPayload.categoryRequest.occasion = '@@@@@@@'
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid taxonomy attributes"
    And karate.log('Response is:', response)
   
   
   #REV2-4150
   Scenario: POST- Validate request to create Category for Invalid party
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * eval requestPayload.categoryRequest.party = 1211
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Category created')
    * def categoryId = response.id
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
   
    
   #REV2-4151  
   Scenario: POST- Validate request to create Category for Invalid productType
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = "@@@@@@"
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + "@@@@@@"
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + "@@@@@@"
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid taxonomy attributes"
    And karate.log('Response is:', response)
   
  
   #REV2-4152  
   Scenario: POST- Validate request to create Category for Invalid fromDate
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * eval requestPayload.categoryRequest.fromDate = 'xxxx-16-13'
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid date format"
    And karate.log('Response is:', response)
   
   
   #REV2-4153
   Scenario: POST- Validate request to create Category for Invalid thruDate
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * eval requestPayload.categoryRequest.thruDate = '2022-03-13'
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Invalid date format"
    And karate.log('Response is:', response)
    
 
   #REV2-4155
   Scenario: POST- Validate request to create Category for FromDate same as ToDate
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
		
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * eval requestPayload.categoryRequest.thruDate = '2022-03-13T16:00:00'
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    * def categoryId = response.id
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
      
   
   #REV2-4156
   Scenario: POST- Validate request to create Category for FromDate starting after 2 years and ToDate ending after 10 years
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    * eval requestPayload.categoryRequest.fromDate = '2023-07-13T16:00:00'
    * eval requestPayload.categoryRequest.thruDate = '2032-03-13T16:00:00'
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def categoryId = response.id
    And karate.log('Response is:', response)
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
    
   
   #REV2-4157
   Scenario: POST- Validate request to create Category for inserting Duplicate values with Spaces
   
    * def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
    * def requestPayload = result.requestPayload
    
    #Duplicate data category with spaces
    * eval requestPayload.categoryRequest.categoryName = " " + requestPayload.categoryRequest.categoryName + " "
    * eval requestPayload.categoryRequest.domain = " " +  requestPayload.categoryRequest.domain + " "
    * eval requestPayload.categoryRequest.productType = " " +  requestPayload.categoryRequest.productType + " "
    * eval requestPayload.categoryRequest.geography = " " +  requestPayload.categoryRequest.geography + " "
    * eval requestPayload.categoryRequest.categoryClassification = " " +  "Url" + " "
    * eval requestPayload.categoryRequest.categoryUrl = " " +  requestPayload.categoryRequest.categoryUrl + " "
    * eval requestPayload.categorySeoRequest.canonical.url = " " +  requestPayload.categorySeoRequest.canonical.url + " "
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Invalid taxonomy attributes"
    And karate.log('Test Completed !')
  
  @Regression 
  @performanceData
	@createBaseURLCategory
	Scenario: POST - Validate user can create new category with name, type and url parameters
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryClassification = "Url"
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def responseData = response
    * def categoryId = response.id
    And karate.log('Response is:', responseData)
    And karate.log('Category created')
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')
  
	@Regression
	@createBaseNonURLCategory
	Scenario: POST - Validate user can create new category with name, type and url parameters
		
		#Create productTag
	  * def result = call read('../../common/create-tag.feature')  {tagType: 'PT',token: "#(authToken)"}
		* def productTagId = result.requestPayload.tagName
    
    * eval requestPayload.categoryRequest.categoryName = categoryName
    * eval requestPayload.categoryRequest.domain = domainTagId
    * eval requestPayload.categoryRequest.productType = productTagId
    * eval requestPayload.categoryRequest.geography = geoTagId
    * eval requestPayload.categoryRequest.categoryUrl = domainTagId + '/' + productTagId
    
    * eval requestPayload.categorySeoRequest.canonical.url = "https://www." + domainTagId + '/' + productTagId
    
    * karate.log(requestPayload)
    
    Given path '/categories'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def responseData = response
    * def categoryId = response.id
    And karate.log('Response is:', responseData)
    And karate.log('Category created')
    
    # Verify Created category

		* header Authorization = authToken
		
    Given path '/galleria/v1/categories/' + categoryId

		When method get
		Then status 200
		And karate.log('Status : 200')
	  And karate.log('Response is:', response)
    And match response.id == categoryId
    And karate.log('Test Completed !')