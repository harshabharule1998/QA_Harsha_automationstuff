Feature: Site Config url redirect history feature

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
 
 	
  @Regression 
  Scenario: GET - Validate history for url redirect after create
    
    #Create urlId
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect')
    * def urlId = result.response.id
    * def sourceUrl = result.requestPayload.sourceUrl
    
    And karate.log('result.requestPayload.urlId:', result.response.id)
    
    Given path '/sites/urlRedirect/history'
    And param sourceUrl = sourceUrl
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by entityType 
    * def filt = function(x){ return x.fieldName == "entityType"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == "CMS"
		
		# filter history response to get objects by sourceUrl 
    * def filt = function(x){ return x.fieldName == "sourceUrl"  && x.action == "CREATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == null
		And match res[0].newValue == sourceUrl
		
    And karate.log('Test Completed !')
  

   @Regression
   Scenario: GET - Validate history for url redirect after update
    
    #Create urlId
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect') {urlId: "#(urlId)"}
    * def urlId = result.response.id
    * def sourceUrl = result.requestPayload.sourceUrl
    * def targetUrl = result.requestPayload.targetUrl
   
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/url-redirect.json')
    * eval requestPayload.sourceUrl = 'fnp.sg/newsourceupdated/test'
    * eval requestPayload.targetUrl =  'fnp.sg/newtarget'+num+'/test'
    * eval requestPayload.entityType = 'CMS'
    * eval requestPayload.redirectType = '301'
    * eval requestPayload.comment = 'updatedcomments_'+urlId
    * eval requestPayload.isEnabled = 'false'
    * karate.log(requestPayload)
    
    * def updatedTargetUrl = requestPayload.targetUrl
    
    Given path '/sites/urlRedirect/'+urlId
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message contains "URL Redirect Tool updated successfully"
    
    * header Authorization = authToken
    Given path '/beautyplus/v1/sites/urlRedirect/history'
    And param sourceUrl = sourceUrl
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by isEnabled 
    * def filt = function(x){ return x.fieldName == "isEnabled"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == true
		And match res[0].newValue == false
		
		# filter history response to get objects by targetUrl 
    * def filt = function(x){ return x.fieldName == "targetUrl"  && x.action == "UPDATE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == targetUrl
		And match res[0].newValue == updatedTargetUrl
		
    And karate.log('Test Completed !')
   
   
   @Regression
   Scenario: GET - Validate history for url redirect after delete 
    
    #Create urlId
    * def result = call read('./site-config-url-redirect-test.feature@createUrlRedirect') {urlId: "#(urlId)"}
    * def urlId = result.response.id
    * def sourceUrl = result.requestPayload.sourceUrl
    And karate.log('result.requestPayload.urlId:', result.response.id)
    
    #delete urlId
    * call read('./site-config-url-redirect-test.feature@delteUrlRedirect') {urlId: "#(urlId)"}
    
    Given path '/sites/urlRedirect/history'
    And param sourceUrl = sourceUrl
		When method get
		Then status 200
		And karate.log('Status: 200')
		And karate.log('History Response : ', response)
		
		* def historyResponse = response
		* def items = get historyResponse.data[*]
		
		# filter history response to get objects by entityType 
    * def filt = function(x){ return x.fieldName == "entityType"  && x.action == "DELETE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == "CMS"
		And match res[0].newValue == null
		
		# filter history response to get objects by sourceUrl 
    * def filt = function(x){ return x.fieldName == "sourceUrl"  && x.action == "DELETE" }
    * def res = karate.filter(items, filt)    
    * print "Filter Response : ", res
    
		And match res[0].oldValue == sourceUrl
		And match res[0].newValue == null
    
    And karate.log('Test Completed !')
    
