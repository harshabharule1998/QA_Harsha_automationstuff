Feature: Tag Master History feature for Tag Agent with Only View permission

	Background: 
		Given url backOfficeAPIBaseUrl
		And header Accept = 'application/json'
		And path '/galleria/v1'
		* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgentView"}
    * def authToken = loginResult.accessToken
    
    * header Authorization = authToken
	
	
	@Regression
	# REV2-10638
	Scenario: Validate Tag Agent with Only View permission can fetch history for valid tagId
	
		* def tagId = "tag-auto-09413456"
		
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
		
	
	# REV2-10639
	Scenario: Validate Tag Agent with Only View permission cannot fetch history for invalid tagId
	
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
		

	# REV2-10640	
	Scenario: Validate error message for Tag Agent with Only View permission to fetch tag history with unsupported method
		
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