Feature: Association Populate Category and Auto Sequence Category API 

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/columbus/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * configure readTimeout = 40000
    
    * def requestPayloadPopulate = read('classpath:com/fnp/api/backoffice/data/plp/populate-autoseq-category/product-addition.json')
    * def requestPayloadPopulateCreate = requestPayloadPopulate[0]
    * def requestPayloadPopulateUpdateInvalid = requestPayloadPopulate[1]
    
    * def requestPayloadPopulateProduct = read('classpath:com/fnp/api/backoffice/data/plp/populate-autoseq-category/product-update.json') 
    * def requestPayloadPopulateSingleUpdate = requestPayloadPopulateProduct[0]
    * def requestPayloadPopulateMultipleUpdate = requestPayloadPopulateProduct[1]
    * def requestPayloadPopulateMultipleUpdateSameSeq = requestPayloadPopulateProduct[2]
    
    * def requestPayloadPopulate = read('classpath:com/fnp/api/backoffice/data/plp/populate-autoseq-category/populateCategory.json') 
  
  	* def requestPayloadProductDelete = read('classpath:com/fnp/api/backoffice/data/plp/populate-autoseq-category/delete-product.json') 
  	* def requestPayloadSingleProductDelete = requestPayloadProductDelete[0]
   	* def requestPayloadMultipleProductDelete = requestPayloadProductDelete[1]
  	
  
	#REV2-24209/REV2-24207
	Scenario: GET - Verify API method for Auto sequence category with invalid Action and categoryId
  
  	* def categoryId = '^%%'	
		Given path '/request-status/' + categoryId
    When method get
    Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
	 Then response.status == "http.request.not.found"
    And karate.log('Test Completed !')
    
    
	#REV2-24208/REV2-24212
	Scenario: GET - Verify API method for populate category with blank Action and categoryId
  
  	* def categoryId = ' '	
		Given path '/request-status/' + categoryId
    When method get
    Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)
		Then response.status == "http.request.rejected"
    And karate.log('Test Completed !')
    
     
	#REV2-24213/REV2-24214
  Scenario: GET - Verify API Method for Getting previously submitted request for populate category for
   valid value
   
  	* def categoryId = '389554'	
		Given path '/request-status/' + categoryId
    When method get
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
  
  
 	#REV2-23181
 	Scenario: DELETE - Verify single Product Delete from the Category

  	* def id = '184375'	
		Given path '/products/remove/' + id
		When request requestPayloadSingleProductDelete
    And method put
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
    Then response.status == "1 Records deleted" 	
    And karate.log('Test Completed !') 

	
  #REV2-23136
  Scenario: POST - API PLP Product addition- POST Request- Verify API Method for adding Product with valid body
    
  	* def id = '184375'	
		Given path '/product/' + id
		And request requestPayloadPopulateCreate
    When method post
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
	  Then response.status == "1 Product(s) Successfully Added"
    And karate.log('Test Completed !')
    
     
 	#REV2-23182
 	Scenario: DELETE - Verify multiple Product Deletion from the Category

  	* def id = '184375'	
		Given path '/products/remove/' + id
		When request requestPayloadMultipleProductDelete
    And method put
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
    Then response.status == "2 Records deleted" 	
    And karate.log('Test Completed !') 
    
 
	Scenario: POST - API PLP Product addition- POST Request- Verify API Method for adding multiple Product with valid body
    
    * eval requestPayloadPopulate.fromDate = "2022-01-12T06:29:39"	 
    * eval requestPayloadPopulate.productId = "CAKE10035"	   
    * eval requestPayloadPopulate.sequence = 1	   
    * eval requestPayloadPopulate.thruDate = "2022-02-05T23:04:58"	 
    * eval requestPayloadPopulate.fromDate = "2022-01-12T06:29:39"	 
    * eval requestPayloadPopulate.productId = "CAKE10042"	   
    * eval requestPayloadPopulate.sequence = 2	   
    * eval requestPayloadPopulate.thruDate = "2022-02-05T23:04:58"	 
    
  	* def id = '184375'	
		Given path '/product/' + id
		And request requestPayloadPopulateCreate
    When method post
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
	  Then response.status == "2 Product(s) Successfully Added"
    And karate.log('Test Completed !')
    
    
  #REV2-23183
	Scenario: DELETE - Verify invalid Product Delete from the Category

  	* def id = '^%$'	
		Given path '/products/remove/' + id
		When request requestPayloadSingleProductDelete
    And method put
    Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)		
    Then response.status == "http.request.rejected" 	
    And karate.log('Test Completed !') 
    
     
  Scenario: DELETE - Verify single Product Delete from the Category using invalid endpoint

  	* def id = '184375'	
		Given path '/products/removes/' + id
		When request requestPayloadSingleProductDelete
    And method put
    Then status 404
  	And karate.log('Status : 404')
		And karate.log(' Records found : ', response)		
    And match response.errors[0].message == 'http.request.not.found'		
    And karate.log('Test Completed !')   
    
    
  #REV2-23184  
  Scenario: DELETE - Verify Product Delete from the Category from Unauthorized user-authentication failed
	
		* def authTokenInvalid = loginResult.accessToken + "abcdf"
    * header Authorization = authTokenInvalid
  	* def id = '184375'	
		Given path '/products/remove/' + id
		When request requestPayloadSingleProductDelete
    And method put
    Then status 403  
  	And karate.log('Status : 403')
		And karate.log(' Records found : ', response)		
    Then response.errors[0].message == "Authentication failed" 	
    And karate.log('Test Completed !') 
    
      
  #REV2-23138
  Scenario: POST - Verify API Method for adding a Product with unauthorized credential
  
    * def authTokenInvalid = loginResult.accessToken + "addd"
    * header Authorization = authTokenInvalid
  	* def id = '6263926'	
		Given path '/product/' + id
		And request requestPayloadPopulateCreate
    When method post
    Then status 403  
  	And karate.log('Status : 403')
  	And karate.log(' Records found : ', response)
    Then response.status == "Authentication failed"
    And karate.log('Test Completed !')
  
  
  #REV2-23139
  Scenario: POST -  Verify API Method for adding a Product with invalid CategoryId
  
  	* def id = 'abcd'	
		Given path '/product/' + id
		And request requestPayloadPopulateCreate
    When method post
    Then status 400  
  	And karate.log('Status : 400')
  	And karate.log(' Records found : ', response)
    Then response.status == "Data is not present with this categoryId"
    And karate.log('Test Completed !')
    
    
	#REV2-23140
  Scenario: POST - Verify API Method for adding a Product with invalid data type
  	
  	* def id = 'abc'	
		Given path '/product/' + id
		And request requestPayloadPopulateCreate
    When method post
    Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)		
 	  Then response.status == "Invalid input data"
    And karate.log('Test Completed !')

 
  #REV2-23156
  Scenario: PUT- Request- Verify API Method with invalid data type
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/plp/populate-category.json') 
  	Given path '/requests'
		And request requestPayload
    When method put
    Then status 400  
    * eval requestPayloadPopulate.categoryId = "10708517"	
	  * karate.log(requestPayloadPopulate)	
  	Given path '/requests' 	
  	When request requestPayloadPopulate
    And method put
	  Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)	
    Then response.status == "category does not exist for given category Id"	
    And karate.log('Test Completed !')
  
  
	#REV2-23157  
  Scenario: PUT- Request- Verify API Method with invalid end point
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/plp/populate-category.json') 
  	Given path '/request'
		And request requestPayloadPopulate
    When method put
    Then status 404  
  	And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
		Then response.status == "http.request.not.found"		
		And karate.log('Test Completed !')
	

	#REV2-23187/REV2-23191
  Scenario: PUT - PUT request for Editing a multiple Product of a Category with all valid values
    
    * def id = '184375'	
		Given path '/products/list/sequence/' + id
		And request requestPayloadPopulateMultipleUpdate  
    When method put
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
	  Then response.status == "2 products updated successfully"
    And karate.log('Test Completed !')
  
  
  #REV2-23188   
	Scenario: PUT - PUT request for Editing Product(s) of a Category with invalid value
   
    * def id = '389554'	
		Given path '/product/' + id
		And request requestPayloadPopulateUpdateInvalid
    When method post
    Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)		
    Then response.status == "Invalid input data"
    And karate.log('Test Completed !')
    
  
	#REV2-23186/REV2-23192
  Scenario: PUT - PUT request for Editing a single Product of a Category with all valid values
    
    * def id = '185198'	
		Given path '/products/list/sequence/' + id
		And request requestPayloadPopulateSingleUpdate
    When method put
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
	  Then response.status == "2 products updated successfully"
    And karate.log('Test Completed !')
 
 
	#REV2-23189   
  #updateFromAndThruDateForProductFilterConfig
  Scenario: PUT -PUT request for Editing Product(s) of a Category- by changing From and Through Date
  keeping the same sequence
  
    * def requestPayloadPopulateSameseq = read('classpath:com/fnp/api/backoffice/data/plp/populate-autoseq-category/sameSequence.json') 
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/plp/same-sequence.json') 
    * def id = '8212939'	
    * eval requestPayload.fromDate = "2022-02-13T08:28:34"
	  * eval requestPayload.thruDate = "2022-03-13T08:28:34"
    * def id = '185198'	
    * eval requestPayloadPopulate.fromDate = "2022-04-13T08:28:34"
	  * eval requestPayloadPopulate.thruDate = "2022-05-13T08:28:34"
		Given path '/products/' + id
		And request requestPayloadPopulateSameseq
    When method put
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
	  Then response.status == "2 products updated successfully"
		And karate.log('Test Completed !')
		
		
	#REV2-23193/REV2-23190   
	Scenario: PUT - PUT request for Editing multiple Products by Updating more than 2 products
	 with the same sequence as that of another existing product
   
    * def id = '184375'	
		Given path '/products/list/sequence/' + id
		And request requestPayloadPopulateMultipleUpdateSameSeq  
    When method put
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
	  Then response.status == "2 products updated successfully"
    And karate.log('Test Completed !')
    

 #REV2-23131/REV2-23133
	Scenario: GET - GET Request- Verify API Method for , getting list of existing product list
	 for a valid Category	
	  
	  Given path '/products/' 
		And param categoryId = "184375"
		And param hideSuppressdProducts = true
		And param page = 0
		And param size = 20
		And param sortParam = "sequence:asc"	
	  When method get
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
	 
	#REV2-23132
	Scenario: GET - Verify API Method for , getting list of existing product list for an
	  invalid Category  
	 
	 	Given path '/products/' 
		And param categoryId = "test@123"
		And param hideSuppressdProducts = true
		And param page = 0
		And param size = 20
		And param sortParam = "sequence:asc"	
	  When method get
    Then status 400  
  	And karate.log('Status : 400')
    And match response.errors[0].message == "categoryId must have alphanumeric value and valid special characters(_)" 	
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')


	#REV2-23134
	Scenario: GET -Verify API Method for , getting list of existing product list for
	  combination of valid and invalid parameters
	  
	 	Given path '/products/' 
		And param categoryId = "abc"
		And param hideSuppressdProducts = true
		And param page = 0
		And param size = 20
		And param sortParam = "sequence:asc"	
	  When method get
    Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)
    And karate.log('Test Completed !')
    
		
	#REV2-23135	 
	Scenario: GET - Verify API Method for adding a Product with invalid body request
	  
	 	Given path '/productt/' 
	  When method get
    Then status 404 
  	And karate.log('Status : 404')
		And karate.log(' Records found : ', response)
    And match response.errors[0].message == 'http.request.not.found'		
    And karate.log('Test Completed !')
    
    
	#REV2-23137 
	Scenario: POST - POST Request- Verify API Method for adding a Product with invalid body reques
	  
	 * def id = '184375'	
		Given path '/product/' + id
		And request requestPayloadPopulateUpdateInvalid
    When method post
    Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)		
    And match response.errors[0].message == 'Invalid date format'		
    And karate.log('Test Completed !')
    
  
  #REV2-23154 
  Scenario: PUT - Verify Populate Category API Method with unauthorized credential
  	
  	* def authTokenInvalid = loginResult.accessToken + "jdd"
    * header Authorization = authTokenInvalid
		Given path '/requests' 
		And request requestPayloadPopulateCreate
    When method put
    Then status 400  
  	And karate.log('Status : 400')
  	And karate.log(' Records found : ', response)
    Then response.status == 'Authentication failed'		
    And karate.log('Test Completed !')
     

	#REV2-23141/REV2-23151/REV2-23148
  Scenario: PUT - Verify API Method for , populate category -Associating products to category

    * karate.log(requestPayloadPopulate)	
    
    Given path '/requests/'	
  	When request requestPayloadPopulate
    And method put
	  Then status 200  
  	And karate.log('Status : 200')
		And karate.log(' Records found : ', response)		
    And response.status == "Populate Request Submitted Successfuly"  				
    And karate.log('Test Completed !')
   
   
	#REV2-23152/REV2-23166
  Scenario: PUT - Verify API Method for valid Shipping mode and if count not equal to 10

	  * eval requestPayloadPopulate.config.deliveryModes.digital = 3	
    * karate.log(requestPayloadPopulate)	
    
    Given path '/requests/'	
  	When request requestPayloadPopulate
    And method put
	  Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)		
    Then response.errors[0].message == "Populate Category Request Failed due to Bad data, Sum of all Delivery Modes should to be 10"	
    And karate.log('Test Completed !')
   
   
  #REV2-23153 
  Scenario: PUT - Verify API Method for , populate category -Associating products to category
  	
  	* eval requestPayloadPopulate.action = "abc"		
	  * karate.log(requestPayloadPopulate)	
  	Given path '/requests' 	
  	When request requestPayloadPopulate
    And method put
	  Then status 400  
  	And karate.log('Status : 400')
		And karate.log(' Records found : ', response)	
    And match response.errors[0].message == "Invalid action"	
    And karate.log('Test Completed !')
   
	
	#REV2-23169
	 Scenario: PUT - PUT Request- Verify Auto Sequence API Method with unauthorized credential
    
    * def authTokenInvalid = loginResult.accessToken + "jdd"
    * header Authorization = authTokenInvalid
    * def id = '184375'	
		Given path '/products/list/sequence/' + id
		And request requestPayloadPopulateMultipleUpdate  
    When method put
    Then status 403  
  	And karate.log('Status : 403')
		And karate.log(' Records found : ', response)		
	  Then response.status == "Authentication failed"
    And karate.log('Test Completed !')
    
    
	#REV2-23172
  Scenario: Verify API Method for invalid end point
  
 		* def id = '184375'	
		Given path '/productt/' + id
		And request requestPayloadPopulateCreate
    When method put
    Then status 404  
  	And karate.log('Status : 404')
		And karate.log(' Records found : ', response)		
    And match response.errors[0].message == "http.request.not.found"	
    And karate.log('Test Completed !')
 
 