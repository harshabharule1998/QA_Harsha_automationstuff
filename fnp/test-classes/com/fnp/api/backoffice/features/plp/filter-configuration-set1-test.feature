Feature: PLP - Filter configurationu Admin feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'		
		And path 'columbus/v1'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"columbusSearchAdmin"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
		* def ValidGeo = "india"
		* def invalidValidGeo = "indian"	
		* def ValidProductType = "black-forest-cakes"
		* def InValidProductType = "Red-forest-cakes"
		* def validCategoryId = "8609768"
		* def inValidCategoryId = "8609768000"
		* def validId = "F_05315"
		* def inValidId = "F_0531525"
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/plp/plp-filter.json')
		
		
   	#REV2-24626
		Scenario: GET - Verify super admin user can fetch list of filters for valid Geography
	
		Given path 'productfilterconfigs'
		And param geo = ValidGeo	
		When method get
		Then status 200
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
		
		#REV2-24627
		Scenario: GET - Verify super admin user can fetch list of filters by passing all valid parameter
  
    Given path 'productfilterconfigs'
    And param geo = ValidGeo
    And param page = 0
    And param productType = ValidProductType
    And param size = 10
    And param sortparam = 'filterId:asc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
	
		
		#REV2-24629
		Scenario: GET - Verify super admin user can fetch list of filters for invalid Geography
	
		Given path 'productfilterconfigs'
		And param geo = invalidValidGeo	
		When method get
		Then status 200
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
		
		
		#REV2-24630
		Scenario: GET - Verify super admin user can fetch list of filters by passing invalid parameter combination.
  
  	Given path 'productfilterconfigs'
    And param geo = invalidValidGeo
    And param page = 0
    And param productType = InValidProductType
    And param size = 10
    And param sortparam = 'filterId:asc'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
    
    #REV2-24631
    Scenario: GET - Verify super admin user can fetch list of filters for invalid endpoint
		
		Given path 'productfilterconfigsproduct/type/invalidendpoint'
		And param geo = ValidGeo	
		When method get
		Then status 404
		And karate.log('Status : 404')			
		And karate.log('Test Completed !')
		
		
		#REV2-24633
    Scenario: POST - Verify super admin user can create new filter with invalid body request
    
    * eval requestPayload.productTypeId = "InvalidProductType"
    * karate.log(requestPayload)
    
    Given path 'productfilterconfigs'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    
    
    #REV2-24635
    Scenario: POST - Verify super admin user can create new filter with invalid GeoId
    
    * def requestPayload = requestPayload.insert
    * eval requestPayload.geoId = "InvalidGeo"
    * karate.log(requestPayload)
    
    Given path 'productfilterconfigs'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    
        
    #REV2-24636
    Scenario: POST - Verify super admin user can create new filter with invalid data type
    
    * def requestPayload = requestPayload.insert
    * eval requestPayload.geoId = "InvalidGeo"
    * eval requestPayload.productTypeId = 12345
    * karate.log(requestPayload)
    
    Given path 'productfilterconfigs'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    
    
	  #REV2-24637
    Scenario: GET - Verify Getting filter config with valid ID.
		
		Given path 'productfilterconfigs/'+validId
		When method get
		Then status 200
		And karate.log('Response is:', response)
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
		
		
	  #REV2-24638
    Scenario: GET - Verify Getting filter config with invalid ID.
		
		Given path 'productfilterconfigs/'+inValidId	
		When method get
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
				
	  #REV2-24640
    Scenario: GET - Verify Getting filter config with invalid endpoint.
		
		Given path 'productfilterconfigs//InvalidEndpoint'	
		When method get
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
	  #REV2-24641
    Scenario: PATCH -  Verify filterconfig Activate/deactivate based on valid ID.
		
		* def requestPayload = requestPayload.patch
		* eval requestPayload.isEnabled = true
		* karate.log(requestPayload)
		
		Given path 'productfilterconfigs/'+validId
		And request requestPayload
		When method patch
		Then status 202
		And karate.log('Response is:', response)
		And karate.log('Status : 202')			
		And karate.log('Test Completed !')
		
		
		#REV2-24642
    Scenario: PATCH -  Verify filterconfig Activate/deactivate based on invalid ID.
		
		* def requestPayload = requestPayload.patch
		* eval requestPayload.isEnabled = true
		* karate.log(requestPayload)
		
		Given path 'productfilterconfigs/'+inValidId	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		#REV2-24643
    Scenario: PATCH -  Verify filterconfig Activate/deactivate based on blank ID.
		
		* def requestPayload = requestPayload.patch
		* eval requestPayload.isEnabled = true
		* karate.log(requestPayload)
		
		Given path 'productfilterconfigs/'
		And request requestPayload
		When method patch
		Then status 405
		And karate.log('Response is:', response)
		And karate.log('Status : 405')			
		And karate.log('Test Completed !')
		
		
		#REV2-24644
    Scenario: PATCH -  Verify filterconfig Activate/deactivate based on invalid endpoint.
		
		* def requestPayload = requestPayload.patch
		* eval requestPayload.isEnabled = true
		* karate.log(requestPayload)
		
		Given path 'productfilterconfigs//invalidpath'	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		#REV2-25138
    Scenario: PATCH -  Verify update filter attribute using valid category id.
				
		* def requestPayload = requestPayload.attribute	
		* karate.log(requestPayload)
				
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 200
		And karate.log('Response is:', response)
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
		
				
		#REV2-25139
    Scenario: PATCH -  Verify update filter attribute using invalid id.
				
		* def requestPayload = requestPayload.attribute
		* karate.log(requestPayload)
				
		Given path 'categories/productfilterconfigs/attributes/'+inValidCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
				
		
		#REV2-25140
    Scenario: PATCH -  Verify update filter attribute using blank id.
		
		* def requestPayload = requestPayload.attribute
		* karate.log(requestPayload)
				
		Given path 'categories/productfilterconfigs/attributes/'
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		#REV2-25141
    Scenario: PATCH -  Verify update filter attribute using invalid endpoint.
				
		* def requestPayload = requestPayload.attribute
		* karate.log(requestPayload)
				
		Given path 'categories/productfilterconfigs/attribut9768/invalidendpoint/'
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 404
		And karate.log('Response is:', response)
		And karate.log('Status : 404')			
		And karate.log('Test Completed !')
		
		
		#REV2-25142
    Scenario: PATCH -  Verify update filter attribute using valid body parameter attributesName.
						
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].attributesName = "AGE_GROUP"
		* karate.log(requestPayload)
		
		Given param isOverride = true
		And path 'categories/productfilterconfigs/attributes/8609768'
		And request requestPayload
		When method patch
		Then status 200
		And karate.log('Response is:', response)
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
				
		
		#REV2-25143
    Scenario: PATCH -  Verify update filter attribute using invalidvalid body parameter attributesName.
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].attributesName = "AGE_GR888OUP"
		* karate.log(requestPayload)
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		
		#REV2-25144
    Scenario: PATCH -  Verify update filter attribute using blank body parameter attributesName.
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].attributesName = " "
		* karate.log(requestPayload)
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		#And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		
		#REV2-25145
    Scenario: PATCH -  Verify update filter attribute using valid body parameter isEnabled.
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].isEnabled = true
		* karate.log(requestPayload)
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 200
		And karate.log('Response is:', response)
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
		
		
		
		#REV2-25146
    Scenario: PATCH -  Verify update filter attribute using invalid body parameter isEnabled.
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].isEnabled = "yes"
		* karate.log(requestPayload)
		
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		#REV2-25147
    Scenario: PATCH -  Verify update filter attribute using valid sequenceNumber in body parameter .
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].sequenceNumber = 3
		* karate.log(requestPayload)
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 200
		And karate.log('Response is:', response)
		And karate.log('Status : 200')			
		And karate.log('Test Completed !')
		
		
		#REV2-25148
    Scenario: PATCH -  Verify update filter attribute using invalid sequenceNumber in body parameter.
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].sequenceNumber = "A"
		* karate.log(requestPayload)
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		
		
		#REV2-25149
    Scenario: PATCH -  Verify update filter attribute using blank sequenceNumber in body parameter.
				
		* def requestPayload = requestPayload.attribute		
		* eval requestPayload[0].sequenceNumber = ""
		* karate.log(requestPayload)
					
		Given path 'categories/productfilterconfigs/attributes/'+validCategoryId
		And param isOverride = true	
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Response is:', response)
		And karate.log('Status : 400')			
		And karate.log('Test Completed !')
		