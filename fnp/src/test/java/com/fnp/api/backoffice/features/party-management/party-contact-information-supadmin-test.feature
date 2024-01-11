Feature: Party Contact Information scenarios

	Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/pawri/v1/partycontacts'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    
    
		#REV2-19132
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with valid partyContactId
	
			* def partyId = 'P_00170'
			* def partyContactId = 'U_01082'
					
			Given path '/' + partyId 
			And path '/' + partyContactId
 			When method get
			Then status 200
			And karate.log('Status : 200')
			And karate.log(' Records found : ', response)
    	And karate.log('Test Completed !')
    	
    		
		#REV2-19133
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with valid partyId
	
			* def partyId = 'P_00170'
			* def partyContactId = 'U_01082'		
			
			Given path '/' + partyId 
			And path '/' + partyContactId
 			When method get
			Then status 200
			And karate.log('Status : 200')
			And karate.log(' Records found : ', response)
    	And karate.log('Test Completed !')
    	
    
   	#REV2-19134
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with Invalid partyContactId
	
			* def partyId = 'P_00170'
			* def partyContactId = 'U_0108'	
				
			Given path '/' + partyId 
			And path '/' + partyContactId
			When method get
  		Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == "Contact not found"
			And karate.log('Test Completed !')
			
		
   	#REV2-19135
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with Invalid partyId
	
			* def partyId = 'P_0017'
			* def partyContactId = 'U_01082'
					
			Given path '/' + partyId 
			And path '/' + partyContactId
			When method get
  		Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].errorCode == "party.contact.not_found"
			And karate.log('Test Completed !')
			
				
		#REV2-19136
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with blank value for partyContactId
	
			* def partyId = 'P_00170'
			* def partyContactId = ' '	
				
			Given path '/' + partyId 
			And path '/' + partyContactId
			When method get
	  	Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == "Contact not found"
			And karate.log('Test Completed !')
    	
   	
    #REV2-19137
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with blank value for partyId
	
			* def partyId = ' '
			* def partyContactId = 'U_01082'
					
			Given path '/' + partyId 
			And path '/' + partyContactId
			When method get
	  	Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].errorCode == "party.contact.not_found" 
			And karate.log('Test Completed !')
			
		
		#REV2-19138
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access-blank value with trailing spaces for partyContactId. 
	
			* def partyId = 'P_00170'
			* def partyContactId = '   U_01082   '	
				
			Given path '/' + partyId 
			And path '/' + partyContactId
 			When method get
	  	Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == "Contact not found"
			And karate.log('Test Completed !')
			
		
		#REV2-19139
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- blank value with trailing spaces for partyId 
	
			* def partyId = '   P_00170   '
			* def partyContactId = 'U_01082'	
				
			Given path '/' + partyId 
			And path '/' + partyContactId
			When method get
	  	Then status 400
			And karate.log('Status : 400')
			And match response.errors[0].message == "Contact not found"
			And karate.log('Test Completed !')
			
			
		#REV2-19140
		Scenario: GET - Verify roles by PartyContactInfo for Super Admin access- with Invalid Endpoint URL
	
			* def partyId = 'P_00170'
			* def partyContactId = 'U_01082'	
				
			Given path '/test/' + partyId 
			And path '/' + partyContactId
			When method get
	  	Then status 404
			And karate.log('Status : 404')
			And match response.errors[0].message == "http.request.not.found"
			And karate.log('Test Completed !')
		
			
		#REV2-19141	
		Scenario: GET - Verify Unsupported Method for PartyContactInfo with Super Admin access 
	
			* def partyId = 'P_00170'
			* def partyContactId = 'U_01082'
			* def requestPayload = {}
			
			Given path '/' + partyId 
			And path '/' + partyContactId
			When request requestPayload
			And method patch
	  	Then status 405
			And karate.log('Status : 405')
			And match response.errors[0].message contains "Unsupported request Method"
			And karate.log('Test Completed !')
			
		
		#REV2-19142
		Scenario: GET - Verify roles by PartyContactInfo with Super Admin access- with invalid authentication
	
			* def partyId = 'P_00170'
			* def partyContactId = 'U_01082'
			* def invalidAuthToken = loginResult.accessToken+"eyJraWQiOiJmbnAyIiwiYWxnIjoiUlMyNTYifQ"
			* header Authorization = invalidAuthToken
			
			Given path '/' + partyId 
			And path '/' + partyContactId
			When method get
	  	Then status 401
			And karate.log('Status : 401')
			And karate.log('Test Completed !')
    	