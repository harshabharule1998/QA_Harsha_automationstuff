Feature: Tag Master History feature for Tag Manager

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagManager"}
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
    * def filt = function(x){ return x.fieldName == fieldName && x.action == action }
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
	# REV2-10625
	Scenario: Validate Tag Manager can fetch history for valid tagId after update
	
		* def tagId = "tag-auto-0941"
	
		# fetch tag history
		* header Authorization = authToken
		Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
 	
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		* def historyResponse = response
		
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "isEnabled", fieldOldValue: true, fieldNewValue: false, history: "#(historyResponse)", action: "UPDATE" }
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "sequence", fieldOldValue: 1, fieldNewValue: 123, history: "#(historyResponse)", action: "UPDATE" }
		
		* karate.log('Test Completed !')

		
	@Regression
	# REV2-10627
	Scenario: Validate Tag Manager can fetch history for valid tagId after create
		
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
		
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "isEnabled", fieldOldValue: "#(statusOld)", fieldNewValue: "#(statusNew)", history: "#(historyResponse)", action: "CREATE" }
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "sequence", fieldOldValue: "#(sequenceOld)", fieldNewValue: "#(sequenceNew)", history: "#(historyResponse)", action: "CREATE" }
				
		* karate.log('Test Completed !')
		
	@Regression	
	# REV2-10626
	Scenario: Validate Tag Manager cannot fetch history for invalid tagId
	
		* def tagId = "tag-auto-axzd"
	
		# fetch tag history
		* header Authorization = authToken
		Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
 	
		When method get
		Then status 400
		And karate.log('Status: 400')
		And match response.errors[0].message == "Tag id does not exists"
		
		* karate.log('Test Completed !')
		
	
	#@Regression
	# REV2-10629
	Scenario: Validate Tag Manager cannot fetch history for Tag after delete
	
		* def result = call read('../../common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
		* def tagId = result.requestPayload.tagName
				
		* karate.log('Deleting created tag')
		* call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
		* karate.log('Tag is Deleted: ', tagId)
		
		# fetch tag history
		Given path '/tags/history'
    And param size = 10
    #And param simpleSearchValue = 'sequence'
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
    And param fromDate = '2021-03-26T11:22:33'
    And param toDate = '2022-04-07T11:22:33'
    	
		When method get
		Then status 400
		And karate.log('Status: 400')
		And match response.errors[0].message == "Tag id does not exists"
		
		* karate.log('Test Completed !')
		

	# REV2-10630	
	Scenario: Validate error message for Tag Manager to fetch tag history with unsupported method
		
		* def tagId = "tag-auto-30747"
		* def requestPayload =
			"""
				{
					
				}
			"""
		
    Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
    And param fromDate = '2021-03-26T11:22:33'
    And param toDate = '2022-04-07T11:22:33'
    
    And request requestPayload
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
		
		* karate.log('Test Completed !')