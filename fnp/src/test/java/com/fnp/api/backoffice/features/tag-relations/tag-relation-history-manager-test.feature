Feature: Tag Relation History Tag Manager feature

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1/tags'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagManager"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
	
	@Regression
	# REV2-10598 & REV2-10599
	Scenario: GET - Validate Tag Manager can fetch tag relation history for valid tagId
					
		* def tagId = "tag-auto-09413456"
		
		Given path '/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 200
		And karate.log('Status : 200')
		
		And match response.data[1].oldValue == null
		And match response.data[1].newValue == 1
		
		And karate.log('Test Completed !')
	
	
 	@Regression
	# REV2-10600
	Scenario: GET - Validate Tag Manager can fetch tag relation history after create
					
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* match result.responseStatus == 201
		
		* def tagId = result.requestPayload.tagName	
		
		* def result = call read('./tag-relation-crud-supadmin-test.feature@createTagRelation') {tagId: "#(tagId)"}
		* def tagRelationId = result.tagRelationId
		
		Given path '/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 200
		And karate.log('Status : 200')
		
		And match response.data[1].oldValue == null
		And match response.data[1].newValue == true
		
		And match response.data[3].oldValue == null
		And match response.data[3].newValue == 1
		
		And karate.log('Deleting tag relation')
		* header Authorization = authToken
		* path '/galleria/v1/tags/relations/' + tagRelationId		
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message == 'Tag relation Deleted Successfully'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
		
	@Regression
	# REV2-10601
	Scenario: GET - Validate Tag Manager can fetch tag relation history after edit
					
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
			    "isEnabled": "false",
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
		
		* header Authorization = authToken
		Given path '/galleria/v1/tags/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 200
		And karate.log('Status : 200')

    * def historyResponse = response
		
		# filter history response to get objects by isEnabled   
    * def filt = function(x){ return x.fieldName == "isEnabled"  && x.action == "UPDATE" }
    * def items = get historyResponse.data[*]
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == true
		And match res[0].newValue == false
		
#		# filter history response to get objects by relationTypeId   
    #* def filt = function(x){ return x.fieldName == "relationTypeId"  && x.action == "UPDATE" }
    #* def items = get historyResponse.data[*]
    #* def res = karate.filter(items, filt)    
    #* print "Filter Response : ", res
    
    #	And match res[0].oldValue == '884483'
    #	And match res[0].newValue == '6366833'
		
		# filter history response to get objects by sequence   
    * def filt = function(x){ return x.fieldName == "sequence"  && x.action == "UPDATE" }
    * def items = get historyResponse.data[*]
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == 1
		And match res[0].newValue == 123
		
		And karate.log('Deleting tag relation')
		* header Authorization = authToken
		* path '/galleria/v1/tags/relations/' + tagRelationId		
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message == 'Tag relation Deleted Successfully'
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		And karate.log('Test Completed !')
	
	

	@Regression
	# REV2-10602
	Scenario: GET - Validate Tag Manager can fetch tag relation history after delete
					
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
			    "isEnabled": "false",
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
		
		And karate.log('Deleting tag relation')
		* header Authorization = authToken
		* path '/galleria/v1/tags/relations/' + tagRelationId		
		When method delete
		Then status 200
		And karate.log('Status : 200')
		And match response.message == 'Tag relation Deleted Successfully'
		
		* header Authorization = authToken
		Given path '/galleria/v1/tags/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 200
		And karate.log('Status : 200')

		* def historyResponse = response
		
		# filter history response to get objects by isEnabled   
    * def filt = function(x){ return x.fieldName == "isEnabled"  && x.action == "DELETE" }
    * def items = get historyResponse.data[*]
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == false
		And match res[0].newValue == null
		
		# filter history response to get objects by sequence   
    * def filt = function(x){ return x.fieldName == "sequence"  && x.action == "DELETE" }
    * def items = get historyResponse.data[*]
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == 123
		And match res[0].newValue == null
		
		And karate.log('Test Completed !')
		

	# REV2-10603
	Scenario: GET - Validate Tag Manager cannot fetch tag relation history for invalid tagId
					
		* def tagId = "tag-auto-xyz3"
		
		Given path '/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then assert response.errors[0].message == "Tag id does not exists"
		
		And karate.log('Test Completed !')
