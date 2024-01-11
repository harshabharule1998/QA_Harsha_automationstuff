Feature: Tag Relation error validation feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1/tags'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
		
	
	Scenario: POST - Verify field length validation error for POST request
					
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
	 
	 
	Scenario: PUT - Verify field length validation error for PUT request
	
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
			    "relationTypeId": "884483",
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
	
	
	Scenario: GET - Verify 400 error for invalid TagId
		
		* def invalidTagId = "abc-xxx1"	
		Given path '/' + invalidTagId + '/relations'
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		And match response.errors[0].message == 'Please enter a valid Tag Id'
		
		And karate.log('Test Completed !')
		
		 
	Scenario: POST - Verify 405 error for tag relation endpoint
		
		* def requestPayload = {}
      
		Given path '/relation-types'
		
		When request requestPayload
		And method post
		Then status 405
		And karate.log('Status : 405')
		And karate.log('Test Completed !')

		
	Scenario: GET - Verify invalid authorization token
		
		* def tagId = "aaa"
		* def invalidAuthToken = "eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
		* header Authorization = invalidAuthToken
		Given path '/' + tagId + '/relations'
		
		When method get
		Then status 401
		And karate.log('Status : 401')
		And match response.errors[0].message == 'Token Invalid! Authentication Required'
		
		And karate.log('Test Completed !')
		
		
	Scenario: POST - Verify unsupported method for endpoint
		
		* def requestPayload = {}
      
		Given path '/relation-types'
		
		When request requestPayload
		And method post
		Then status 405
		And karate.log('Status : 405')
		And match response.errors[0].message contains "Unsupported request Method"
		
		And karate.log('Test Completed !')
