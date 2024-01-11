Feature: Site Config general Super Admin CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/beautyplus/v1'

    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def updatedNum = num.substring(2)
     
    * def random_string =
 		"""
 			function(s) {
   		var text = "";
   		var possible = "abcdefghijklmnopqrstuvwxyz";
   			for (var i = 0; i < s; i++)
     			text += possible.charAt(Math.floor(Math.random() * possible.length));
   				return text;
 				}
 		"""
    
    * def randomText =  random_string(8)
    * def siteId = 'fnp.com'
    * def testEmail = num + '@fnpAutomation.com'
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-security.json')
   
  
  @Regression
  #@performanceData
  Scenario: POST - Create site security config for Valid Site ID
    * def siteId = 'fnp.com'
    #Create generalsiteSecurity
    * call read('./site-config-security-test.feature@createGeneralSiteSecurity') {siteId: "#(siteId)"}
    
    #Delete generalsiteSecurity
    * call read('./site-config-security-test.feature@deleteGeneralSiteSecurity') {siteId: "#(siteId)"}

  @Regression
  Scenario: GET - validate to get data based on Id
  
    * def siteId = 'fnp.pak'
    * karate.log('get data based on Id : ', siteId)

    Given path 'sites/security/'+ siteId + '/'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.id == siteId
    And karate.log('Test completed')
 
  @Regression
  Scenario: GET - validate to get all data
  
    * karate.log('get all data : ', siteId)

    Given path 'sites/security'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test completed')
    
 
  @Regression
  Scenario: GET - validate to expose password constraint data based on Id
  
    * def siteId = 'fnp.pak'
    * karate.log('expose password constraint data based on Id : ', siteId)

    Given path 'sites/security/passwordConstraint/'+ siteId + '/'

    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.minimumPasswordLength == 7
	  And match response.maximumPasswordLength == 9
    And karate.log('Test completed')
    
   
   @Regression
   #@performanceData
   Scenario: PUT - Create site security config for Valid Site ID
    * def siteId = 'fnp.com'
    #Create generalsiteSecurity
    * call read('./site-config-security-test.feature@createGeneralSiteSecurity') {siteId: "#(siteId)"}
	
    #Update site Security
	* karate.log('Update siteId for site configuration : ', siteId)
    * eval requestPayload.maximumPasswordLength = 10
     * eval requestPayload.minimumPasswordLength = 5
    * karate.log(requestPayload)
    Given path '/sites/security/' + siteId + '/'

    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)

    And karate.log('General site security updated successfully')
	
    #Delete generalsiteSecurity
    * call read('./site-config-security-test.feature@deleteGeneralSiteSecurity') {siteId: "#(siteId)"}
      
  @createGeneralSiteSecurity
  Scenario: POST - Create general Site Security for site configuration
    * def siteId = __arg.siteId
    * karate.log('Creating new siteId for site configuration : ', siteId)
 
    * karate.log(requestPayload)
    Given path '/sites/security'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.id == siteId
    And match response.params.lockOutTime == 23
    And karate.log('General site security created successfully')
    
  @deleteGeneralSiteSecurity
  Scenario: DELETE - Create general Site Security for site configuration
    * def siteId = __arg.siteId
    * karate.log('Deleting siteId for site configuration : ', siteId)

    Given path 'sites/security/'+ siteId + '/'

    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)

    And karate.log('Security Setting deleted successfully')  
    
    