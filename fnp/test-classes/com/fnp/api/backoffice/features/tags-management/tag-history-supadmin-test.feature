Feature: Create tag, edit, delete and disable it.

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	
	@validateTagHistory		
	Scenario: Validate history for updated tag
		
		* def fieldName = __arg.fieldName
		* def fieldOldValue = __arg.fieldOldValue
		* def fieldNewValue = __arg.fieldNewValue
		* def historyResponse = __arg.history
		* def action = __arg.action
		
		# filter history response to get objects by field name   
    * def filt = function(x){ return x.fieldName == fieldName  && x.action == action }
    * def items = get historyResponse.data[*]
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
		
		And karate.log('Expected fieldName .... ', fieldName)
		And karate.log('Expected fieldOldValue .... ', fieldOldValue)
		And karate.log('Expected fieldNewValue .... ', fieldNewValue)
		
		* eval responseFieldName = res[0].fieldName
		* eval responseFieldOldValue = res[0].oldValue
		* eval responseFieldNewValue = res[0].newValue
		
		And karate.log('Actual responseFieldName .... ', responseFieldName)
		And karate.log('Actual responseFieldOldValue .... ', responseFieldOldValue)
		And karate.log('Actual responseFieldNewValue .... ', responseFieldNewValue)
		
		And match responseFieldName == fieldName
		And match responseFieldOldValue == fieldOldValue
		And match responseFieldNewValue == fieldNewValue
		
		And karate.log(fieldName, ' history validated')
		
	@Regression
	#@performanceData
	Scenario: Validate user can fetch history for valid tagId after update
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.requestPayload.tagName
		* def statusOld = true
		* def sequenceOld = result.requestPayload.sequence
		
		# Update isEnabled and sequence
		
		* def statusNew = false
		* def sequenceNew = 2
		
		* eval result.requestPayload.sequence = sequenceNew
		* eval result.requestPayload.isEnabled = statusNew
		* karate.log(result.requestPayload)	
		
		Given path '/tags'
		And param tagId = tagId
		And request result.requestPayload
		When method put
		Then status 202
		
		# fetch tag history
		* header Authorization = authToken
		Given path '/galleria/v1/tags/history'
    And param size = 10
    #And param simpleSearchValue = 'sequence'
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
    And param fromDate = '2021-03-26T01:22:33'
    And param toDate = '2022-04-07T01:22:33'
    
		
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		* def historyResponse = response
		
		* call read('./tag-history-supadmin-test.feature@validateTagHistory') {fieldName: "isEnabled", fieldOldValue: "#(statusOld)", fieldNewValue: "#(statusNew)", history: "#(historyResponse)", action: "UPDATE" }
		* call read('./tag-history-supadmin-test.feature@validateTagHistory') {fieldName: "sequence", fieldOldValue: "#(sequenceOld)", fieldNewValue: "#(sequenceNew)", history: "#(historyResponse)", action: "UPDATE" }
		
		And karate.log('Deleting created tag')
		#And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		* karate.log('Test Completed !')
	

	@Regression
	Scenario: Validate user can fetch history for valid tagId after create
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.requestPayload.tagName
		
		* def statusOld = null
		* def sequenceOld = null
		
		* def statusNew = true
		* def sequenceNew = result.requestPayload.sequence
				
		# fetch tag history
		Given path '/tags/history'
    And param size = 10
    #And param simpleSearchValue = 'sequence'
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
    And param fromDate = '2021-03-26T01:22:33'
    And param toDate = '2022-04-07T01:22:33'
    
		
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		* def historyResponse = response
		
		* call read('./tag-history-supadmin-test.feature@validateTagHistory') {fieldName: "isEnabled", fieldOldValue: "#(statusOld)", fieldNewValue: "#(statusNew)", history: "#(historyResponse)", action: "CREATE" }
		* call read('./tag-history-supadmin-test.feature@validateTagHistory') {fieldName: "sequence", fieldOldValue: "#(sequenceOld)", fieldNewValue: "#(sequenceNew)", history: "#(historyResponse)", action: "CREATE" }
		
		* karate.log('Test Completed !')
		
				 
	Scenario: Validate user get error message when fetch history without tagId
		
		Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = ''
    And param fromDate = '2021-03-26T11:22:33'
    And param toDate = '2022-04-07T11:22:33'
    
		* karate.log('Fetching history without tagId')
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then assert response.errors[0].message == "Tag id does not exists"

		* karate.log('Test Completed !')
		
	
	Scenario: Validate user get error message when fetch history with invalid tagId
		
		Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = 'tag_4666611'
    And param fromDate = '2021-03-26T11:22:33'
    And param toDate = '2022-04-07T11:22:33'
    
		* karate.log('Fetching history with invalid tagId')
		
		When method get
		Then status 400
		And karate.log('Status : 400')
		Then assert response.errors[0].message == "Tag id does not exists"

		* karate.log('Test Completed !')
		
	
	Scenario: Validate user get blank history data for valid tagId and blank params
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.requestPayload.tagName
		* def statusOld = true
		* def sequenceOld = result.requestPayload.sequence
		
		# Update isEnabled and sequence
		
		* def statusNew = false
		* def sequenceNew = 2
		
		* eval result.requestPayload.sequence = sequenceNew
		* eval result.requestPayload.isEnabled = statusNew
		* karate.log(result.requestPayload)	
		
		Given path '/tags'
		And param tagId = tagId
		And request result.requestPayload
		When method put
		Then status 202
		
		# fetch tag history
		* header Authorization = authToken
		Given path '/galleria/v1/tags/history'
    And param size = ''
    And param simpleSearchValue = ''
    And param sortParam = ''
    And param tagId = tagId
    #And param fromDate = ''
    #And param toDate = ''
    
		
		When method get
		Then status 200
		And karate.log('Status : 200')
		Then assert response.data.length > 0
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		* karate.log('Test Completed !')


	Scenario: Validate tag history by passing unsupported post call to get method
		
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.requestPayload.tagId
		
		* eval result.requestPayload.sequence = 2
		
    Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
    And param fromDate = '2021-03-26T11:22:33'
    And param toDate = '2022-04-07T11:22:33'
    
    And request result.requestPayload
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
		
		And karate.log('Deleting created tag')
		And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		And karate.log('Tag is Deleted: ', tagId)
		
		* karate.log('Test Completed !')
