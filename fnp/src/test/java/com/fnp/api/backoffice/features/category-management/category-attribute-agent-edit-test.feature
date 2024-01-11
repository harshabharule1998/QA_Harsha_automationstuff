Feature: Category Attribute Category Agent with Edit permission CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"categoryAgentQA"}
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
	#REV2-5058
 	Scenario: GET - Validate Category Agent with Edit permission can fetch all attributes for valid categoryId
			
		Given path '/' + categoryId + '/attributes'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Total Records found : ', response.total)
		And assert response.total >= 1
		And karate.log('Test Completed !')
		
	
	#REV2-5061
 	Scenario: GET - Validate error message for Category Agent with Edit permission to fetch attributes for invalid categoryId
		
		Given path '/' + invalidCategoryId + '/attributes'
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
	
	@Regression
	#REV2-5066	
 	Scenario: GET - Validate Category Agent with Edit permission can fetch specific category attribute for valid attributeId 
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Test Completed !')
		
	
 	Scenario: GET - Validate error message for Category Agent with Edit permission to fetch specific category attribute for invalid attributeId 
 	
		Given path '/' + categoryId + '/attributes/' + invalidAttributeId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid attribute id'
		And karate.log('Test Completed !')
		

	@Regression
	#REV2-5071
	Scenario: POST - Validate Category Agent with Edit permission can create attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		* def attributeId = response.id
	  * def categoryId = response.categoryId
		
		And match response.id == "#notnull"
		And karate.log('Test Completed !')
		
		# Verify created category attributeId
		
		* header Authorization = authToken
		
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == attributeId
		And karate.log('Test Completed !')
 	
 	
 	#REV2-5075
	Scenario: POST - Validate Category Agent with Edit permission cannot create attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
		
	
	
	Scenario: POST - Validate Category Agent with Edit permission cannot create attribute for blank attribute fields
		
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
		
	#fail
	# REV2-5070
	Scenario: POST - Validate Category Agent with Edit permission cannot create attribute for invalid attribute fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = 2332
		* eval requestPayload.attributeValue = 12343453545465465765768798789
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Attribute name and value already exists"
		And karate.log('Test Completed !')
	
		
	#REV2-5079
	Scenario: POST - Validate error message for Category Agent with Edit permission to create duplicate attribute
		
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
	#REV2-5086
	Scenario: PATCH - Validate Category Agent with Edit permission can update attribute for valid categoryId
		
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
		And match response.isEnabled != isEnabled
		And karate.log('Test Completed !')
 	
		
	
	#REV2-5079/REV2-5093
	Scenario: PATCH - Validate error message for Category Agent with Edit permission to update attribute with duplicate data
		
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
		
		
	
	Scenario: PATCH - Validate error message for Category Agent with Edit permission to update attribute with blank data
		
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
		And match response.errors[*].message contains "Attribute name should not be empty"
		And match response.errors[*].message contains "Enabled can not be null"
		
		And karate.log('Test Completed !')
		
			
	#REV2-5089
	Scenario: PATCH - Validate error message for Category Agent with Edit permission to update attribute for invalid categoryId
		
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
		And match response.errors[*].message contains "Invalid category id"
		
		And karate.log('Test Completed !')
		
	
	
	Scenario: PATCH - Validate error message for Category Agent with Edit permission to update attribute for blank categoryId
		
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
		And match response.errors[*].message contains "must not be blank"
		
		And karate.log('Test Completed !')
		

	
	Scenario: PATCH - Validate error message for Category Agent with Edit permission to update attribute for blank attributeId
		
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
		And match response.errors[*].message contains "must not be blank"
		
		And karate.log('Test Completed !')
	
  @Regression
	#REV2-5103
	Scenario: DELETE - Validate Category Agent with Edit permission cannot delete attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		* def attrId = response.id
		
		# delete attribute
		* header Authorization = authToken
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attrId
		When method delete
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Test Completed !')
