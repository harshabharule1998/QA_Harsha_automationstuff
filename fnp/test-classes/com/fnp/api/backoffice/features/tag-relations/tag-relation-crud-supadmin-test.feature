Feature: Tag Relation Super Admin CRUD feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1/tags'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken

	@createTagRelation
	Scenario: POST - Create tag relation for given tagId
		
		* def tagId = __arg.tagId
		* karate.log('Creating new tag relation for tagId : ', tagId)
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
		* def tagRelationId = response.id
		And match response.id == '#notnull'
	
	@Regression			
	#REV2-4331	
	Scenario: GET - Validate super admin can get tag relation with relationId
		
		* def relationId = '6219542'
		Given path '/relations/' + relationId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == relationId
		And karate.log('Validated relationId in response should match searched relationId')
		And karate.log('Test Completed !')

	@Regression
	#REV2-4330
	Scenario: GET - Validate super admin can get all relations for specific tag
		
		* def tagId = 'tag-auto-0941345'
		Given path '/' + tagId + '/relations'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
	#	And match each response.data.tagRelations[*].vertices[0] contains { tagId: '#(tagId)'}
	#	And karate.log('Validated tagId in each vertices of response should match searched tagId for relations')	
		And karate.log('Test Completed !')
		
	
	@Regression	
	#REV2-4330
	Scenario: GET - Validate super admin can get all tag relations type
		
		Given path '/relation-types'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match each response contains { id: '#notnull', relationType: '#notnull', name: '#notnull', isNegative: '#notnull'}
		And karate.log('Validated relation types response fields are not null')	
		And karate.log('Test Completed !')

	#@Regression	
	#REV2-4333
	Scenario: POST - Validate super admin can create tag relations with valid data
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		* def tagId = result.requestPayload.tagName
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def relationId = result.tagRelationId
		
		# Verify Created tag relation
	 	* header Authorization = authToken
		Given path '/relations/' + relationId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == relationId
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')


	#REV2-4334
	Scenario: POST - Validate super admin should not be able to create tag relations with blank data
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		* def tagId = result.requestPayload.tagName	
		
		* karate.log('Creating new tag relation with blank data for above created tagId : ', tagId)
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.relationTypeId = " "
		* eval requestPayload.sequence = " "
		* eval requestPayload.targetTagId = " "
		
		* karate.log(requestPayload)
	
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400 
		And karate.log('Status : 400')
		And match response.errors[*].message contains 'Relation type id should not be empty'
		And match response.errors[*].message contains 'Target tag id should not be empty'

		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
	
	
	#REV2-4336
	Scenario: POST - Validate super admin should not be able to create tag relations with duplicate data
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		
		# try to create tag request with duplicate data
		Given path '/' + tagId + '/relations'
		And request result.requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Tag Relation Already Exists'
		
		And karate.log('Deleting created tag')
	  #And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
	

	#REV2-4340
	Scenario: POST - Validate super admin should not be able to create tag relations with duplicate data with spaces added 
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		
		# try to create tag request with duplicate data with spaces added
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.relationTypeId = " " + result.requestPayload.relationTypeId + " "
		* eval requestPayload.sequence = " " + result.requestPayload.sequence + " "
		* eval requestPayload.targetTagId = " " + result.requestPayload.targetTagId + " "
		
		Given path '/' + tagId + '/relations'
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Tag Relation Already Exists'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	Scenario: POST - Validate super admin should not be able to create tag relations for invalid tagId 
		
		* def invalidTagId = "abc-xxx1"	
		
		* karate.log('Trying to create new tag relation for invalidTagId : ', invalidTagId)
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = 'aaa'
		
		* karate.log(requestPayload)
			
		Given path '/' + invalidTagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Id'
		
		And karate.log('Test Completed !')	


	#REV2-4337
	Scenario: POST - Validate super admin should not be able to create tag relations for invalid relationTypeId  
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		
		# add invalid relationTypeId to requestPayload
		* eval requestPayload.relationTypeId = requestPayload.relationTypeId + "11"
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Relation Type Td'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	#REV2-4338
	Scenario: POST - Validate super admin should not be able to create tag relations for invalid sequence  
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		
		# add invalid sequence to requestPayload
		* eval requestPayload.sequence = 'abcd'
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid input data'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	#REV2-4339
	Scenario: POST - Validate super admin should not be able to create tag relations for invalid targetTagId  
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		
		# add invalid targetTagId to requestPayload
		* eval requestPayload.targetTagId = 'aaa-11x'
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Target Tag id'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
	

	@Regression
	#REV2-4355
	Scenario: DELETE - Validate super admin can delete tag relation for valid relationId
						
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def relationId = tagRelationId
		
		Given path '/relations/' + tagRelationId
		
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message == 'Tag relation Deleted Successfully'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
		# Verify deleted tag relation
	 	* header Authorization = authToken
		Given path '/galleria/v1/tags/relations/' + relationId
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].message contains 'Tag relation id does not exists'	


	#REV2-4356
	Scenario: DELETE - Validate super admin cannot delete tag relation for invalid relationId
						
		* def relationId = '622565'
		Given path '/relations/' + relationId
		
		When method delete
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Tag relation id does not exists'
		And karate.log('Test Completed !')
		
		
	@Regression
	#REV2-4341
	Scenario: PUT - Validate super admin can update tag relations with valid data
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def relationId = tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "123",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = tagRelationId
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 202
		And karate.log('Status : 202')
		And match response.message == 'Tag relation updated successfully'
		
		# Verify Updated tag relation
	 	* header Authorization = authToken
		Given path '/galleria/v1/tags/relations/' + relationId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == relationId
		And match response.sequence != 1
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	#REV2-4347	
	Scenario: PUT - Validate super admin cannot update tag relations with invalid relation id
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "13167530",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "123",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Relation Id'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		

	#REV2-4346
	Scenario: PUT - Validate super admin cannot update tag relations with invalid isEnabled value
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "abc",
			    "relationTypeId": "6366833",
			    "sequence": "123",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = tagRelationId
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid input data'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		

	#REV2-4348
	Scenario: PUT - Validate super admin cannot update tag relations with invalid relationTypeId
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": true,
			    "relationTypeId": "6366833111",
			    "sequence": 123,
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = tagRelationId
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Relation Type Td'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		

	#REV2-4349
	Scenario: PUT - Validate super admin cannot update tag relations with invalid sequence value
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "abc",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = tagRelationId
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid input data'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')

	
	#REV2-4345
	Scenario: PUT - Validate super admin cannot update tag relations with invalid targetTagId
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "123",
			    "targetTagId": "1abc32"
			}
      """
		
		* eval requestPayload.id = tagRelationId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Target Tag id'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')	
	

	#REV2-4342
	Scenario: PUT - Validate super admin cannot update tag relations with duplicate data
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "123",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = tagRelationId
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 202
		And karate.log('Status : 202')
		And match response.message == 'Tag relation updated successfully'
		
		# try updating again with duplicate data
		* header Authorization = authToken
		Given path '/galleria/v1/tags/' + tagId + '/relations'
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.message == "There is nothing to update"
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
		
	#REV2-4343
	Scenario: PUT - Validate super admin can update tag relations with data having spaces
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": " true ",
			    "relationTypeId": "6366833",
			    "sequence": " 123 ",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = " " + tagRelationId + " "
		* eval requestPayload.targetTagId = " " + targetTagId + " "
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Relation Id'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		

	#REV2-4344
	Scenario: PUT - Validate super admin cannot update tag relations with blank data
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		* def requestPayload =
      """
      {
			    "id": " ",
			    "isEnabled": " ",
			    "relationTypeId": " ",
			    "sequence": " ",
			    "targetTagId": " "
			}
      """
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Target Tag id'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
		    
		  
		 #REV2-4332
	Scenario: GET - Validate super admin can get tag relation with relationId
		
		* def relationId = '6366833'
		Given path '/relations/' + relationId
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Tag relation id does not exists'
		And karate.log('Validated relationId in response should match searched relationId')
		And karate.log('Test Completed !')
		
		
		 
		 #REV2-4350
		Scenario: POST - Verify any method with Invalid value for endpoint parameters
		
		* def requestPayload = {}
      
		Given path '/relation-types'
		
		When request requestPayload
		And method post
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message == 'Unsupported request Method. Contact the site administrator'
		And karate.log('Test Completed !')
		
		
		
		#REV2-4353
		Scenario: GET - Verify 400 error for invalid TagId
		
		* def invalidTagId = "abc-xxx1"	
		Given path '/' + invalidTagId + '/relations'
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Id'
		
		And karate.log('Test Completed !')
		
		
			#REV2-4538	
	Scenario: Post- Verify field length validation for each fields of the request body
					
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		# invalid sequence length 
		* eval requestPayload.sequence = "1234567891234567765"
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid input data'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
	 
	 
	 #REV2-4539
	Scenario: Put- Verify field length validation for each fields of the request body
	
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		# invalid sequence length 
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "1234567891234567765",
			    "targetTagId": ""
			}
      """
		
		* eval requestPayload.id = tagRelationId
		* eval requestPayload.targetTagId = targetTagId
		
		Given path '/' + tagId + '/relations'
		
		When request requestPayload
		And method put
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid input data'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	