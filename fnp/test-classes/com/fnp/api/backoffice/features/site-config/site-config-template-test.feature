Feature: Site Config template Super Admin CRUD feature

  Background: 
    Given url 'https://api-test-r2.fnp.com'
    And header Accept = 'application/json'
    And path '/siteconfiguration/v1'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def templateId = 'templateId'+num
    * def siteId = 'siteId'+num
    * def testEmail = num + '@fnpAutomation.com'
    
      
  @createTemplateId
  Scenario: POST - Create TemplateId for site configuration
    * def templateId = __arg.templateId
    * karate.log('Creating new templateId for site configuration : ', templateId)
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'content'+templateId
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = 'language'+templateId 
    * eval requestPayload.templateName = 'name'+templateId 
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
    And karate.log('Response is:', response)
    And match response.result.message contains "Deleted successfully"
    And karate.log('TemplateId deleted successfully')
    
    
   #REV2-3792
   Scenario: GET - Validate template request for all sites
    Given path '/sites/template'
    And form field pageNumber = 0
		And form field pageSize = 50
		And form field sortDirection = "ASC"
		And form field sortField = "templateId"
    When method get
    And karate.log('Response is:', response)
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')

    #REV2-3793 
    Scenario: POST - Validate valid values in all parameter
     #Create template
     * call read('./site-config-template-test.feature@createTemplateId') {templateId: "#(templateId)"}
     #delete site
     * call read('./site-config-template-test.feature@delteTemplateId') {templateId: "#(templateId)"}
     And karate.log('Test Completed !')
  # fail
    #REV2-3793 
    Scenario: POST - Validate for Invalid templateContent
     * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
     * def requestPayload = data.template
     * eval requestPayload.templateContent = '@@@@@@@@@@@InValid!_123'
     * eval requestPayload.templateId = templateId
     * eval requestPayload.templateLanguage = 'language'+templateId 
     * eval requestPayload.templateName = 'name'+templateId 
     * karate.log(requestPayload)
     Given path '/sites/template'
     And request requestPayload
     When method post
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response)
     And match response.message contains "templateContent must be a valid input"
     And karate.log('Test Completed !')
    
 # fail 
   #REV2-3800 
   Scenario: POST - Validate Invalid templateId
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'templateContent'+templateId 
    * eval requestPayload.templateId = '@@@@@@@@@@@@@@@Invalid12'
    * eval requestPayload.templateLanguage = 'language'+templateId 
    * eval requestPayload.templateName = 'name'+templateId 
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.message contains "templateId must be a valid input"
    And karate.log('Test Completed !')
    
     # Fail
   #REV2-3800 
   Scenario: POST - Validate Invalid templateLanguage
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'templateContent'+templateId 
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = '@@@@@@@@@@@@@@@Invalid'
    * eval requestPayload.templateName = 'name'+templateId 
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.message contains "templateLanguage must be a valid input"
    And karate.log('Test Completed !')
    
    # fail
   #REV2-3800 
   Scenario: POST - Validate Invalid templateName
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'templateContent'+templateId 
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = 'language'+templateId 
    * eval requestPayload.templateName = '@@@@@@@@@@@@@@@Invalid'
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.message contains "templateName must be a valid input"
    And karate.log('Test Completed !')
     
   #REV2-3796 
   Scenario: POST - Validate  Duplicate values in all parameters
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'templateContent'+templateId 
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = 'language'+templateId 
    * eval requestPayload.templateName = 'name'+templateId 
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('TemplateId created successfully')
    
    #Post call for duplicate value
    Given path '/siteconfiguration/v1/sites/template'
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Template Id already exist"
    And karate.log('Test Completed !')
    
   #REV2-3797 
   Scenario: POST - Validate Duplicate values with space
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'templateContent'+templateId 
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = 'language'+templateId 
    * eval requestPayload.templateName = 'name'+templateId 
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('TemplateId created successfully')
    
    #Post call for duplicate value with space
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestDuplicatePayload = data.template
    * eval requestDuplicatePayload.templateContent = 'templateContent'+templateId +' '
    * eval requestDuplicatePayload.templateId = templateId+' '
    * eval requestDuplicatePayload.templateLanguage = 'language'+templateId +' '
    * eval requestDuplicatePayload.templateName = 'name'+templateId +' '
    * karate.log(requestDuplicatePayload)
    Given path '/siteconfiguration/v1/sites/template'
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Template Id already exist"
    And karate.log('Test Completed !')
     
  #fail
   #REV2-3798
   Scenario: POST - Validate blank value for all parameter
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = '  '
    * eval requestPayload.templateId = ' '
    * eval requestPayload.templateLanguage = '  '
    * eval requestPayload.templateName = '  '
    * karate.log(requestPayload)
    Given path '/sites/template'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.message contains "templateId is required"
    And match response.message contains "templateName is required"
    And match response.message contains "templateLanguage is required"
    And match response.message contains "templateContent is required"
    And karate.log('Test Completed !')
      
   #REV2-3806 and REV2-3803
   Scenario: PUT - Validate valid templateId and valid values in all parameter
    # #Create template
    * call read('./site-config-template-test.feature@createTemplateId') {templateId: "#(templateId)"}
    * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
    * def requestPayload = data.template
    * eval requestPayload.templateContent = 'templateContent'+templateId 
    * eval requestPayload.templateId = templateId
    * eval requestPayload.templateLanguage = 'language'+templateId 
    * eval requestPayload.templateName = 'name'+templateId 
    * karate.log(requestPayload)
    Given path '/sites/template/'+templateId
    And request requestPayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.result.message contains "Updated successfully"
    #delete site
    And karate.log('Deleting templateId ')
    * call read('./site-config-template-test.feature@delteTemplateId') {templateId: "#(templateId)"}
    And karate.log('Test Completed !')
     
    
   #REV2-3804
   Scenario: PUT - Validate invalid templateId
     # #Create template
     * call read('./site-config-template-test.feature@createTemplateId') {templateId: "#(templateId)"}
     * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
     * def requestPayload = data.template
     * eval requestPayload.templateContent = 'templateContent'+templateId 
     * eval requestPayload.templateId = templateId
     * eval requestPayload.templateLanguage = 'language'+templateId 
     * eval requestPayload.templateName = 'name'+templateId 
     * karate.log(requestPayload)
     Given path '/sites/template/@@@@@@@@@@@@'
     And request requestPayload
     When method put
     Then status 400
     And karate.log('Status : 400')
     And karate.log('Response is:', response)
     And match response.errors[0].message contains "Template Id does not exist"
     #delete site
     And karate.log('Deleting templateId ')
     * call read('./site-config-template-test.feature@delteTemplateId') {templateId: "#(templateId)"}
     And karate.log('Test Completed !')
    
    #REV2-3805
    Scenario: PUT - Validate duplicate values with spaces
     # #Create template
     * call read('./site-config-template-test.feature@createTemplateId') {templateId: "#(templateId)"}
     * def data = read('classpath:com/fnp/api/backoffice/data/site.json')
     * def requestPayload = data.template
     * eval requestPayload.templateContent = 'templateContent'+templateId 
     * eval requestPayload.templateId = templateId
     * eval requestPayload.templateLanguage = 'language'+templateId 
     * eval requestPayload.templateName = 'name'+templateId 
     * karate.log(requestPayload)
     Given path '/sites/template/'+templateId
     And request requestPayload
     When method put
     Then status 200
     And karate.log('Status : 200')
     And karate.log('Response is:', response)
     And match response.result.message contains "Updated successfully"
     
     #Duplicate value with spaces
     * def requestDuplicatePayload = data.template
     * eval requestDuplicatePayload.templateContent = 'templateContent'+templateId +'  '
     * eval requestDuplicatePayload.templateId = templateId
     * eval requestDuplicatePayload.templateLanguage = 'language'+templateId +'  '
     * eval requestDuplicatePayload.templateName = 'name'+templateId +'  '
     * karate.log(requestDuplicatePayload)
     Given path '/siteconfiguration/v1/sites/template/'+templateId
     * header Authorization = authToken
     And request requestDuplicatePayload
     When method put
     Then status 200
     And karate.log('Status : 200')
     And karate.log('Response is:', response)
     And match response.result.message contains "Updated successfully"
     #delete site
     And karate.log('Deleting templateId ')
     * call read('./site-config-template-test.feature@delteTemplateId') {templateId: "#(templateId)"}
     And karate.log('Test Completed !')
    
    #REV2-3807 
    Scenario: DELETE - Validate valid Template
     #Create template
     * call read('./site-config-template-test.feature@createTemplateId') {templateId: "#(templateId)"}
     #delete site
     * call read('./site-config-template-test.feature@delteTemplateId') {templateId: "#(templateId)"}
     And karate.log('Test Completed !')
    
    
     #REV2-3808 and REV2-3811 
     Scenario: DELETE - Validate invalid Template and inavlid path parameter
      Given path '/sites/template/'+templateId
      When method delete
      Then status 400
      And karate.log('Status : 400')
      And karate.log('Response is:', response)
      And match response.errors[0].message contains "Template Id does not exist"
      And karate.log('Test Completed !')
      
     
     #REV2-3809  
     Scenario: DELETE - Validate for Blank Template
      Given path '/sites/template/     '
      When method delete
      Then status 400
      And karate.log('Status : 400')
      And karate.log('Response is:', response)
      And match response.message contains "must not be blank"
      And karate.log('Test Completed !')
      
     #REV2-3810
     Scenario: DELETE - Validate for Invalid value for endpoint parameters
      Given path '/sites/template@@@@/'
      When method delete
      Then status 404
      And karate.log('Status : 404')
      And karate.log('Response is:', response)
      And match response.error contains "Not Found"
      And karate.log('Test Completed !')
    
    # fail  
     #REV2-3812
     Scenario: HEAD - Validate for Unsupported methods for endpoints
      Given path '/sites/template/'+templateId
      When method head
      #Fainling due to defect REV2-4459
      Then status 405
      And karate.log('Status : 405')
      And karate.log('Response is:', response.message)
      And match response.message contains "Unsupported request method"
      And karate.log('Test Completed !')
     
    
     #REV2-3813
     Scenario: DELETE - Validate for Invalid authorization token
      Given path '/sites/template/'+templateId
      * header Authorization = authToken +templateId
      When method delete
      Then status 401
      And karate.log('Status : 401')
      And karate.log('Response is:', response.message)
      #Failing due to defect REV2-5036
      And match response.errors[0].message contains "Token Invalid! Authentication Required"
      And karate.log('Test Completed !')
      
      
      
      