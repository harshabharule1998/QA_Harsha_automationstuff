Feature: Party Search API Scenarios for super admin

	Background: 
  
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path 'pawri/v1/parties/search'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partyAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    * def partyId = 'P_00177'
    * def invalidPartyId = 'P_00XX7'
    
    * def partyType = "Individual"
    * def invalidPartyType = "Single"
    
    * def partyName = "ram"
    * def invalidPartyName = "abc"
    
    * def loginId = "test@cybage.com"
    * def invalidLoginId = "abc@xyz.com"
    
    * def contactPhoneNumber = "0918764562341"
    * def invalidContactPhoneNumber = "02341"
    
    * def contactEmailId = "test@cybage.com"
    * def invalidContactEmailId = "abc@xyz.com"
    

  #REV2-17821
	Scenario: GET - Verify Super Admin unable to search party with invalid partyType
		
    Given param page = 0
    And param partyId = partyId
    And param partyType = invalidPartyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

  #REV2-17822
	Scenario: GET - Verify Super Admin unable to search party with blank partyType
		
		* def blankPartyType = ""
		
    Given param page = 0
    And param partyId = partyId
    And param partyType = blankPartyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Please provide required search parameters"
    
    And karate.log('Test Completed !')
    

  #REV2-17823
	Scenario: GET - Verify Super Admin able to search party with leading and trailing spaces in partyType
		
		* def partyTypeWithSpaces = " Individual "
		
    Given param page = 0
    And param partyId = partyId
    And param partyType = partyTypeWithSpaces
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].id == partyId
    And match response.data[0].partyType == "Individual"
    
    And karate.log('Test Completed !')
    

  #REV2-17824
	Scenario: GET - Verify Super Admin unable to search party with not allowed characters in partyType
		
		* def partyTypeWithInvalidChar = "@#$%"
		
    Given param page = 0
    And param partyId = partyId
    And param partyType = partyTypeWithInvalidChar
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    
    
	#REV2-17825
	Scenario: GET - Verify Super Admin unable to search party with invalid partyId and valid partyType
		
    Given param page = 0
    And param partyId = invalidPartyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

  #REV2-17826
	Scenario: GET - Verify Super Admin unable to search party with blank partyId and valid partyType
		
		* def blankPartyId = ""
		
    Given param page = 0
    And param partyId = blankPartyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Please provide required search parameters"
    
    And karate.log('Test Completed !')
    

  #REV2-17827
	Scenario: GET - Verify Super Admin able to search party with leading and trailing spaces in partyId and valid partyType
		
		* def partyIdWithSpaces = " " + partyId + " "
		
    Given param page = 0
    And param partyId = partyIdWithSpaces
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.data[0].id == partyId
    And match response.data[0].partyType == "Individual"
    
    And karate.log('Test Completed !')
    

  #REV2-17828
	Scenario: GET - Verify Super Admin unable to search party with not allowed characters in partyId and valid partyType
		
		* def partyIdWithInvalidChar = "@#$%"
		
    Given param page = 0
    And param partyId = partyIdWithInvalidChar
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')

	
	#REV2-17829
	Scenario: GET - Verify Super Admin unable to search party with invalid partyName and valid partyType
		
    Given param page = 0
    And param partyName = invalidPartyName
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

  #REV2-17830
	Scenario: GET - Verify Super Admin unable to search party with blank partyName and valid partyType
		
		* def blankPartyName = ""
		
    Given param page = 0
    And param partyName = blankPartyName
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Please provide required search parameters"
    
    And karate.log('Test Completed !')
    

  #REV2-17831
	Scenario: GET - Verify Super Admin able to search party with leading and trailing spaces in partyName and valid partyType
		
		* def partyNameWithSpaces = " " + partyName + " "
		
    Given param page = 0
    And param partyName = partyNameWithSpaces
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
    

  #REV2-17832
	Scenario: GET - Verify Super Admin unable to search party with not allowed characters in partyName and valid partyType
		
		* def partyNameWithInvalidChar = "@#$%"
		
    Given param page = 0
    And param partyName = partyNameWithInvalidChar
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    
    
	#REV2-17833
	Scenario: GET - Verify Super Admin unable to search party with invalid loginId and valid partyType
		
    Given param page = 0
    And param loginId = invalidLoginId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

  #REV2-17834
	Scenario: GET - Verify Super Admin unable to search party with blank loginId and valid partyType
		
		* def blankLoginId = ""
		
    Given param page = 0
    And param loginId = blankLoginId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Please provide required search parameters"
    
    And karate.log('Test Completed !')
    

  #REV2-17835
	Scenario: GET - Verify Super Admin able to search party with leading and trailing spaces in loginId and valid partyType
		
		* def loginIdWithSpaces = " " + loginId + " "
		
    Given param page = 0
    And param loginId = loginIdWithSpaces
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
    

  #REV2-17836
	Scenario: GET - Verify Super Admin unable to search party with not allowed characters in loginId and valid partyType
		
		* def loginIdWithInvalidChar = "@#$%"
		
    Given param page = 0
    And param loginId = loginIdWithInvalidChar
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

	#REV2-17837
	Scenario: GET - Verify Super Admin unable to search party with invalid contactPhoneNumber and valid partyType
		
    Given param page = 0
    And param contactPhoneNumber = invalidContactPhoneNumber
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

  #REV2-17838
	Scenario: GET - Verify Super Admin unable to search party with blank contactPhoneNumber and valid partyType
		
		* def blankContactPhoneNumber = ""
		
    Given param page = 0
    And param contactPhoneNumber = blankContactPhoneNumber
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Please provide required search parameters"
    
    And karate.log('Test Completed !')
    

  #REV2-17839
	Scenario: GET - Verify Super Admin able to search party with leading and trailing spaces in contactPhoneNumber and valid partyType
		
		* def contactPhoneNumberWithSpaces = " " + contactPhoneNumber + " "
		
    Given param page = 0
    And param contactPhoneNumber = contactPhoneNumberWithSpaces
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
    

  #REV2-17840
	Scenario: GET - Verify Super Admin unable to search party with not allowed characters in contactPhoneNumber and valid partyType
		
		* def contactPhoneNumberWithInvalidChar = "@#$%"
		
    Given param page = 0
    And param contactPhoneNumber = contactPhoneNumberWithInvalidChar
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    
   
	#REV2-17841
	Scenario: GET - Verify Super Admin unable to search party with invalid contactEmailId and valid partyType
		
    Given param page = 0
    And param contactEmailId = invalidContactEmailId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    

  #REV2-17842
	Scenario: GET - Verify Super Admin unable to search party with blank contactEmailId and valid partyType
		
		* def blankContactEmailId = ""
		
    Given param page = 0
    And param contactEmailId = blankContactEmailId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Please provide required search parameters"
    
    And karate.log('Test Completed !')
    

  #REV2-17843
	Scenario: GET - Verify Super Admin able to search party with leading and trailing spaces in contactEmailId and valid partyType
		
		* def contactEmailIdWithSpaces = " " + contactEmailId + " "
		
    Given param page = 0
    And param contactEmailId = contactEmailIdWithSpaces
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
    

  #REV2-17844
	Scenario: GET - Verify Super Admin unable to search party with not allowed characters in contactEmailId and valid partyType
		
		* def contactEmailIdWithInvalidChar = "@#$%"
		
    Given param page = 0
    And param contactEmailId = contactEmailIdWithInvalidChar
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    
	
	#REV2-12015
	Scenario: GET - Verify 405 error for Super Admin unable to search party with unsupported method
		
		Given request {}
    And param page = 0
    And param partyId = partyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method post
    Then status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    
    And karate.log('Test Completed !')
    
  

	#REV2-12018
	Scenario: GET - Verify 404 error for Super Admin unable to search party with invalid endpoint
		
		Given path '/user'
    And param page = 0
    And param partyId = partyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 404
    And karate.log('Status : 404')
    
    And karate.log('Test Completed !')
    

	#REV2-12019
	Scenario: GET - Verify 400 error for Super Admin unable to search party with bad request
		
    Given param page = "abc"
    And param partyId = partyId
    And param partyType = partyType
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 400
    And karate.log('Status : 400')
    
    And karate.log('Test Completed !')
    
  
  #REV2-12020
	Scenario: GET - Verify no result found for Super Admin to search party with invalid partyType
		
    Given param page = 0
    And param partyId = partyId
    And param partyType = "test"
    And param size = 10
    And param sortParam = "id:asc"
    And param status = true
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.total == 0
    
    And karate.log('Test Completed !')
    
            
	#REV2-12021 and REV2-12023
	Scenario: GET - Verify Super Admin able to search party with valid default values
	
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
    

	#REV2-12022
	Scenario: GET - Verify Super Admin able to search party with partial partyName
		
		* def partialPartyName = "ra"
		
    Given param page = 0
    And param partyName = partialPartyName
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