Feature: Category Attribute Category Agent with View permission CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentViewQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * configure readTimeout = 40000
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def result = call read('./category-attribute-supadmin-test.feature@createAttribute')
    * def categoryId = result.response.categoryId
    * def attributeId = result.response.id
    
    * def invalidCategoryId = '534cvv009'
		* def invalidAttributeId = '605wcx318'
	
  @Regression
	#REV2-5057
 	Scenario: GET - Validate Category Agent with View permission can fetch all attributes for valid categoryId
			
		Given path '/' + categoryId + '/attributes'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Total Records found : ', response.total)
		And assert response.total >= 1
		And karate.log('Test Completed !')
		

	#REV2-5062
 	Scenario: GET - Validate error message for Category Agent with View permission to fetch attributes for invalid categoryId
		
		Given path '/' + invalidCategoryId + '/attributes'
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
		
	@Regression
		#REV2-5065
 	Scenario: GET - Validate Category Agent with View permission can fetch specific category attribute for valid attributeId 
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		
		
	
	#REV2-5069
 	Scenario: GET - Validate error message for Category Agent with View permission to fetch specific category attribute for invalid attributeId 
 	
		Given path '/' + categoryId + '/attributes/' + invalidAttributeId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid attribute id'
		And karate.log('Test Completed !')
		
  @Regression
  #REV2-5072
	Scenario: POST - Validate Category Agent with View permission cannot create attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')
		
	
	#REV2-5076
	Scenario: POST - Validate Category Agent with View permission cannot create attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')
		
	@Regression
	#REV2-5085
	Scenario: PATCH - Validate Category Agent with View permission cannot update attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Test Completed !')
		
		
	#REV2-5090
	Scenario: PATCH - Validate error message for Category Agent with View permission to update attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		Given path '/' + invalidCategoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')
		
		@Regression
		#REV2-5102
	Scenario: DELETE - Validate Category Agent with View permission cannot delete attribute for valid categoryId
		
		# try deleting attribute
		Given path '/' + categoryId + '/attributes/' + attributeId
		When method delete
		Then status 403
		And karate.log('Status : 403')
		And karate.log('Test Completed !')
