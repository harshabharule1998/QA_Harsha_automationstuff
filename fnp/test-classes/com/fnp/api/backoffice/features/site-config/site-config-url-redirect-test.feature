Feature: Site Config url redirect Super Admin CRUD feature

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
    * def templateId = 'templateId'+num
#    * def urlId = 'urlId'+num
 
      
  @createUrlRedirect
  Scenario: POST - Create UrlId for site configuration
    #* karate.log('Creating new templateId for site configuration : ', urlId)
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'comments_'+num
    * eval requestPayload.isEnabled = true
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect/'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response contains { id: '#notnull' }
    And karate.log('UrlId created successfully')

  @delteUrlRedirect
  Scenario: DELETE - Delete UrlId for site configuration
    * def urlId = __arg.urlId
    * karate.log('Deleting urlId for site configuration : ', urlId)
    Given path '/sites/urlRedirect/' + urlId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "URL Redirect Tool deleted successfully"
    And karate.log('URL Redirect deleted successfully')
  
  @Regression
  #@performanceData
  #REV2-5149 
  Scenario: POST - Validate valid values in all parameter
    
    #Create urlId
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect')
    * def urlId = result.response.id
    And karate.log('result.requestPayload.urlId:', result.response.id)
    
    #delete urlId
    #* call read('./site-config-url-redirect-test.feature@delteUrlRedirect') {urlId: "#(urlId)"}
    And karate.log('Test Completed !')
  
   
  #REV2-5160 
  Scenario: POST - Validate for invalid value in targetUrl field
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarginvalInvalid'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'comments for url redirect'
    * eval requestPayload.isEnabled = 'true'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Invalid Data. The allowed characters are alphabets, numbers, special characters(forward slash, dot, hyphen).)"
  
      
  #REV2-5159 
  Scenario: POST - Validate for invalid value in sourceUrl field
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsourceInvalid'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarginval'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'comments for url'
    * eval requestPayload.isEnabled = 'true'
    
    * karate.log(requestPayload)
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Invalid Data. The allowed characters are alphabets, numbers, special characters(forward slash, dot, hyphen).)"  
  
   
  #REV2-5158 
  Scenario: POST - Validate for invalid value in redirectType field
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarginval'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301Invalid'
    * eval requestPayload.comment = 'comments for url'
    * eval requestPayload.isEnabled = 'true'
    * karate.log(requestPayload)
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Redirect Type should be 301 or 302"     
  
  
  #REV2-5157 
  Scenario: POST - Validate invalid value in entityType field
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarginval'+num+'/test'
    * eval requestPayload.entityType = 'Invalid'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'comments for url'
    * eval requestPayload.isEnabled = 'true'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Entity Type should be Product or Category or CMS or Others"   
  
  
  #REV2-5156 
  Scenario: POST - Validate for invalid value in isEnabled field
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarginval'+num+'/test'
    * eval requestPayload.entityType = 'Invalid'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'CMS'
    * eval requestPayload.isEnabled = '44484848'
    * karate.log(requestPayload)
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains 'Invalid input data'   
   
   
  #REV2-5155 
  Scenario: POST - Validate invalid value in comments field
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarginval'+num+'/test'
    * eval requestPayload.entityType = 'Product'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = ' '
    * eval requestPayload.isEnabled = 'True'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Comment should not be empty"   
  
        
  #REV2-5154 
  Scenario: POST - Validate Blank values in all parameters
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = '  '
    * eval requestPayload.targetUrl =  '  '
    * eval requestPayload.entityType = ' '
    * eval requestPayload.redirectType = ' '
    * eval requestPayload.comment = '  '
    * eval requestPayload.isEnabled = ' '
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Redirect Type should not be empty"
   
   
   #REV2-5153
   Scenario: POST - Validate for Duplicate values with spaces in all parameters
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'comments for url'
    * eval requestPayload.isEnabled = 'true'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.id == "#notnull"
    And karate.log('UrlId created successfully') 
    
    #Duplicate values in all parameter
    * def requestDuplicatePayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestDuplicatePayload.sourceUrl = 'fnp.sg/newsource'+num+'/test' + ' '
    * eval requestDuplicatePayload.targetUrl =  'fnp.sg/newtarget'+num+'/test' + ' '
    * eval requestDuplicatePayload.entityType = 'CMS' + ' '
    * eval requestDuplicatePayload.redirectType = '301' + ' '
    * eval requestDuplicatePayload.comment = 'comments for url'
    * eval requestDuplicatePayload.isEnabled = 'true' + ' '
    * karate.log(requestDuplicatePayload)
    
    Given path '/beautyplus/v1/sites/urlRedirect'
    And request requestPayload
    * header Authorization = authToken
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Source URL already exists. Please enter another URL"
    And karate.log('Test Completed !')   
  
   
   #REV2-5152
   Scenario: POST - Validate for Duplicate values in all parameters
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'comments for url'
    * eval requestPayload.isEnabled = 'true'
    * karate.log(requestPayload)
    Given path '/sites/urlRedirect'
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Response is:', response)
    And match response.id == "#notnull"
    And karate.log('UrlId created successfully') 
    
    #Duplicate values in all parameter
    * def requestDuplicatePayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestDuplicatePayload.sourceUrl = 'fnp.sg/newsource'+num+'/test'
    * eval requestDuplicatePayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestDuplicatePayload.entityType = 'CMS'
    * eval requestDuplicatePayload.redirectType = '301'
    * eval requestDuplicatePayload.comment = 'comments for url'
    * eval requestDuplicatePayload.isEnabled = 'true'
    * karate.log(requestDuplicatePayload)
    
    Given path '/beautyplus/v1/sites/urlRedirect'
    And request requestPayload
    * header Authorization = authToken
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[*].message contains "Source URL already exists. Please enter another URL"
    And karate.log('Test Completed !')   
  
   @Regression
   #REV2-5161 and REV2-5162
   Scenario: PUT - Validate for Valid URL Redirect Tool ID and valid values in all parameter
    #Create urlId
    
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect') {urlId: "#(urlId)"}
    * def urlId = result.response.id
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsourceupdated/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'updatedcomments_'+urlId
    * eval requestPayload.isEnabled = 'false'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect/'+urlId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message contains "URL Redirect Tool updated successfully"
    
    #delete urlId
    * call read('./site-config-url-redirect-test.feature@delteUrlRedirect') {urlId: "#(urlId)"}
    And karate.log('Test Completed !')
   
   
   #REV2-5163
   Scenario: PUT - Validate for inValid URL Redirect
    * def urlId = 'urlId'+num
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsourceupdated/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'updatedcomments_'
    * eval requestPayload.isEnabled = 'false'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect/'+urlId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Id does not exist"
  
  
   #REV2-5165
   Scenario: PUT - Validate for inValid values in all parameter
    #Create urlId
    
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect') {urlId: "#(urlId)"}
    * def urlId = result.response.id
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/@@@@@@@@/test'
    * eval requestPayload.targetUrl =  'fnp.sg/@@@@@@@@'+num+'/test'
    * eval requestPayload.entityType = '@@@@@@@@'
    * eval requestPayload.redirectType = '@@@@@@@@'
    * eval requestPayload.comment = '@@@@'+urlId
    * eval requestPayload.isEnabled = '@@@@@@@@'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect/'+urlId
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Invalid input data"
    
    #delete urlId
    * call read('./site-config-url-redirect-test.feature@delteUrlRedirect') {urlId: "#(urlId)"}
    And karate.log('Test Completed !')
   
    
   #REV2-5164
   Scenario: PUT - Validate for duplicate values with spaces in all parameter
   
    #Create urlId
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect') {urlId: "#(urlId)"}
    * def urlId = result.response.id

    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.test/newsource'+num+'/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'updatedcomments_'+urlId
    * eval requestPayload.isEnabled = 'false'
    * karate.log(requestPayload)
    
    Given path '/sites/urlRedirect/'+urlId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message contains "URL Redirect Tool updated successfully"
  
    #Put call for duplicate values with space
    * def requestDuplicatePayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestDuplicatePayload.sourceUrl = 'fnp.test/newsource'+num+'/test'+' '
    * eval requestDuplicatePayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'+'  '
    * eval requestDuplicatePayload.entityType = 'CMS'+' '
    * eval requestDuplicatePayload.redirectType = '301'+' '
    * eval requestDuplicatePayload.comment = 'updatedcomments_'+urlId+'  '
    * eval requestDuplicatePayload.isEnabled = 'false' +'  '
    * karate.log(requestDuplicatePayload)
    
    Given path '/beautyplus/v1/sites/urlRedirect/'+urlId
    * header Authorization = authToken
    And request requestDuplicatePayload
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.result.message contains "There is nothing to update"
    
    #delete urlId
    * call read('./site-config-url-redirect-test.feature@delteUrlRedirect') {urlId: "#(urlId)"}
    And karate.log('Test Completed !')
  
  @Regression
  #REV2-5148
  Scenario: GET - Validate URL Redirect Tool GET request for all sites
    Given path '/sites/urlRedirect'
    And param page = 0
		And param size = 200
		And param sortParam = "sourceUrl:asc"
    When method get
    And karate.log('Response is:', response)
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
   
    
   @Regression 
   #REV2-5166
   Scenario: DELETE - Validate Delete call for Valid URL Redirect 
    
    #Create urlId
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect') {urlId: "#(urlId)"}
    * def urlId = result.response.id
    
    #delete urlId
    * call read('./site-config-url-redirect-test.feature@delteUrlRedirect') {urlId: "#(urlId)"}
    And karate.log('Test Completed !')
    
   
   #REV2-5167 and REV2-5170
   Scenario: DELETE - Validate Delete call for InValid URL Redirect and InValid path parameter
   * def urlId = 'urlId'+num
    Given path '/sites/urlRedirect/'+urlId
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "Id does not exist"
    And karate.log('Test Completed !')
   
        
   #REV2-5168
   Scenario: DELETE - Validate Delete call for Blank URL Redirect 
    Given path '/sites/urlRedirect/' + '   '
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response)
    And match response.errors[0].message contains "must not be blank"
    And karate.log('Test Completed !')
   
    
   #REV2-5169
   Scenario: DELETE - Validate Delete call for invalid end point
   * def urlId = 'urlId'+num
    Given path '/sites/invalidurlRedirect/'+urlId
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Response is:', response)
    And match response.error contains "Not Found"
    And karate.log('Test Completed !')
   
                        
   #REV2-5172
   Scenario: DELETE - Validate Delete call for Invalid authorization token
    * def urlId = 'urlId'+num
    Given path '/sites/invalidurlRedirect/'+urlId
    * header Authorization = authToken+'invalid'
    When method delete
    Then status 401
    And karate.log('Status : 401')
    And karate.log('Response is:', response)
    #Failing due to defect REV2-5036
    And match response.errors[0].message contains "Token Invalid! Authentication Required"
    And karate.log('Test Completed !')
    
    
    #REV2-5171
    Scenario: HEAD - Validate for Unsupported methods for endpoints
      * def urlId = 'urlId'+num
      Given path '/sites/urlRedirect/'+urlId
      When method head
      Then status 405
      And karate.log('Status : 405')
      And karate.log('Response is:', response.message)
      #And match response.message contains "Unsupported request method"
      And karate.log('Test Completed !')
      