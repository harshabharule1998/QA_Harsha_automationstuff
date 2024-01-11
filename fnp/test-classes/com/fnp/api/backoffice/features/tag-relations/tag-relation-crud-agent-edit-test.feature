Feature: Tag Relation CRUD feature for Tag Agent with Edit and View permissions

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1/tags'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgent"}
		* def authToken = loginResult.accessToken
		
		* def supAdminLoginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def supAdminAuthToken = supAdminLoginResult.accessToken
		
		* header Authorization = authToken
	
		
  @Regression
	# REV2-4363
	Scenario: GET - Validate Tag Agent can get tag relation with relationId
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.response.tagId
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
		* def relationId = result.response.id
		* def tagRelationId = relationId
	
		Given path '/relations/' + relationId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == relationId
		And karate.log('Validated relationId in response should match searched relationId')
		And karate.log('Verified Created tag relation !')
		
		And karate.log('Deleting created tag')
		
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)

	
  @Regression
	#REV2-4362	
	Scenario: GET - Validate Tag Agent can get all relations for specific tag
		
	  * def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.response.tagId
		Given path '/' + tagId + '/relations'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Validated tagId in each vertices of response should match searched tagId for relations')	
		And karate.log('Test Completed !')
		
		And karate.log('Deleting created tag')
		
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
  @Regression
	#REV2-4373
	Scenario: DELETE - Validate Tag Agent cannot delete tag relation for valid relationId
						
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		
		Given path '/relations/' + tagRelationId
		
		When method delete
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')	

	@Regression		
	#REV2-4364
	Scenario: POST - Validate Tag Agent can create tag relations with only required fields
		
					
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		* eval requestPayload.sequence = ""
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 201
		And karate.log('Status : 201')
	  * def relationId = response.id
		* def tagRelationId = relationId
	
	 # Verify Created tag relation
	 	* header Authorization = authToken
		Given path '/galleria/v1/tags/relations/' + relationId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == relationId
			
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	@Regression	
	#REV2-4365
	Scenario: POST - Validate Tag Agent cannot create tag relations with only optional fields
					
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.relationTypeId = ""
		* eval requestPayload.sequence = "1234"
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[*].message contains 'Relation type id should not be empty'
		And match response.errors[*].message contains 'Target tag id should not be empty'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	#REV2-4366
	Scenario: POST - Validate Tag Agent should not be able to create tag relations with blank data
					
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
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
	

	#REV2-4367
	Scenario: POST - Validate Tag Agent should not be able to create tag relations with duplicate data
						
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
		
		# try to create tag request with duplicate data
		Given path '/' + tagId + '/relations'
		And request result.requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Tag Relation Already Exists'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
		
	#REV2-4368
	Scenario: POST - Validate Tag Agent should not be able to create tag relations for invalid tagId 
		
		* def invalidTagId = "a12c-zz1"	
		
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
	
	
	#REV2-4372
	Scenario: POST - Validate Tag Agent should not be able to create tag relations for invalid data  
		
				
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		
		# add invalid relationTypeId, sequence & targetTagId to requestPayload
		* eval requestPayload.relationTypeId = requestPayload.relationTypeId + "11"
		* eval requestPayload.sequence = 'abcd'
		* eval requestPayload.targetTagId = 'aaa-11x'
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Invalid input data'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')


	@Regression
	#REV2-4370
	Scenario: PUT - Validate Tag Agent can update tag relations with valid data
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		* def relationId = tagRelationId
		
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
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
		
	Scenario: PUT - Validate Tag Agent cannot update tag relations with invalid isEnabled value
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		
		# payload with invalid isEnabled value
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
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	Scenario: PUT -Validate Tag Agent cannot update tag relations with invalid sequence value
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		* def targetTagId = tagId
		
		
		# payload with invalid sequence value
		* def requestPayload =
      """
      {
			    "id": "",
			    "isEnabled": "true",
			    "relationTypeId": "6366833",
			    "sequence": "a11",
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
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	
	#REV2-4371
	Scenario: PUT - Validate Tag Agent cannot update tag relations with duplicate data
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-agent-edit-test.feature@createTagRelationByTagAgent') {tagId: "#(tagId)"}
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
		And header Accept = 'application/json'
		Given path '/galleria/v1/tags/' + tagId + '/relations'
		When request requestPayload
		And method put
		Then status 200
		And karate.log('Status : 200')
		And match response.message == "There is nothing to update"
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
		
		
	#REV2-4369
	Scenario: POST /tag-types with Tag Agent with Edit permission access - try inserting Duplicate values with Spaces
		
				
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
		
	@createTagRelationByTagAgent
	Scenario: Create tag relation for given tagId
		
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
	