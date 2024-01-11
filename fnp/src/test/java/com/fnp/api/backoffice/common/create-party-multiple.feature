Feature: Create multiple new users
	
	Background:
	
		* url 'https://feature-revvit2.fnp.com'
	 	* header Accept = 'application/json'
	 	* def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"partySuperAdmin"}
		* def authToken = loginResult.accessToken
		* header Authorization = authToken
	

	Scenario Outline: given id, validate email from same feature file
		
		* def userName = '<user>'
	  * def userEmail = '<email>'
	  * def securityGroup = '<security_group>'
	  * def phone = '<phone>'
	  
	  * karate.log('Name : ', userName)
	  * karate.log('Email : ', userEmail)
	  * karate.log('Security group : ', securityGroup)
	  * karate.log('Phone : ', phone)
	  
	  * def result = call read('./create-party-multiple.feature@createParty') {name: "#(userName)", email: "#(userEmail)", securityGroup: "#(securityGroup)", phone: "#(phone)"}

  Examples:
   | read('classpath:com/fnp/api/backoffice/data/party.csv')|
   
 
 	@createParty
	Scenario: create new user and assign security group
	
		* def userName = __arg.name
	  * def userEmail = __arg.email
	  * def securityGroup = __arg.securityGroup
	  * def phone = __arg.phone
	 	
	 	* def party =
      """
      {
			    "classifications": [
			        "U_00001"
			    ],
			    "contactEmail": "techuser@fnp.com",
			    "contactPhone": "9052206677",
			    "dateOfAnniversary": "2021-07-22T05:16:53",
			    "dateOfBirth": "2021-07-22T05:16:53",
			    "gender": "Male",
			    "isPrimaryRole": false,
			    "loginEmailId": "#(userEmail)",
			    "loginPhoneNumber": "#(phone)",
			    "name": "#(userName)",
			    "notAvailable": false,
			    "otherRoles": [],
			    "partyType": "S_70001",
			    "role": "S_00301",
			    "taxNumber": "12345",
			    "title": "Mr"
			}
      """
      
    * def sgList = securityGroup.split(',')
		* karate.log('sgList : ', sgList)
		
		# convert array to json
		* json securityGroupList = sgList
		* karate.log('securityGroupList : ', securityGroupList)
		
		* karate.log('PARTY : ', party)
		
		# create party
				            
		Given path '/pawri/v1/parties'
		And request party
		When method post
		Then status 200
		And karate.log('Status : 200')
		And karate.log('Party created successfully')
		
		* def partyId = response.partyId
		
		# get party login id
		
		* header Authorization = authToken
		Given path '/simsim/v1/logins'
		And param partyId = partyId
		When method get
		Then status 200
		And karate.log('Status : 200')
		And match response.data[1].loginName == userEmail
		
		* def partyLoginId = response.data[1].id
		
		# assign security group to party login
		
		* header Authorization = authToken
		Given path '/simsim/v1/partyLogin/' + partyLoginId + '/securityGroups'
		And request securityGroupList
		When method put
		Then status 200
		And karate.log('Status : 200')
		And match sgList contains response[0].id