Feature: Site Config admin email Super Admin CRUD feature

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
    * def templateId = 'templateId'+ num
    
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
    * def putRequestPayload =
      """
      {
        "bcc": "",
        "cc": "",
        "replyTo": "",
        "senderEmail": "",
        "subject": ""
      }
      """
      
  @createTemplateId
  Scenario: POST - Create TemplateId for site configuration
    * def templateId = __arg.templateId
    * karate.log('Creating new templateId for site configuration : ', templateId)
    * karate.log('Creating new __arg.templateId for site configuration : ', __arg.templateId)
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'content'+ templateId
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = 'language'+ templateId
    * eval requestPayload.templateName = 'name'+ templateId 
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('TemplateId created successfully')

  @delteTemplateId
  Scenario: DELETE - Delete TemplateId for site configuration
    * def tempId = __arg.templateId
    * karate.log('Deleting templateId for site configuration : ', tempId)
    Given path '/sites/template/'+tempId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response.message)
    And match response.message contains "Deleted successfully"
    And karate.log('TemplateId deleted successfully')

  @deleteSite
  Scenario: DELETE - Delete site for site configuration
    * def siteId = __arg.siteId
    * karate.log('Deleting site for site configuration : ', siteId)
    Given path '/sites/admin/' + siteId + '/'
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response.message)
    And match response.message contains "Admin Email deleted successfully"
    And karate.log('site deleted successfully')

  @createSiteId
  Scenario: POST - Create siteID for site configuration
    * def siteId = __arg.siteId
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' +testEmail
    * eval requestPayload.replyTo = 'reply' +testEmail
    * eval requestPayload.cc = 'cc'+ testEmail
    * eval requestPayload.bcc ='bcc'+ testEmail
    
    * karate.log(requestPayload)
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('siteID created successfully')
	
	
	@Regression
   #REV2-3594
   Scenario: PUT - Validate site admin email for valid values in all parameter
     
     * def putRequestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
     Given path '/sites/admin/' + siteId + '/'
     * eval putRequestPayload.subject = "New Subject to Test"
     * eval putRequestPayload.senderEmail = 'sender' + testEmail
     * eval putRequestPayload.replyTo = 'replynew' + testEmail
     * eval putRequestPayload.cc = 'cc' + testEmail
     * eval putRequestPayload.bcc ='bcc' + testEmail
     And request putRequestPayload
     And karate.log('Request payload is:', putRequestPayload)
     When method put
     Then status 202
     And karate.log('Status : 202')
     And karate.log('Response is:', response.message)
     And match response.message contains "Admin Email updated successfully"
     #delete site
     And karate.log('Deleting site ')
     * call read('./site-config-admin-email-test.feature@deleteSite') {siteId: "#(siteId)"}
     And karate.log('Test Completed !')
    
   
   #REV2-3593
   Scenario: PUT - Validate site admin email for values with spaces
     
     * def putRequestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
     Given path '/sites/admin/' + siteId + '  ' + '/'
     * eval putRequestPayload.subject = " Subject to Test "
     * eval putRequestPayload.senderEmail = ' sender' + testEmail
     * eval putRequestPayload.replyTo = ' reply' + testEmail
     * eval putRequestPayload.cc = ' cc' + testEmail
     * eval putRequestPayload.bcc =' bcc' + testEmail
     And request putRequestPayload
     And karate.log('Request payload is:', putRequestPayload)
     When method put
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response.message)
     And match response.errors[*].message contains "Enter a valid Email"

    
    #REV2-3592
    Scenario: PUT - Validate site admin email for invalid siteid
    * def siteId = 'siteId' + num
    * def putRequestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
     Given path '/sites/admin/'+siteId+'/'
     * eval putRequestPayload.subject = "Subject to Test"
     * eval putRequestPayload.senderEmail = 'sender' + testEmail
     * eval putRequestPayload.replyTo = 'reply' + testEmail
     * eval putRequestPayload.cc = 'cc' + testEmail
     * eval putRequestPayload.bcc ='bcc' + testEmail
     And request putRequestPayload
     And karate.log('Request payload is:', putRequestPayload)
     When method put
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response.message)
     And match response.errors[0].message contains "Id does not exist"
     And karate.log('Test Completed !')
   
   @Regression
   #REV2-3591
   Scenario: PUT - Validate site admin email for valid siteid

     * def putRequestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
     Given path '/sites/admin/' + siteId + '/'
     * eval putRequestPayload.subject = "Subject to Test"
     * eval putRequestPayload.senderEmail = 'sender' + testEmail
     * eval putRequestPayload.replyTo = 'reply' + testEmail
     * eval putRequestPayload.cc = 'cc' + testEmail
     * eval putRequestPayload.bcc ='bcc' + testEmail
     And request putRequestPayload
     And karate.log('Request payload is:', putRequestPayload)
     When method put
     Then status 202
     And karate.log('Status : 202')
     And karate.log('Response is:', response.message)
     And match response.message contains "Admin Email updated successfully"
     
     #delete site
     And karate.log('Deleting site ')
     * call read('./site-config-admin-email-test.feature@deleteSite') {siteId: "#(siteId)"}
     And karate.log('Test Completed !')
   
    
   @Regression
   #REV2-3569
   Scenario: GET - Validate for all sites for site admin email
     Given path '/sites/admin'
     And param page = 0
     And param size = 10
     And param sortParam = "id:asc"
     When method get
     And karate.log('Response is:', response.message)
      Then status 200
     And karate.log('Status : 200')
     And karate.log('Test Completed !')

   
   @Regression
   #REV2-3570
   Scenario: GET - Validate for Valid Site ID

     * def siteId = 'fnp.sg'
     Given path '/sites/admin/' + siteId + '/'
     When method get
     And karate.log('Response is:', response.message)
     Then status 200
     And karate.log('Status : 200')
     And match response.id == siteId
     
 
   #REV2-3571
   Scenario: GET - Validate for InValid Site ID
   * def siteId = 'siteId'+ num
     Given path '/sites/admin/' + siteId + '/'
     When method get
     And karate.log('Response is:', response.message)
     Then status 400
     And karate.log('Status : 400')
     And match response.errors[*].message contains "Id does not exist"


   #REV2-3572
   Scenario: GET - Validate for blank Site ID
   * def siteId = " "
     Given path '/sites/admin/'+ siteId + '/'
     When method get
     And karate.log('Response is:', response.message)
     Then status 400
     And karate.log('Status : 400')
     And match response.errors[*].message contains "Id must not be blank"
 
  
   @Regression
   #@performanceData
   #REV2-3573 and REV2-3576
   Scenario: POST - Validate for Valid Site ID and valid values in all parameter
   * def siteId = 'fnp.uk'
     #Create site
     * call read('./site-config-admin-email-test.feature@createSiteId') {siteId: "#(siteId)"}
     And karate.log('Post call sucessfully completed for Valid Site ID')
     # Delete siteID
     * call read('./site-config-admin-email-test.feature@deleteSite') {siteId: "#(siteId)"}
     And karate.log('Test Completed !')
    
     
   #REV2-3586
   Scenario: POST - Validate for invalid senderEmail field
 
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'innvalidSender'
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
  
    * karate.log(requestPayload)
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "Enter a valid Email"
    
    
   #REV2-3587
   Scenario: POST - Validate for invalid subject field
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "djaskdsafsafbh-auto"
    * eval requestPayload.senderEmail = 'senderEmail' + testEmail
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "subject must be a well-formed"
    
               
   #REV2-3583
   Scenario: POST - Validate for invalid cc field
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' + testEmail 
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'innvalidCC'
    * eval requestPayload.bcc = 'bcc' + testEmail
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "Enter a valid Email"
    
    
   #REV2-3582
   Scenario: POST - Validate for invalid bcc field
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' + testEmail 
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc'+ testEmail
    * eval requestPayload.bcc = 'innvalidbcc' 
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "Enter a valid Email"
   
   
   #REV2-3581 
   Scenario: POST - Validate for Blank values in all parameter
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = " "
    * eval requestPayload.senderEmail = ' ' 
    * eval requestPayload.senderName =' '
    * eval requestPayload.replyTo = ' ' 
    * eval requestPayload.cc = ' '
    * eval requestPayload.bcc =' '
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)  
    And match response.errors[*].message contains "Subject should not be empty"
   
   @Regression
   #REV2-3578 
   Scenario: POST - Validate for Only Required parameters
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'sender' + testEmail 
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc68367@fnpAutomation.com' 
	  * eval requestPayload.senderName ='sender'
	  
    * karate.log(requestPayload)
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
         # Delete siteID
     * call read('./site-config-admin-email-test.feature@deleteSite') {siteId: "#(siteId)"}
     And karate.log('Test Completed !')
   
   @Regression
   #REV2-3577 
   Scenario: POST - Validate for Only optional parameters
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * karate.log(requestPayload)
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    
 
   #REV2-3575
   Scenario: POST - Validate for Blank Site ID
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'senderEmail' + testEmail
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = ""
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "must not be blank"
    
    
   #REV2-3579
   Scenario: POST -Validate for Duplicate values in all parameters
   
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'senderEmail' + testEmail
    * eval requestPayload.replyTo = 'reply' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == "#notnull"
    
    #Try creating site with duplicate values 
    * header Authorization = authToken
    Given path '/beautyplus/v1/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Id already exist"
    # Delete siteID
     * call read('./site-config-admin-email-test.feature@deleteSite') {siteId: "#(siteId)"}
     And karate.log('Test Completed !')
   
 
   #REV2-3580
   Scenario: POST - Validate for Duplicate values with spaces in all parameters
    
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"  + " "
    * eval requestPayload.senderEmail = 'senderEmail' + testEmail + " "
    * eval requestPayload.replyTo = 'reply' + testEmail + " "
    * eval requestPayload.cc = 'cc' + testEmail + " "
    * eval requestPayload.bcc ='bcc' + testEmail + " "
    * karate.log(requestPayload)
    
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    
        
   #REV2-3574
   Scenario: POST - Validate for invalid siteid

    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'senderEmail' + testEmail
    * eval requestPayload.replyTo = 'reply_' + testEmail
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
    * karate.log(requestPayload)
    
    * def invalidSiteId = "siteId" + num
    Given path '/sites/admin'
    And param id = invalidSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Domain Id does not exis"
    
    
   @Regression
   #REV2-3595
   Scenario: DELETE - Validate Valid Site ID
     
     #Create site
     * call read('./site-config-admin-email-test.feature@createSiteId') {siteId: "#(siteId)"}
     And karate.log('Post call sucessfully completed for Valid Site ID')
     # Delete siteID
     * call read('./site-config-admin-email-test.feature@deleteSite') {siteId: "#(siteId)"}
     And karate.log('Test Completed !')

    
   
   #REV2-3596
   Scenario: DELETE - Validate for Invalid Site ID
     
     * def invalidSiteId = "siteId" + num
     
     Given path '/sites/admin/' + invalidSiteId + '/'
     When method delete
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response.message)
     And match response.errors[0].message contains "Id does not exist"
     And karate.log('Test Completed !')
  
  
   #REV2-3597
   Scenario: DELETE - ValidateBlank Site ID
     Given path '/sites/admin/'+ " " +'/'
     When method delete
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response)
     And match response.errors[0].message contains "must not be blank"
     And karate.log('Test Completed !')
     
  
   #REV2-3598
   Scenario: DELETE - Validate Invalid value for endpoint parameters
    
     #Create site
     Given path '/sites/admin/'+siteId
     When method delete
     Then status 404
     And karate.log('Status : 404')
     And match response.errors[*].message contains "http.request.not.found"
     And karate.log('Test Completed !')
     
   
   #REV2-3600
   Scenario: HEAD - Validate for Unsupported methods for endpoints
     Given path '/sites/admins/' + siteId + '/'
     When method head
     Then status 404
     And karate.log('Status : 404')
  
     And karate.log('Test Completed !')
   
     
   #REV2-3601
   Scenario: DELETE - Validate Invalid authorization token
     Given path '/sites/admin/' + siteId + '/'
     * header Authorization = authToken + siteId
     When method delete
     Then status 401
     And karate.log('Status : 401')
     And karate.log('Response is:', response.errors[0].message)
     And match response.errors[0].message contains "Token Invalid! Authentication Required"
     And karate.log('Test Completed !')
     
     #REV2-3602
    Scenario: Verify 404 error Site configuration API
     Given path 'sites/adminss/'+siteId+'/'
     When method delete
     Then status 404
     And karate.log('Status : 404')
     And karate.log('Response is:', response.message)
     And karate.log('Test Completed !')

   
		#REV2-3585
     Scenario: Admin POST request for invalid values in different parameters for replyTo field - Invalid values.
    * karate.log('Creating new siteId for site configuration : ', siteId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site.json')
    * eval requestPayload.subject = "Subject to Test"
    * eval requestPayload.senderEmail = 'Sender' + testEmail
    * eval requestPayload.replyTo = 'reply'
    * eval requestPayload.cc = 'cc' + testEmail
    * eval requestPayload.bcc ='bcc' + testEmail
 
    * karate.log(requestPayload)
    Given path '/sites/admin'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
   
	#REV2-3599
   Scenario: DELETE - Validate Invalid path parameters
     Given path '/sites/admina/'+siteId+'/'
     When method delete
     Then status 404
     And karate.log('Status : 404')


	#REV2-3598
   Scenario: DELETE - Validate Invalid value for endpoint parameters
     * karate.log('Creating new siteId for site configuration : ', siteId)
     Given path '/sitese/admin/'+siteId
     When method delete
     Then status 404
     And karate.log('Status : 404')
     And karate.log('Response is:', response.errors[0].message)
     And karate.log('Test Completed !')
     
      
   
     
        