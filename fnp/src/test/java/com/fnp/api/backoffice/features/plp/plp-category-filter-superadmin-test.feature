Feature: PLP Module Category Filter scenarios with Super Admin

  Background: 
  
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/columbus/v1/categories/productfilterconfigs'
    
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:'superAdminQA'}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def validCategoryId = "8210100"
    * def invalidCategoryId = "8210ABC"
    
    * def updateFilterPayload = read('classpath:com/fnp/api/backoffice/data/plp/update-filter-attribute.json')
    
    * def patchRequestPayload =
 		"""
 			{
		    "isEnabled": "true"
			}
 		"""

  #REV2-23846
  Scenario: GET - Verify Super admin to get category filter config data with valid categoryId		
    
    Given param categoryId = validCategoryId
    When method get
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And assert response.filterAttributes.length > 0
    And karate.log('Test Completed !')

	
  #REV2-23847
  Scenario: GET - Verify Super admin to get category filter config data with invalid categoryId		
    
    Given param categoryId = invalidCategoryId
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "CategoryId is not present in Galleria"
    And karate.log('Test Completed !')
    
	
  #REV2-23848
  Scenario: GET - Verify Super admin to get category filter config data with blank categoryId		
    
    Given param categoryId = ""
    When method get
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "categoryId should not be blank or null"
    And karate.log('Test Completed !')
    
 	
  #REV2-23849
  Scenario: GET - Verify Super admin to get category filter config data with invalid endpoint		
    
    Given path '/test'
    And param categoryId = validCategoryId
    When method get
    Then status 405
    And karate.log('Response is : ', response)
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    And karate.log('Test Completed !')
	
	
	#REV2-23831
  Scenario: PATCH - Verify Super admin to activate/deactivate category filter config with valid categoryId		
    
    * def validCategoryId = "8216437"
    
    Given path "/" + validCategoryId
    And request patchRequestPayload
    When method patch
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And match response.isEnabled == true
    And karate.log('Test Completed !')
    
	
	#REV2-23832
  Scenario: PATCH - Verify Super admin to activate/deactivate category filter config with invalid categoryId		
    
    * def invalidCategoryId = "8216437ABC"
    
    Given path "/" + invalidCategoryId
    And request patchRequestPayload
    When method patch
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Filter config not Present"
    And karate.log('Test Completed !')
    
	
	#REV2-23833
  Scenario: PATCH - Verify Super admin to activate/deactivate category filter config with blank categoryId		
    
    * def blankCategoryId = " "
    
    Given path "/" + blankCategoryId
    And request patchRequestPayload
    When method patch
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Filter config not Present"
    And karate.log('Test Completed !')
    

	#REV2-23834
  Scenario: PATCH - Verify Super admin to activate/deactivate category filter config with invalid endpoint		
    
    * def validCategoryId = "8216437"
    
    Given path "/" + validCategoryId + "/activate"
    And request patchRequestPayload
    When method patch
    Then status 404
    And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
	
	#REV2-23835, REV2-23836 and REV2-23840
  Scenario: PATCH - Verify Super admin to update filter attribute with valid data	and valid categoryId	
    
    Given path "/attributes/" + validCategoryId
    And param isOverride = false
    And request updateFilterPayload
    When method patch
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    
    * def items = get response.filterAttributes[*]
    
    * def filt = function(x){ return x.attributesName == "CHARACTER" || x.attributesName == "PERSONALITY"}
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].sequenceNumber == 2
		And match res[1].sequenceNumber == 4
    And karate.log('Test Completed !')
     
  
	#REV2-23837
  Scenario: PATCH - Verify Super admin to update filter attribute with valid data	and invalid categoryId	
    
    Given path "/attributes/" + invalidCategoryId
    And param isOverride = false
    And request updateFilterPayload
    When method patch
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "CategoryId is not present"
    And karate.log('Test Completed !')
  
  
	#REV2-23838
  Scenario: PATCH - Verify Super admin to update filter attribute with valid data	and blank categoryId	
    
    * def blankCategoryId = " "
    
    Given path "/attributes/" + blankCategoryId
    And param isOverride = false
    And request updateFilterPayload
    When method patch
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "CategoryId is not present"
    And karate.log('Test Completed !')
    

	#REV2-23839
  Scenario: PATCH - Verify Super admin to update filter attribute with invalid data	and valid categoryId	
    
  	* eval updateFilterPayload[0].sequenceNumber = "abc"
  	* eval updateFilterPayload[0].isEnabled = 123
    
    Given path "/attributes/" + validCategoryId
    And param isOverride = false
    And request updateFilterPayload
    When method patch
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')     
    

	#REV2-23841
  Scenario: PATCH - Verify Super admin to update filter attribute by passing same sequence for two attributes	
    
  	* eval updateFilterPayload[0].sequenceNumber = 2
  	* eval updateFilterPayload[1].sequenceNumber = 2
    
    Given path "/attributes/" + validCategoryId
    And param isOverride = false
    And request updateFilterPayload
    When method patch
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And match response.errors[0].message contains "same sequence numbers are not allowed"
    And karate.log('Test Completed !')     
    
         
	#REV2-23842
  Scenario: PUT - Verify Super admin to reset category filter config with valid categoryId		
     
    Given path "/reset/" + validCategoryId
    And request {}
    When method put
    Then status 200
    And karate.log('Response is : ', response)
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
	
	#REV2-23843
  Scenario: PUT - Verify Super admin to reset category filter config with invalid categoryId		
    
    Given path "/reset/" + invalidCategoryId
    And request {}
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
	
	#REV2-23844
  Scenario: PUT - Verify Super admin to reset category filter config with blank categoryId		
    
    * def blankCategoryId = " "
    
    Given path "/reset/" + blankCategoryId
    And request {}
    When method put
    Then status 400
    And karate.log('Response is : ', response)
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
	
	#REV2-23845
  Scenario: PUT - Verify Super admin to reset category filter config with invalid endpoint		
      
    Given path "/reset1/" + validCategoryId
    And request {}
    When method put
    Then status 404
    And karate.log('Response is : ', response)
    And karate.log('Status : 404')
    And karate.log('Test Completed !')