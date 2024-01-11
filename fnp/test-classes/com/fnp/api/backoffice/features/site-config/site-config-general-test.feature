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
    * def siteId = 'fnp.sg'
    * def testEmail = num + '@fnpAutomation.com'
   
    
  @createGeneralSiteId
  Scenario: POST - Create general siteID for site configuration
    * def siteId = __arg.siteId
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' + testEmail
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    
    * karate.log(requestPayload)
    Given path '/sites/generalEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.id == siteId
    And match response.params.generalContact.contentType == "Email"
    And match response.params.generalContact.generalContactEmailTemplate == "Testqa"
    And karate.log('General siteID created successfully')
  
  
  @delteGeneralsiteID
  Scenario: DELETE - Delete general siteID for site configuration
    * def siteId = __arg.siteId
    * karate.log('Deleting general siteID for site configuration : ', siteId)
    Given path '/sites/generalEmail/'+siteId+'/'
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "General Email deleted successfully"
    And karate.log('General siteID Deleted successfully')  
    
   
   @Regression
   #REV2-3645
   Scenario: GET - Validate for general request for all sites
     Given path '/sites/generalEmail'
     And param header = 'customerService'
		 And param page = 0
		 And param size = 10
		 And param sortParam = 'id:asc'
     When method get
     And karate.log('Response is:', response.message)
     Then status 200
     And karate.log('Status : 200')
     And assert response.data.length >= 0
     And karate.log('Test Completed !') 
   
    
   @Regression
   #REV2-3646
   Scenario: GET - Validate  general for Specific Valid Site ID
     
     * def siteId = 'fnp.sg'
     Given path 'sites/generalEmail/' + siteId + '/'
     When method get
     And karate.log('Response is:', response.message)
     Then status 200
     And karate.log('Status : 200')
     And match response.id == siteId

     
   #REV2-3647
   Scenario: GET - Validate general for Specific InValid Site ID
    * def invalidSiteId = 'siteId'+ num
     Given path '/sites/generalEmail/' + invalidSiteId + '/'
     When method get
     And karate.log('Response is:', response.errors[0].message)
     Then status 400
     And karate.log('Status : 400')
     And match response.errors[0].message == "Id does not exist"
   
   
   #REV2-3648
   Scenario: GET - Validate general for Specific Blank Site ID
     Given path '/sites/generalEmail/' + " " + '/'
     When method get
     And karate.log('Response is:', response.errors[0].message)
     Then status 400
     And karate.log('Status : 400')
     And match response.errors[0].message == "Id must not be blank"
  

   @Regression
   #@performanceData
   #REV2-3649 and REV2-3652 valid values in all parameters
   Scenario: POST - Validate for Valid Site ID
   
    * def siteId = 'fnp.uk'
    #Create generalsiteID
    * call read('./site-config-general-test.feature@createGeneralSiteId') {siteId: "#(siteId)"}
    
    #delete general site
    And karate.log('Deleting general siteID')
    * call read('.//site-config-general-test.feature@delteGeneralsiteID') {siteId: "#(siteId)"}
     
   
   #REV2-3650
   Scenario: POST- Validate for InValid Site ID
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' + testEmail
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And param id = 'invalid@@@@@@'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Id does not exist"
    And karate.log('Test Completed !')
   
    
   #REV2-3651
   Scenario: POST - Validate for Blank Site ID
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' + testEmail
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And param id = ' '
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
   
   
   #REV2-3657
   Scenario: POST - Validate for Blank values in all parameters
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = ' '
    * eval requestPayload.senderEmail = ' ' 
    * eval requestPayload.senderName =' '
    * eval requestPayload.replyTo = ' ' 
    * eval requestPayload.cc = ' '
    * eval requestPayload.bcc =' '
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Subject should not be empty"
    And karate.log('Test Completed !')
   
   
   @Regression
   #REV2-3686 and REV2-3689
   Scenario: PUT - Validate for valid values in all parameter and valid SiteID
    #Create generalsiteID
    * def siteId = 'fnp.sg'
    
    * def putRequestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    
    * eval putRequestPayload.subject = "Subject to Test " + updatedNum
    * eval putRequestPayload.senderEmail = 'sender' + updatedNum + testEmail
    * eval putRequestPayload.replyTo = 'reply' + updatedNum + testEmail
    * eval putRequestPayload.cc = 'cc' + updatedNum + testEmail
    * eval putRequestPayload.bcc ='bcc' + updatedNum + testEmail
    
    Given path '/sites/generalEmail/' + siteId + '/'
    And request putRequestPayload
    And karate.log('Request payload is:', putRequestPayload)
    When method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message contains "General Email updated successfully"
    
    #delete general site
    And karate.log('Deleting general siteID')
    * call read('./site-config-general-test.feature@delteGeneralsiteID') {siteId: "#(siteId)"}
    And karate.log('Test Completed !')
    
 	 
   #REV2-3688
   Scenario: PUT -  Validate for duplicate values with space
    
    #Create generalsiteID
    * def siteId = 'fnp.sg'  
    * eval requestPayload.subject = " " + putRequestPayload.subject + " "
    * eval requestPayload.senderEmail = " " + putRequestPayload.senderEmail + " "
    * eval requestPayload.replyTo = " " + putRequestPayload.replyTo + " "
    * eval requestPayload.cc = " " + putRequestPayload.cc + " "
    * eval requestPayload.bcc = " " + putRequestPayload.bcc + " "
    
    Given path '/sites/generalEmail/'+siteId+'/'
    And request putRequestPayload
    And karate.log('Request payload is:', putRequestPayload)
    When method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message contains "General Email updated successfully"
  
    #delete general site
    And karate.log('Deleting general siteID')
    * call read('.//site-config-general-test.feature@delteGeneralsiteID') {siteId: "#(siteId)"}
    And karate.log('Test Completed !')
    
   
   #REV2-3687
   Scenario: PUT - Validate general siteID  for Invalid Site ID
   
    * def putRequestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval putRequestPayload.subject = "Subject to Test " + updatedNum
    * eval putRequestPayload.senderEmail = 'sender' + updatedNum + testEmail
    * eval putRequestPayload.replyTo = 'reply' + updatedNum + testEmail
    * eval putRequestPayload.cc = 'cc' + updatedNum + testEmail
    * eval putRequestPayload.bcc ='bcc' + updatedNum + testEmail
    
    * def invalidSiteId = "siteId" + num
    Given path '/sites/generalEmail/' + invalidSiteId + '/'
    And request putRequestPayload
    And karate.log('Request payload is:', putRequestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Id does not exist"
    And karate.log('Test Completed !')
   
      
   #REV2-3690
   Scenario: DELETE - Validate  for for Valid Site ID
   
    #Create generalsiteID
    * call read('./site-config-general-test.feature@createGeneralSiteId') {siteId: "#(siteId)"}
    
    #delete general site
    And karate.log('Deleting general siteID')
    * call read('./site-config-general-test.feature@delteGeneralsiteID') {siteId: "#(siteId)"}
    
    And karate.log('Test Completed !')
   
   
   #REV2-3691
   Scenario: DELETE - Validate for InValid Site ID
   
   * def invalidSiteId = 'siteId' + num
    * karate.log('Deleting invalid general siteID for site configuration : ', siteId)
    Given path '/sites/generalEmail/' + invalidSiteId + '/'
    When method delete
    And karate.log('Response is:', response)
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Id does not exist"
    And karate.log('Test Completed !')
   
   
   #REV2-3692
   Scenario: DELETE - Validate for Blank Site ID
    * karate.log('Deleting invalid general siteID for site configuration : ', siteId)
    Given path '/sites/generalEmail/' + " "  + '/'
    When method delete
    And karate.log('Response is:', response)
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
   
   
   #REV2-3693
   Scenario: DELETE - Validate for Invalid value for endpoint parameters

    Given path '/sites/generalEmail7/' + siteId + '/'
    When method delete
    And karate.log('Response is:', response)
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "not.found"
    And karate.log('Test Completed !')
   
   
   #REV2-3694
   Scenario: DELETE - Validate for Invalid path parameters
     Given path '/sites/generalEmail/'+siteId+'/'
     When method delete
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response)
     And match response.errors[0].message contains "Id does not exist"
     And karate.log('Test Completed !') 
   
  
   #REV2-3695
   Scenario: HEAD - Validate for Unsupported methods for endpoints
     Given path '/sites/generalEmail/'+siteId+'/'
     When method head
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Test Completed !')
   
   
   #REV2-3696
   Scenario: DELETE - Validate DELETE for Invalid authorization token
    
     Given path '/sites/generalEmail/' + siteId + '/'
     * header Authorization = 'sfsdfgjsfgsgjsajfkskajgjsaf'
     When method delete
     Then status 401
     And karate.log('Status : 401')
     And karate.log('Response is:', response)
     And match response.errors[0].message == "Token Invalid! Authentication Required"
     And karate.log('Test Completed !')
   
   
   #REV2-3673
   Scenario: POST - Invalid value for "customerService - replyTo" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Customerservice'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Enter a valid Email"
	  And match response.errors[*].field contains "replyTo"
    And karate.log('Test Completed !')
    
	
	
   #REV2-3672
   Scenario: POST - Invalid value for "customerService - Subject" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = '@$%&'
    * eval requestPayload.senderEmail = 'XYS@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Customerservice'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !') 
  
   
   #REV2-3671
   Scenario: POST - POST - Invalid value for "customerService - SenderEmail" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'XYSs' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Customerservice'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Enter a valid Email"
	  And match response.errors[*].field contains "senderEmail"
    And karate.log('Test Completed !')
    
    
   
   #REV2-3670
   Scenario: POST - Invalid value for "customerService - SenderName" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'XYS@fnp.com' 
    * eval requestPayload.senderName ='$%^&'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Customerservice'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Please provide valid input for Sender Name"
	  And match response.errors[*].field contains "senderName"
    And karate.log('Test Completed !')
	
	
  
   #REV2-3667
   Scenario: POST - Invalid value for "Generalcontact - template" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk'
	  * eval requestPayload.header ='Generalcontact'
	  * eval requestPayload.template ='%^&'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Please provide valid input for Template"
	  And match response.errors[*].field contains "template"
    And karate.log('Test Completed !') 


   #REV2-3665
   Scenario: POST - Invalid value for "Generalcontact - isEnabled" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
	  * eval requestPayload.isEnabled == "trr"
    * karate.log(requestPayload) 
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
	  And match response.errors[*].message contains "Id already exist"
    And karate.log('Test Completed !')   

  
   #REV2-3664
   Scenario: POST - Invalid value for "Generalcontact - contentType" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
	* eval requestPayload.contentType = '%^&'
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')   

	

   #REV2-3663
   Scenario: POST - Invalid value for "Generalcontact - BCC" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Enter a valid Email"
	  And match response.errors[*].field contains "bcc"
    And karate.log('Test Completed !') 
 
 
   
   #REV2-3662
   Scenario: POST - Invalid value for "Generalcontact - CC" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Enter a valid Email"
	  And match response.errors[*].field contains "cc"
    And karate.log('Test Completed !') 

	
	 
   #REV2-3661
   Scenario: POST - Invalid value for "Generalcontact - replyTo" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'an@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Enter a valid Email"
	  And match response.errors[*].field contains "replyTo"
    And karate.log('Test Completed !')
    
    
   #REV2-3660
   Scenario: POST - Invalid value for "Generalcontact - Subject" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = '@$%&'
    * eval requestPayload.senderEmail = 'XYS@fnp.com' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !') 
  
  

   #REV2-3659
   Scenario: POST - POST - Invalid value for "Generalcontact - SenderEmail" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'XYSs' 
    * eval requestPayload.senderName ='manishkuma'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Enter a valid Email"
	  And match response.errors[*].field contains "senderEmail"
    And karate.log('Test Completed !')
    
    
    #REV2-3658
    Scenario: POST - Invalid value for "Generalcontact - SenderName" parameter
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'XYS@fnp.com' 
    * eval requestPayload.senderName ='$%^&'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Please provide valid input for Sender Name"
	  And match response.errors[*].field contains "senderName"
    And karate.log('Test Completed !')
   
   
  #REV2-3656 
 	Scenario: POST - Duplicate values with spaces in all parameters

	  # try to create tag request with duplicate data with spaces added
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject =  " " + requestPayload.subject + " "
    * eval requestPayload.senderEmail = " " + requestPayload.senderEmail + " "
    * eval requestPayload.senderName = " " + requestPayload.senderName + " "
    * eval requestPayload.replyTo = " " + requestPayload.replyTo + " "
    * eval requestPayload.cc = " " + requestPayload.cc + " "
    * eval requestPayload.bcc = " " + requestPayload.bcc + " "
	  * eval requestPayload.header = " " + requestPayload.header + " "
	  * eval requestPayload.template = " " + requestPayload.template + " "
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    
    
  #REV2-3655
 	Scenario: POST - Duplicate values with in all parameters

	  # try to create tag request with duplicate data with spaces added
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
	  * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = requestPayload.subject
    * eval requestPayload.senderEmail = requestPayload.senderEmail
    * eval requestPayload.senderName = requestPayload.senderName
    * eval requestPayload.replyTo = requestPayload.replyTo
    * eval requestPayload.cc = requestPayload.cc
    * eval requestPayload.bcc = requestPayload.bcc
	  * eval requestPayload.header = requestPayload.header
	  * eval requestPayload.template = requestPayload.template
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    
    
  #REV2-3653
  Scenario: POST - for Only Optional parameters
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'XYS@fnp.com' 
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    
    
  #REV2-3697
  Scenario: Verify 404 error Site configuration API
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/general.json')
    * eval requestPayload.subject = 'TestingQaTest'
    * eval requestPayload.senderEmail = 'XYS@fnp.com' 
    * eval requestPayload.senderName ='Testqa'
    * eval requestPayload.replyTo = 'Xyz@fnp.com' 
    * eval requestPayload.cc = 'manishQA@fnp.com'
    * eval requestPayload.bcc ='manishk@fnp.com'
	  * eval requestPayload.header ='Generalcontact'
    * karate.log(requestPayload)
    
    Given path '/sites/generalEmail'
    And request requestPayload
    And param id = siteId
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And karate.log('Test Completed !')
    