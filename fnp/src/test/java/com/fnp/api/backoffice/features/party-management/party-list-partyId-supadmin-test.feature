Feature: GET API test for list of parties with partyID scenarios

  Background: 
		Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1/parties'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
   
	#REV2-12035
	Scenario: GET - Verify API Response for PartyId Using Unsupported method
    
		* def partyId = 'P_01013'
    * def requestPayload = {}
    
		Given path '/' + partyId
		When request requestPayload
    Then method patch
    And status 405
    And karate.log('Status : 405')
    And match response.errors[0].message contains "Unsupported request Method"
    And karate.log('Test Completed !')
    
    
	#REV2-12034
  Scenario: GET - Verify API Response for PartyId with Invalid URL endpoint
    
    * def partyId = 'P_01013'
    
    Given path '/xyz' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].errorCode contains "NOT_FOUND"
    And karate.log('Test Completed !')
     
   
	#REV2-12033
  Scenario: GET - Verify API response for partyType as Organization and Invalid PartyId with leading and trailing spaces
    
     * def partyId = '  C_00895  '
    
    Given path '/' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "party.id.not_found"
   
    
	#REV2-12032
  Scenario: GET - Verify API response for partyType as Organization and Invalid PartyId with Not allowed values
    
		* def partyId = '$@C_008'
    
    Given path '/' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "party.id.not_found"
    
  
	#REV2-12031
  Scenario: GET - Verify API response for partyType as Organization and blank value in PartyId
    
    * def partyId = ' '
    
    Given path '/' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "party.id.not_found"
    
     
	#REV2-12030
  Scenario: GET - Verify API response for partyType as Organization and Valid PartyId
     
     * def partyId = 'C_00895'
    
		Given path '/' + partyId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log(' Records found : ', response)
    And match $.partyType == "Organization" 
    And karate.log('Test Completed !')
    
   
	#REV2-12029
 	Scenario: GET - Verify API response for partyType as Individual and Invalid partyId with leading and trailing spaces
     
     * def partyId = '  P_00973  '
    
		Given path '/' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].errorCode contains "NOT_FOUND"
    And match response.errors[0].message contains "party.id.not_found"
      
   
	#REV2-12028
	Scenario: GET - Verify API response for partyType as Individual and Invalid PartyId with Not allowed values
    
		* def partyId = '$##$P_00'
    
    Given path '/' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "party.id.not_found"
    
   
	#REV2-12027
	Scenario: GET - Verify API response for partyType as Individual blank value in PartyId
     
		* def partyId = ' '
    
    Given path '/' + partyId
    When method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "party.id.not_found"
    
   
	#REV2-12026
	Scenario: GET - Verify API response for partyType as Individual and Valid PartyId
    
		* def partyId = 'P_00973'
    
		Given path '/' + partyId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log(' Records found : ', response)
    And match $.partyType == "Individual" 
    And karate.log('Test Completed !')
    
    