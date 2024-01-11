Feature: Category Attribute Category Manager CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryManagerQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * configure readTimeout = 40000
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def result = callonce read('./category-attribute-supadmin-test.feature@createAttribute')
    * def categoryId = result.response.categoryId
    * def attributeId = result.response.id
    * def isEnabled = result.response.isEnabled
    
    * def invalidCategoryId = '534cvv009'
		* def invalidAttributeId = '605wcx318'
    
		
  @Regression  
	#REV2-5056
 	Scenario: GET - Validate Category Manager can fetch all attributes for valid categoryId
			
		Given path '/' + categoryId + '/attributes'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Total Records found : ', response.total)
		And assert response.total >= 1
		And karate.log('Test Completed !')
	
		
	#REV2-5060
 	Scenario: GET - Validate error message for Category Manager to fetch attributes for invalid categoryId
		
		Given path '/' + invalidCategoryId + '/attributes'
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
	
	@Regression	
	#REV2-5064	
 	Scenario: GET - Validate Category Manager can fetch specific category attribute for valid attributeId 
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == attributeId
		And karate.log('Test Completed !')
		
		
	#REV2-5068
 	Scenario: GET - Validate error message for Category Manager to fetch specific category attribute for invalid attributeId 
 	
		Given path '/' + categoryId + '/attributes/' + invalidAttributeId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid attribute id'
		And karate.log('Test Completed !')
	
	@Regression
	#REV2-5074
	Scenario: POST - Validate Category Manager can create attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.id == "#notnull"
		And karate.log('Test Completed !')
		* def attributeId = response.id
		* def categoryId = response.categoryId
		
    # Verify created category attributeId
		
		* header Authorization = authToken
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == attributeId
		And karate.log('Test Completed !')
 	
 		
 	#REV2-5078
	Scenario: POST - Validate Category Manager cannot create attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid category id'
		And karate.log('Test Completed !')
		
	
	Scenario: POST - Validate Category Manager cannot create attribute for blank attribute fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = ""
		* eval requestPayload.attributeValue = ""
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Attribute name should not be empty"
		And match response.errors[*].message contains "Attribute value should not be empty"
		And karate.log('Test Completed !')
	
		
	
	#REV2-5082	
	Scenario: POST - Validate Category Manager cannot create attribute for invalid attribute fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = 2333
		* eval requestPayload.attributeValue = 12343453545465465765768798781
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Attribute name and value already exists"
		And karate.log('Test Completed !')
		
	
	Scenario: POST - Validate error message for Category Manager to create duplicate attribute
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		And match response.id == "#notnull"
		
		* header Authorization = authToken
		Given path '/galleria/v1/categories/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Attribute name and value already exists"
		And karate.log('Test Completed !')
	
	@Regression
	#REV2-5084 
	Scenario: PATCH - Validate Category Manager can update attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 202
		And karate.log('Status : 202')
		And match response.message == "Category attribute updated successfully"
		
		And karate.log('Test Completed !')
		
    # Verify Updated category attributeId
		
		* header Authorization = authToken
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == attributeId
		And match response.isEnabled == false
		And karate.log('Test Completed !')
	
		
	#REV2-5092
	Scenario: PATCH - Validate error message for Category Manager to update attribute with duplicate data
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 202
		And karate.log('Status : 202')
		And match response.message == "Category attribute updated successfully"
		
		# update with duplicate requestPayload data
		* header Authorization = authToken
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 200
		And karate.log('Status : 200')
		And match response.message == "There is nothing to update"
		And karate.log('Test Completed !')
		
	
	Scenario: PATCH - Validate error message for Category Manager to update attribute with blank data
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.comment = ""
		* eval requestPayload.isEnabled = ""
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Attribute value should not be empty"
		And match response.errors[*].message contains "Comment should not be empty"
		And match response.errors[*].message contains "Comment should not be less than 10 characters and greater than 1000 characters"
		And match response.errors[*].message contains "Enabled can not be null"
		And match response.errors[*].message contains "Attribute name should not be empty"
		
	  And karate.log('Test Completed !')
		
	
	#REV2-5088
	Scenario: PATCH - Validate error message for Category Manager to update attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		Given path '/' + invalidCategoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		
		And karate.log('Test Completed !')
		
	
	Scenario: PATCH - Validate error message for Category Manager to update attribute for blank categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		# blank categoryId
		* def catId = '  '
		
		Given path '/' + catId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"
		
		And karate.log('Test Completed !')
		
	
	Scenario: PATCH - Validate error message for Category Manager to update attribute for blank attributeId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		* eval requestPayload.comment = "attribute update through automation " + num
		* eval requestPayload.isEnabled = "false"
		
		# blank attributeId
		* def attrId = '  '
		
		Given path '/' + categoryId + '/attributes/' + attrId
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "must not be blank"
		
		And karate.log('Test Completed !')
	
	
	@Regression
	#REV2-5095
	Scenario: DELETE - Validate Category Manager can delete attribute for valid categoryId

		* def attrId = attributeId

		Given path '/' + categoryId + '/attributes/' + attrId
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message == "Category attribute deleted successfully"
		
		And karate.log('Test Completed !')
		
	  # Verify Deleted category attributeId
		
		* header Authorization = authToken
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid attribute id"
		And karate.log('Test Completed !')
	
		
	#REV2-5097
	Scenario: DELETE - Validate error message for Category Manager to delete attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes/' + attributeId
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		
		And karate.log('Test Completed !')
	
		
	#REV2-5099
	Scenario: DELETE - Validate error message for Category Manager to delete attribute for invalid attributeId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes/' + invalidAttributeId
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid attribute id"
		
		And karate.log('Test Completed !')
	
		
	#REV2-5101
	Scenario: DELETE - Validate error message for Category Manager to delete attribute for both invalid categoryId and attributeId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes/' + invalidAttributeId
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		
		And karate.log('Test Completed !')