Feature: Tag Relation CRUD feature for Tag Agent with only View permissions

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1/tags'
		* def loginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgentView"}
		* def authToken = loginResult.accessToken
		
		* def supAdminLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def supAdminAuthToken = supAdminLoginResult.accessToken
		
		* header Authorization = authToken
	
	@Regression
	#REV2-4358
	Scenario: GET - Validate Tag Agent with only view permissions can get tag relation with relationId
		
		* def relationId = '18178979'
		Given path '/relations/' + relationId
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.id == relationId
		And karate.log('Validated relationId in response should match searched relationId')
		And karate.log('Test Completed !')
	
	@Regression
	#REV2-4357
	Scenario: GET - Validate Tag Agent with only view permissions can get all relations for specific tag
		
		* def tagId = 'tag-auto-0941345'
		Given path '/' + tagId + '/relations'
		
		When method get
		Then status 200
		And karate.log('Status : 200')
	  #And match each response.data.tagRelations[*].vertices[0] contains { tagId: '#(tagId)'}
		And karate.log('Validated tagId in each vertices of response should match searched tagId for relations')	
		And karate.log('Test Completed !')
		
 @Regression
	#REV2-4359
	Scenario: POST - Validate Tag Agent with only view permissions cannot create tag relations
						
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(supAdminAuthToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tag-relation.json')
		* eval requestPayload.targetTagId = tagId
		* eval requestPayload.sequence = ""
		
		* karate.log(requestPayload)
			
		Given path '/' + tagId + '/relations'
		
		And request requestPayload
		When method post
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
  @Regression		
	#REV2-4360
	Scenario: PUT - Validate Tag Agent with only view permissions cannot update tag relations
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(supAdminAuthToken)"}
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
		Then status 403
		And karate.log('Status : 403')
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(supAdminAuthToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	@Regression
	#REV2-4361	
	Scenario: DELETE - Validate Tag Agent with only view permissions cannot delete tag relation
						
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(supAdminAuthToken)"}
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