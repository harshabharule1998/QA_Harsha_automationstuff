Feature: Tag Relation History feature for Tag Agent with Edit permission

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1/tags'
		
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgent"}
		* def authToken = loginResult.accessToken
		
		* def supAdminLoginResult = call read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
		* def supAdminAuthToken = supAdminLoginResult.accessToken
		
		* header Authorization = authToken
	
 	@Regression
	Scenario: GET - Validate Tag Agent with Edit permission can fetch tag relation history for valid tagId
					
		* def tagId = "tag-auto-09413456"
		
		Given path '/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 200
		And karate.log('Status : 200')
		
		And match response.data[0].oldValue == null
		And match response.data[0].newValue == true
		
		And karate.log('Test Completed !')
	
		
	@Regression
	# REV2-10604
	Scenario: GET - Validate Tag Agent with Edit permission can fetch tag relation history after create
					
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(supAdminAuthToken)"}
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
				
		And karate.log('Test Completed !')
	
	
	@Regression
	# REV2-10605
	Scenario: GET - Validate Tag Agent with Edit permission can fetch tag relation history after edit
					
		* def tagIdAfterEditRelation = "tag-auto-0941345"
		Given path '/history'
		And param tagId = tagIdAfterEditRelation
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
		
		# filter history response to get objects by relationTypeId   
    #* def filt = function(x){ return x.fieldName == "relationTypeId"  && x.action == "UPDATE" }
    #* def items = get historyResponse.data[*]
    #* def res = karate.filter(items, filt)    
    #* print "Filter Response : ", res
    #
    #	And match res[0].oldValue == '6366833'
    # And match res[0].newValue == '6221565'
		
		# filter history response to get objects by sequence   
    * def filt = function(x){ return x.fieldName == "sequence"  && x.action == "UPDATE" }
    * def items = get historyResponse.data[*]
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[*].oldValue == [123]
		And match res[*].newValue == [1]
		
		And karate.log('Test Completed !')
		

	# REV2-10606
	Scenario: GET - Validate Tag Agent with Edit permission can fetch tag relation history after delete
	
		* def deletedTagId = 'tag-auto-09413123'		
					
		Given path '/history'
		And param tagId = deletedTagId
		And param sortParam = 'fieldName'
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then match response.errors[0].message == 'Tag id does not exists'
		
		And karate.log('Test Completed !')
		

	# REV2-10607
	Scenario: GET - Validate Tag Agent with Edit permission cannot fetch tag relation history for invalid tagId
					
		* def tagId = "tag-auto-xyz3"
		
		Given path '/history'
		And param tagId = tagId
		And param sortParam = 'fieldName'
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then assert response.errors[0].message == "Tag id does not exists"
		
		And karate.log('Test Completed !')
