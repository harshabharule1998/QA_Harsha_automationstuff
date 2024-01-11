Feature: Tag Master History feature for Tag Agent with Edit permission

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgent"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	
		
	@Regression
	# REV2-10632
	Scenario: Validate Tag Agent with Edit permission can fetch history for valid tagId
	
		* def tagId = "tag-auto-0941"
		
		* def statusOld = null
		* def sequenceOld = null
		
		* def statusNew = true
		* def sequenceNew = 1
	
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
		
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "isEnabled", fieldOldValue: "#(statusOld)", fieldNewValue: "#(statusNew)", history: "#(historyResponse)", action: "CREATE" }
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "sequence", fieldOldValue: "#(sequenceOld)", fieldNewValue: "#(sequenceNew)", history: "#(historyResponse)", action: "CREATE" }
		
		* karate.log('Test Completed !')
		
	
	# REV2-10633
	Scenario: Validate Tag Agent with Edit permission cannot fetch history for invalid tagId
	
		* def tagId = "tag-auto-axzd"
	
		# fetch tag history
		Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
 	
		When method get
		Then status 400
		And karate.log('Status: 400')
		And match response.errors[0].message == "Tag id does not exists"
		
		* karate.log('Test Completed !')
	
		
	@Regression
	# REV2-10634
	Scenario: Validate Tag Agent with Edit permission can fetch history for Tag after create
	
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
	# REV2-10635
	Scenario: Validate Tag Agent with Edit permission can fetch history for Tag after edit
	
		* def tagId = "tag-auto-0941"
		* def statusOld = true
		* def sequenceOld = 1
		
		# Update isEnabled and sequence
		
		* def statusNew = false
		* def sequenceNew = 123
		
		# fetch tag history
		
		Given path '/tags/history'
    And param size = 10
    And param sortParam = 'newValue:asc'
    And param tagId = tagId
    And param fromDate = '2021-03-26T11:22:33'
    And param toDate = '2022-04-07T11:22:33'
    		
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		* def historyResponse = response
		
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "isEnabled", fieldOldValue: "#(statusOld)", fieldNewValue: "#(statusNew)", history: "#(historyResponse)", action: "UPDATE" }
		* call read('./tag-history-manager-test.feature@validateTagHistory') {fieldName: "sequence", fieldOldValue: "#(sequenceOld)", fieldNewValue: "#(sequenceNew)", history: "#(historyResponse)", action: "UPDATE" }
			
		* karate.log('Test Completed !')

	
	# REV2-10636	
	Scenario: Validate error message for Tag Agent with Edit permission to fetch tag history with unsupported method
		
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