Feature: Kitchen Crud publishers list scenarios with super admin user role 

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'kitchenAdmin'}
    * def authToken = loginResult.accessToken
    * def publisherId = 'P_01373'
    * header Authorization = authToken
    
  
  #REV2-22015
  Scenario: GET - Verify super admin user can get list of publisher with valid values.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-22016
  Scenario: GET - Verify super admin user can get list of publisher with valid value in sortparam.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%%3Desc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-22017
  Scenario: GET - Verify super admin user can get list of publisher with valid value asc in sortparam.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-22018
  Scenario: GET - Verify super admin user can get list of publisher with invalid value in sortparam.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aascc111@@%%$$'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    

  #REV2-22019
  Scenario: GET - Verify super admin user can get list of publisher with blank value in sortparam.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = ''
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-22020
  Scenario: GET - Verify super admin user can get list of publisher with all fields invalid
  
    Given path '/pawri/v1/publishers'
    And param page = 11222233
    And param simpleSearchValue = 'testing123'
    And param size = 33131444
    And param sortparam = 'lastUpdatedStamp11%3Adesc111'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  #REV2-22021
  Scenario: GET - Verify super admin user can get list of publisher with all fields blank
  
    Given path '/pawri/v1/publishers'
    And param page = ' ' 
    And param simpleSearchValue = ' '
    And param size = ' '
    And param sortparam = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
  
  #REV2-22022
  Scenario: GET - Verify super admin user can get list of publisher with valid value in page.
  
    Given path '/pawri/v1/publishers'
    And param page = 1
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    

  #REV2-22023
  Scenario: GET - Verify super admin user can get list of publisher with invalid value in page.
  
    Given path '/pawri/v1/publishers'
    And param page = 1345346666
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-22024
  Scenario: GET - Verify super admin user can get list of publisher with blank value in page.
  
    Given path '/pawri/v1/publishers'
    And param page = ' '
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
   
  #REV2-22025
  Scenario: GET - Verify super admin user can get list of publisher with special char value in page.
  
    Given path '/pawri/v1/publishers'
    And param page = '@#$%^^&**'
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forpage"
    And karate.log('Test Completed !')
    
  
  #REV2-22026
  Scenario: GET - Verify super admin user can get list of publisher with valid value in size.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 10
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-22027
  Scenario: GET - Verify super admin user can get list of publisher with invalid value in size.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 107867867767
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
  
  #REV2-22028
  Scenario: GET - Verify super admin user can get list of publisher with blank value in size.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = ' '
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
   
  #REV2-22029
  Scenario: GET - Verify super admin user can get list of publisher with string value in size.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = 'sdgjhggh'
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
  
  #REV2-22030
  Scenario: GET - Verify super admin user can get list of publisher with special char value in size.
  
    Given path '/pawri/v1/publishers'
    And param page = 0
    And param simpleSearchValue = 'testing'
    And param size = '@%23$!%23%^%26*()'
    And param sortparam = 'id%3Aasc'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "invalid.value.forsize"
    And karate.log('Test Completed !')
    
  
  #REV2-22328
	Scenario: POST - Validate Super Admin can create Publisher for valid fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publiherName = "wintervibes"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And karate.log('Test Completed !')
	
  	
	#REV2-22329
	Scenario: POST - Validate Super Admin cannot create Publisher for invalid fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = "wintervibes@12"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Publisher name is invalid"
		And karate.log('Test Completed !')
		
	
	#REV2-22330
	Scenario: POST - Validate Super Admin cannot create Publisher for blank fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = " "
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "kitchen.publisher.name.empty"
		And karate.log('Test Completed !')
		

	#REV2-22331
	Scenario: POST - Validate Super Admin cannot create Publisher without adding mandatory fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = " "
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "kitchen.publisher.name.empty"
		And karate.log('Test Completed !')
		
	
	#REV2-22332
	Scenario: POST - Validate Super Admin can create Publisher with adding mandatory fields
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = "wintervibsss"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And karate.log('Test Completed !')

	
	#REV2-22333
	Scenario: POST - Validate Super Admin can create Publisher with special char in publisher name field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = "wintervibess@$$"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Status : 400')
		And match response.errors[0].message == "Publisher name is invalid"
		And karate.log('Test Completed !')
		
			
	#REV2-22334
	Scenario: POST - Validate Super Admin can create Publisher with alphanumeric value in publisher name field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = "wintervibess@123"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Status : 400')
		And match response.errors[0].message == "Publisher name is invalid"
		And karate.log('Test Completed !')
		
	
	#REV2-22336
	Scenario: POST - Validate Super Admin can create Publisher with apostrophe s value in publisher name field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherName = "wintervibe's"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Status : 400')
		And match response.errors[0].message == "Publisher name is invalid"
		And karate.log('Test Completed !')
		

	#REV2-22338
	Scenario: POST - Validate Super Admin can create Publisher with invalid value in fieldStatus field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')
		* eval requestPayload.publisherConfigs[0].fieldStatus = "1234fff"
		* eval requestPayload.publisherName = "wintervibe's"

		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
	
	#REV2-22339
	Scenario: POST - Validate Super Admin can create Publisher with value TRUE in fieldStatus field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].fieldStatus = "TRUE"
		* eval requestPayload.publisherName = "wintervibe's"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
	
	#REV2-22340
	Scenario: POST - Validate Super Admin can create Publisher with value FALSE in fieldStatus field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].fieldStatus = "FALSE"
		* eval requestPayload.publisherName = "wintervibe's"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Invalid input data"
		And karate.log('Test Completed !')
	
	
	#REV2-22341
	Scenario: POST - Validate Super Admin can create Publisher with unique value in alias field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].fieldStatus = "TEST"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherName = "wintertests"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 201 
		And karate.log('Status : 201')
		And karate.log('Test Completed !')
		
	
	#REV2-22342
	Scenario: POST - Validate Super Admin can create Publisher with invalid value in alias field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "aaa"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherName = "wintertest"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Publisher name already exist"
		And karate.log('Test Completed !')
		

	#REV2-22343
	Scenario: POST - Validate Super Admin can create Publisher with invalid value in alias field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "TEST@"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherName = "wintertestones"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And karate.log('Test Completed !')
		
		
	#REV2-22347
	Scenario: POST - Validate Super Admin can create Publisher with blank value in product Attribute Field Id
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "TEST"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = ""
		* eval requestPayload.publisherName = "wintertestone"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "kitchen.product.Attribute.id.invalid"
		And karate.log('Test Completed !')
		
	
	#REV2-22348
	Scenario: POST - Validate Super Admin can create Publisher with invalid value in product Attribute Field Id
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "TEST"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_002"
		* eval requestPayload.publisherName = "wintertestone"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Publisher name already exist"
		And karate.log('Test Completed !')
		

	#REV2-22349
	Scenario: POST - Validate Super Admin can create Publisher with special char in product Attribute Field Id
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "TEST"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U002s2@"
		* eval requestPayload.publisherName = "wintertestone"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Publisher name already exist"
		And karate.log('Test Completed !')
		
	
	#REV2-22353
	Scenario: POST - Validate Super Admin can create Publisher with blank value in field status
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "TEST"
		* eval requestPayload.publisherConfigs[0].fieldStatus = ""
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00002"
		* eval requestPayload.publisherName = "wintertestone"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Invalid input data"
		And karate.log('Test Completed !')
		
	
	#REV2-22354
	Scenario: POST - Validate Super Admin can create Publisher with blank value in alias field
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = ""
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U002s2@"
		* eval requestPayload.publisherName = "wintertestone"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Publisher name already exist"
		And karate.log('Test Completed !')
		
	
	#REV2-22355
	Scenario: POST - Validate Super Admin can create Publisher with valid value in all fields as per database
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = "TEST"
		* eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00002"
		* eval requestPayload.publisherName = "wintertestthre"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 201	
		And karate.log('Status : 201')
		And karate.log('Test Completed !')
		

	#REV2-22356
	Scenario: POST - Validate Super Admin can create Publisher with blank value in fieldstatus and productfield  
			
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/create-publisher.json')	
		* eval requestPayload.publisherConfigs[0].alias = ""
		* eval requestPayload.publisherConfigs[0].fieldStatus = ""
		* eval requestPayload.publisherConfigs[0].productAttributeFieldId = ""
		* eval requestPayload.publisherName = "wintertesttwo"
		
		Given path '/kitchen/v1/publishers'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Response is : ', response)
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Invalid input data"
		And karate.log('Test Completed !')

	
	#REV2-22601
  Scenario: PUT - Verify Super admin user can edit Publisher with all valid data
  
  	* def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
      
    * karate.log(requestPayload)
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
  
  #REV2-22602
  Scenario: PUT - Verify Super admin user can edit publisher with invalid data
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = "U_1397"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_0137"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_000"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE12"
    * eval requestPayload.publisherConfigs[0].alias = "Test12"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
   
  #REV2-22603
  Scenario: PUT - Verify Super admin user can edit publisher with blank data
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = " "
    * eval requestPayload.publisherConfigs[0].publisherId = " "
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = " "
    * eval requestPayload.publisherConfigs[0].fieldStatus = " "
    * eval requestPayload.publisherConfigs[0].alias = " "
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
  
  #REV2-22604
  Scenario: PUT - Verify Super admin user can edit publisher without adding mandatory field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    * eval requestPayload.publisherName = " "
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.publisher.name.empty"
    And karate.log('Test Completed !')
    

  #REV2-22605
  Scenario: PUT - Verify Super admin user can edit publisher with adding valid data in non mandatory field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    * eval requestPayload.publisherName = "api testing new"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
   
  #REV2-22606
  Scenario: PUT - Verify Super admin user can edit publisher with special char in publisherId field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P@@&&%%"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
  
  #REV2-22607
  Scenario: PUT - Verify Super admin user can edit publisher with alphanumeric value in publisherId field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
 
  #REV2-22609
  Scenario: PUT - Verify Super admin user can edit publisher with apostrophe s value in publisher name field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    * eval requestPayload.publisherName = "api testing new's"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Publisher name is invalid"
    And karate.log('Test Completed !')
  
   
  #REV2-22611
  Scenario: PUT - Verify Super admin user can edit publisher with invalid value in fieldStatus field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "1234fff"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    * eval requestPayload.publisherName = "api testing news"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
      
    
  #REV2-22612
  Scenario: PUT - Verify Super admin user can edit publisher with value True in fieldStatus field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "TRUE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    * eval requestPayload.publisherName = "api testing news"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
    
  #REV2-22613
  Scenario: PUT - Verify Super admin user can edit publisher with invalid value in fieldStatus field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "prod##$%%^123"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
  
 
  #REV2-22614
  Scenario: PUT - Verify Super admin user can edit publisher with unique value in alias field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
  
  #REV2-22615
  Scenario: PUT - Verify Super admin user can edit publisher with invalid value in alias field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test_123"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')  
    
 
  #REV2-22616
  Scenario: PUT - Verify Super admin user can edit publisher with alphanumeric value in alias field 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "P_1a2bc"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
 	
  #REV2-22620
  Scenario: PUT - Verify Super admin user can edit publisher with blank value in productAttributeFieldId 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = ""
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.product.Attribute.id.invalid"
    And karate.log('Test Completed !')
  
  
  #REV2-22621
  Scenario: PUT - Verify Super admin user can edit publisher with invalid value in productAttributeFieldId 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U020"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And match response.errors[0].message contains "Product Attribute field not found for the given publisher Id"
    And karate.log('Test Completed !')
     
  
  #REV2-22622
  Scenario: PUT - Verify Super admin user can edit publisher with special char and alphanumeric value in productAttributeFieldId 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_01@#$%"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 404
    And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And match response.errors[0].message contains "Product Attribute field not found for the given publisher Id"
    And karate.log('Test Completed !')
      
  
  #REV2-22623
  Scenario: PUT - Verify Super admin user can edit publisher with blank value in productAttributeFieldId 
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = ""
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "kitchen.product.Attribute.id.invalid"
    And karate.log('Test Completed !')
    
  
  #REV2-22626
  Scenario: PUT - Verify Super admin user can edit publisher with blank value in fieldStatus
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = ""
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
    
    
  #REV2-22627
  Scenario: PUT - Verify Super admin user can edit publisher with blank value in Alias field
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = ""
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    

  #REV2-22628
  Scenario: PUT - Verify Super admin user can edit publisher with valid value as per database
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_01373"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_00003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "ACTIVE"
    * eval requestPayload.publisherConfigs[0].alias = "TEST"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Response is : ', response)
    And karate.log('Status : 202')
    And karate.log('Test Completed !')
    
  
  #REV2-22629
  Scenario: PUT - Verify Super admin user can edit publisher with any input data in all fields
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/kitchen/edit-publisher.json')  
    * eval requestPayload.publisherConfigs[0].id = "U_13970"
    * eval requestPayload.publisherConfigs[0].publisherId = "P_1a2bc"
    * eval requestPayload.publisherConfigs[0].productAttributeFieldId = "U_0003"
    * eval requestPayload.publisherConfigs[0].fieldStatus = "prod##$%%^123"
    * eval requestPayload.publisherConfigs[0].alias = "Test"
    
    Given path '/kitchen/v1/publishers/' + publisherId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')
 
    
 	#REV2-22006
  Scenario: DELETE - Verify delete request for Campaign with valid campaign Id using Admin access
  	
  	* def id = 'P_01418'
   	Given path '/kitchen/v1/publishers/' +id
  	When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message contains "Campaign successfully deleted"
		And karate.log('Test Completed !')
		
		
  #REV2-22007
  Scenario: DELETE - Verify delete request for Publisher with invalid Publisher Id using Admin access
    
    * def id = 'P_0141723'
   	Given path '/kitchen/v1/publishers/' +id
    When method delete.
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Publisher Id is not having proper format"
    And karate.log('Test Completed !')
    
 
  #REV2-22008
  Scenario: DELETE - Verify delete request for Publisher with special char in Publisher Id using Admin access
    
    * def id = '@#$%^&*()'
   	Given path '/kitchen/v1/publishers/' +id
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "http.request.rejected"
    And karate.log('Test Completed !')
    
   
  #REV2-22009
  Scenario: DELETE - Verify delete request for Publisher with blank Publisher Id using Admin access
   
   	* def id = ' ' 
   	Given path '/kitchen/v1/publishers/' +id
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Publisher Id is not having proper format"
    And karate.log('Test Completed !')
    

  #REV2-22010
  Scenario: DELETE - Verify delete request for Publisher with negative Publisher Id using Admin access
   
   	* def id = '-11' 
   	Given path '/kitchen/v1/publishers/' +id
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Publisher Id is not having proper format"
    And karate.log('Test Completed !')
    
 
  #REV2-22011
  Scenario: DELETE - Verify delete request for Publisher with positive Publisher Id using Admin access
   
   	* def id = '+222' 
   	Given path '/kitchen/v1/publishers/' +id
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Publisher Id is not having proper format"
    And karate.log('Test Completed !')
    
    