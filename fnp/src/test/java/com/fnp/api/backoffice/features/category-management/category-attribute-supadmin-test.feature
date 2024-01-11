Feature: Category Attribute Super Admin CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/categories'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * configure readTimeout = 40000
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8) 
    * def categoryId = '6375163'
    * def invalidCategoryId = '534cvv009'
	  * def attributeId = '6646248'
		* def invalidAttributeId = '605wcx318'
		

  @Regression
	Scenario: GET - Validate Super Admin can fetch all attributes for valid categoryId
			
		Given path '/' + categoryId + '/attributes'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Total Records found : ', response.total)
		And assert response.total >= 1
		And karate.log('Test Completed !')
		
	
	#REV2-5060
 	Scenario: GET - Validate error message for Super Admin to fetch attributes for invalid categoryId
		
		Given path '/' + invalidCategoryId + '/attributes'
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		And karate.log('Test Completed !')
	
	@Regression
	#REV2-5063
 	Scenario: GET - Validate Super Admin can fetch specific category attribute for valid attributeId 
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == attributeId
		And karate.log('Test Completed !')
		
		
	#REV2-5067
 	Scenario: GET - Validate error message for Super Admin to fetch specific category attribute for invalid attributeId 
 	
		Given path '/' + categoryId + '/attributes/' + invalidAttributeId
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid attribute id'
		And karate.log('Test Completed !')
	
  
  @createAttribute
	#REV2-5073
	Scenario: POST - Validate Super Admin can create attribute for valid categoryId
		* def result = call read('./category-master-supadmin-test.feature@createBaseURLCategory')
		* def categoryId = result.responseData.id
		
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
 		
 	
	Scenario: POST - Validate Super Admin cannot create attribute for invalid categoryId
		
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
		
	
	Scenario: POST - Validate Super Admin cannot create attribute for blank attribute fields
		
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
		
	
	#REV2-5087
	Scenario: POST - Validate Super Admin cannot create attribute for invalid attribute fields
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = 1234
		* eval requestPayload.attributeValue = 123456789
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Attribute name and value already exists"
		And karate.log('Test Completed !')
	
	
  #REV2-5081
	Scenario: POST - Validate error message for Super Admin to create duplicate attribute
		
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
	#REV2-5083
	Scenario: PATCH - Validate Super Admin can update attribute for valid categoryId
		
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
	
	
	#REV2-5091
	Scenario: PATCH - Validate error message for Super Admin to update attribute with duplicate data
		
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
		
			
	
	Scenario: PATCH - Validate error message for Super Admin to update attribute with blank data
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.comment = ""
		* eval requestPayload.isEnabled = ""
		
		Given path '/' + categoryId + '/attributes/' + attributeId
		And request requestPayload
		When method patch
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].message contains "Comment should not be less than 10 characters and greater than 1000 characters"
		And karate.log('Test Completed !')
		
		
	#REV2-5087
	Scenario: PATCH - Validate error message for Super Admin to update attribute for invalid categoryId
		
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
	
		
	
	Scenario: PATCH - Validate error message for Super Admin to update attribute for blank categoryId
		
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
	
	
	Scenario: PATCH - Validate error message for Super Admin to update attribute for blank attributeId
		
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
	#REV2-5094
	Scenario: DELETE - Validate Super Admin can delete attribute for valid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes'		
		And request requestPayload
		When method post
		Then status 201
		* def attrId = response.id
		* def attributeId = attrId
		
		# delete attribute
		* header Authorization = authToken
		Given path '/galleria/v1/categories/' + categoryId + '/attributes/' + attrId
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
	
	
	#REV2-5100
	Scenario: DELETE - Validate error message for Super Admin to delete attribute for invalid categoryId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes/' + attributeId
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		
		And karate.log('Test Completed !')
	
	
	#REV2-5098
	Scenario: DELETE - Validate error message for Super Admin to delete attribute for invalid attributeId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + categoryId + '/attributes/' + invalidAttributeId
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid attribute id"
		
		And karate.log('Test Completed !')
		
  
  #REV2-5100
	Scenario: DELETE - Validate error message for Super Admin to delete attribute for both invalid categoryId and attributeId
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/category-attribute.json')
		* eval requestPayload.attributeName = "attrAutoName" + num
		* eval requestPayload.attributeValue = "attrAutoValue" + num
		
		Given path '/' + invalidCategoryId + '/attributes/' + invalidAttributeId
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == "Invalid category id"
		
		And karate.log('Test Completed !')