Feature: Party Search API Scenarios for view only user

	Background: 
  
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path 'pawri/v1/parties/search'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyViewOnly"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def partyId = 'P_00177'
    * def partyType = "Individual"
    * def partyName = "ram"
    * def loginId = "test@cybage.com"
    * def contactPhoneNumber = "0918764562341"
    * def contactEmailId = "test@cybage.com"
    

  #REV2-12002 and REV2-12007
	Scenario: GET - Verify view only user able to search party with valid partyId
	
    Given param page = 0
    And param partyId = partyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].id == partyId
    And match response.data[0].partyType == partyType
    
    And karate.log('Test Completed !')
     
  
  #REV2-12003
	Scenario: GET - Verify view only user able to search party with valid contactEmailId and mandatory partyType
		
    Given param page = 0
    And param contactEmailId = contactEmailId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].contacts[*].email contains contactEmailId
    And match response.data[0].partyType == "Individual"
    
    And karate.log('Test Completed !')
    
  
  #REV2-12004
	Scenario: GET - Verify view only user able to search party with valid contactPhoneNumber and mandatory partyType
		
    Given param page = 0
    And param contactPhoneNumber = contactPhoneNumber
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].contacts[*].phone contains contactPhoneNumber
    And match response.data[0].partyType == "Individual"
    
    And karate.log('Test Completed !')
    
  
  #REV2-12005
	Scenario: GET - Verify view only user able to search party with valid loginId and mandatory partyType
				
    Given param page = 0
    And param loginId = loginId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].loginIds contains loginId
    And match response.data[0].partyType == "Individual"
    
    And karate.log('Test Completed !')
    
  
  #REV2-12008
	Scenario: GET - Verify view only user able to search party with valid partyName and mandatory partyType
		
    Given param page = 0
    And param partyName = partyName
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].name == partyName
    And match response.data[0].partyType == "Individual"
    
    And karate.log('Test Completed !')
  
            
  #REV2-12006 and REV2-12009
	Scenario: GET - Verify page and size for view only user to search party 
	
    Given param page = 0
    And param partyId = partyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.total > 0
    And match response.currentPage == 0

    
	#REV2-12010
	Scenario: GET - Verify pagination for view only user to search party 
	
    Given param page = 0
    And param partyId = partyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.totalPages > 0
    And match response.currentPage == 0
    
