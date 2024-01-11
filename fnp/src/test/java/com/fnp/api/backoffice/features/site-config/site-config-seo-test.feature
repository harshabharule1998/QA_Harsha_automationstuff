Feature: Site Config SEO configuration CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/beautyplus/v1'
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
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def randomText =  random_string(8)
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    * def templateId = 'templateId' + num
    * def siteId = 'fnp.com'
    * def randomSiteId = 'siteId' + randomText
    #* print "Required siteId text", siteId
	
	
	@createSEOEmail
	Scenario: POST - Create SEO for site configuration
  	
  	* def siteId = __arg.siteId
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
    * karate.log(requestPayload)
    
    Given path '/sites/SEOEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == siteId
    And match response.params.robotConfiguration.defaultRobots == "NoIndex, Follow"
    And match response.params.hrefLang.entitiesEnabledFor == "Home"
    * def responseData = response
    
	@deleteSEOEmail
  Scenario: DELETE - Delete SEO for site configuration
    * def siteId = __arg.siteId
    * karate.log('Deleting SEO for site configuration : ', siteId)
    Given path '/sites/SEOEmail/' + siteId + '/'
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message contains "Seo deleted successfully"
    And karate.log('SEO Deleted successfully')
   

  @Regression 
	#@performanceData
	#REV2-3704
	Scenario: POST - Validate user able to create SEO configuration for valid siteId
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
    * karate.log(requestPayload)
    Given path '/sites/SEOEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    And match response.id == siteId
    And match response.params.robotConfiguration.defaultRobots == "NoIndex, Follow"
    And match response.params.hrefLang.entitiesEnabledFor == "Home"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(siteId)"}
    And karate.log('Test Completed !')
    
  
  #REV2-3705
  Scenario: POST - Validate user cannot create SEO configuration for invalid siteId
     
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
    * karate.log(requestPayload)
    # invalid siteId
    * def siteId = "abc-z12"
    Given path '/sites/SEOEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Id does not exist"
		
		And karate.log('Test Completed !')
	

	#REV2-3710
	Scenario: POST - Validate user cannot create SEO configuration with duplicate values
  	
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
    * karate.log(requestPayload)
     
    Given path '/sites/SEOEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    
    #try creating SEO config with duplicate values
    * header Authorization = authToken
    Given path '/beautyplus/v1/sites/SEOEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Id already exist"
    
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(siteId)"}
    And karate.log('Test Completed !')
  
   
	#REV2-3706
	Scenario: POST - Validate user cannot create SEO configuration with blank values
  	 
    * def requestPayload =
      """
      {
			    "customInstructionForRobot": "",
			    "defaultRobots": "",
			    "enableSubmissionToMetaRobots": "",
			    "entitiesEnabledFor": "",
			    "hrefLangScope": "",
			    "includeCMSInSiteMap": "",
			    "includeLastModified": "",
			    "locale": "",
			    "maximumFileSize": "",
			    "maximumNoOFUrlsPerFile": "",
			    "siteMapGenerationFrequency": "",
			    "siteMapPriority": "",
			    "siteMapStartTime": "",
			    "xmlSitemapHeader": ""
			}
      """
    * karate.log(requestPayload)
     
    Given path '/sites/SEOEmail'
    And param id = siteId
    
    #try creating SEO config with blank values
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].errorCode contains "INVALID_DATA"

    And karate.log('Test Completed !')
  
     
  #REV2-3772  
  Scenario: POST - Validate error message for creating SEO configuration with invalid customInstructionForRobot
     
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid customInstructionForRobot
    * eval requestPayload.customInstructionForRobot = 123
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    #And match response.errors[0].message contains "Please provide valid input for CustomInstructionForRobot"
    
    And karate.log('Test Completed !')
    
   
  #REV2-3771
  Scenario: POST - Validate error message for creating SEO configuration with invalid defaultRobots
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid defaultRobots
    * eval requestPayload.defaultRobots = "TestRobot123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId 
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Default Robots should be Index, Follow (or) NoIndex, Follow (or) Index, NoFollow (or) NoIndex, No Follow"
    
    And karate.log('Test Completed !')
    
  
  #REV2-3755    
  Scenario: POST - Validate error message for creating SEO configuration with invalid enableSubmissionToMetaRobots
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid enableSubmissionToMetaRobots
    * eval requestPayload.enableSubmissionToMetaRobots = "TestMetaRobots123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "EnableSubmissionToMetaRobots should be Yes or No"
    
    And karate.log('Test Completed !')
  
  
  #REV2-3778
  Scenario: POST - Validate error message for creating SEO configuration with invalid entitiesEnabledFor
  	  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid entitiesEnabledFor
    * eval requestPayload.entitiesEnabledFor = "TestEntities123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'EntitiesEnabledFor should be Category or Product or Home or CMS Static Pages'
    
    And karate.log('Test Completed !')
  
    
	#REV2-3777 
  Scenario: POST - Validate error message for creating SEO configuration with invalid hrefLangScope
  
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid hrefLangScope
    * eval requestPayload.hrefLangScope = "TestHrefLang123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'HrefLangScope should be Global or Website'
    
    And karate.log('Test Completed !')
  
    
  #REV2-3756
  Scenario: POST - Validate error message for creating SEO configuration with invalid includeCMSInSiteMap
  	
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid includeCMSInSiteMap
    * eval requestPayload.includeCMSInSiteMap = "TestIncludeCMS123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'IncludeCMSInSiteMap should be Articles or Blogs or Static Information Pages'
    
    And karate.log('Test Completed !')
    

  #REV2-3759 
  Scenario: POST - Validate error message for creating SEO configuration with invalid includeLastModified
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid includeLastModified
    * eval requestPayload.includeLastModified = "TestIncludeLast123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'IncludeLastModified should be Yes or No'
    
    And karate.log('Test Completed !')
  
     
  #REV2-3779
  Scenario: POST - Validate error message for creating SEO configuration with invalid locale
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid locale
    * eval requestPayload.locale = 123
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Please provide valid input for Locale"
    
    And karate.log('Test Completed !')
    
   
  #REV2-3768
  Scenario: POST - Validate error message for creating SEO configuration with invalid maximumFileSize
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid maximumFileSize
    * eval requestPayload.maximumFileSize = "TestMaxFileSize123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Maximum File Size must be less than or equal to 50"
    
    And karate.log('Test Completed !') 
    
    
  #REV2-3767
  Scenario: POST - Validate error message for creating SEO configuration with invalid maximumNoOFUrlsPerFile
  	
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid maximumNoOFUrlsPerFile
    * eval requestPayload.maximumNoOFUrlsPerFile = "TestMaxUrl123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Maximum No OF Urls Per File must be less than or equal to 50000"
    
    And karate.log('Test Completed !')
    
 
  #REV2-3757 
	Scenario: POST - Validate error message for creating SEO configuration with invalid siteMapGenerationFrequency
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid siteMapGenerationFrequency
    * eval requestPayload.siteMapGenerationFrequency = "TestSiteMapGen123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'SiteMapGenerationFrequency should be Hourly or Daily or Weekly or Monthly or Yearly or Never'
    
    And karate.log('Test Completed !')
    
 
  #REV2-3758  
  Scenario: POST - Validate error message for creating SEO configuration with invalid siteMapPriority
     
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid siteMapPriority
    * eval requestPayload.siteMapPriority = "TestSiteMap123"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Sitemap Priority must be greater than or equal to 0"
    
    And karate.log('Test Completed !')
    
   
  #REV2-3760
	Scenario: POST - Validate error message for creating SEO configuration with invalid siteMapStartTime
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid siteMapStartTime
    * eval requestPayload.siteMapStartTime = "112233"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'SiteMapStartTime should be HH:MM:SS'
    
    And karate.log('Test Completed !')
    
  
  Scenario: POST - Validate error message for creating SEO configuration with invalid xmlSitemapHeader
  	 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
  	
  	# invalid xmlSitemapHeader
    * eval requestPayload.xmlSitemapHeader = "301 Redirect"
		* karate.log(requestPayload)  
    
    Given path '/sites/SEOEmail'
    And param id = randomSiteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'XML Sitemap Header not valid'
    
    And karate.log('Test Completed !')
   
     
  @Regression
  #REV2-3784  
  Scenario: PUT - Validate user able to update SEO configuration for valid siteId
  
    * def siteId = 'fnp.sg'
  	 
    * def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(siteId)"}
    
    * def requestPayload = result.requestPayload
    
    # update entitiesEnabledFor to 'Product'
    * eval requestPayload.entitiesEnabledFor = "Product"
    # update entitiesEnabledFor to 'automation-updated'
    * eval requestPayload.customInstructionForRobot = "automationupdated"
    * karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + siteId + '/'
    And request requestPayload
    When method put
    Then status 202
    And karate.log('Status : 202')
    And match response.message == "Seo updated successfully"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(siteId)"}
    And karate.log('Test Completed !')
    
  #REV2-3785
  Scenario: PUT - Validate user cannot update SEO configuration for invalid siteId
 
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
    * karate.log(requestPayload)
    # invalid siteId
    * def invalidSiteId = "abc-z12" 
    
    # update entitiesEnabledFor to 'Product'
    * eval requestPayload.entitiesEnabledFor = "Product"
    # update entitiesEnabledFor to 'automation-updated'
    * eval requestPayload.customInstructionForRobot = "automationupdated"
    * karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + invalidSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Id does not exist"

    And karate.log('Test Completed !')
  
    
  #REV2-3786 
	Scenario: PUT - Validate message for update SEO configuration with duplicate values
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    
    * def requestPayload = result.requestPayload
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    #And match response.message == "nothing to update"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
 
 
  #REV2-3751  
  Scenario: PUT - Validate error message for updating SEO configuration with invalid customInstructionForRobot
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    
    * def requestPayload = result.requestPayload
    
    # try updating with invalid customInstructionForRobot
    * eval requestPayload.customInstructionForRobot = "auto-invalid-instruction"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'Please provide valid input for CustomInstructionForRobot'
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
    
     
  #REV2-3752
  Scenario: PUT - Validate error message for updating SEO configuration with invalid defaultRobots
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid defaultRobots
    * eval requestPayload.defaultRobots = "auto-invalid-robot"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'Default Robots should be Index, Follow (or) NoIndex, Follow (or) Index, NoFollow (or) NoIndex, No Follow'
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
    
  
  #REV2-3753   
  Scenario: PUT - Validate error message for updating SEO configuration with invalid enableSubmissionToMetaRobots
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid enableSubmissionToMetaRobots
    * eval requestPayload.enableSubmissionToMetaRobots = "auto-invalid-meta-robot"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'EnableSubmissionToMetaRobots should be Yes or No'
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
    
  
  #REV2-3754
  Scenario: PUT - Validate error message for updating SEO configuration with invalid entitiesEnabledFor
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid entitiesEnabledFor
    * eval requestPayload.entitiesEnabledFor = "auto-invalid-entities"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "EntitiesEnabledFor should be Category or Product or Home or CMS Static Pages"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
   
    
  #REV2-3747
  Scenario: PUT - Validate error message for updating SEO configuration with invalid hrefLangScope
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid hrefLangScope
    * eval requestPayload.hrefLangScope = "auto-invalid-href"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'HrefLangScope should be Global or Website'
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
    

  #REV2-3748
  Scenario: PUT - Validate error message for updating SEO configuration with invalid includeCMSInSiteMap
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid includeCMSInSiteMap
    * eval requestPayload.includeCMSInSiteMap = "auto-invalid-sitemap"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'IncludeCMSInSiteMap should be Articles or Blogs or Static Information Pages'
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
    
 	#REV2-3749
  Scenario: PUT - Validate error message for updating SEO configuration with invalid includeLastModified
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid includeLastModified
    * eval requestPayload.includeLastModified = "auto-invalid-modified"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "IncludeLastModified should be Yes or No"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
    
  #REV2-3750
  Scenario: PUT - Validate error message for updating SEO configuration with invalid locale
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid locale
    * eval requestPayload.locale = 123
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Please provide valid input for Locale"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
    
  #REV2-3742
  Scenario: PUT - Validate error message for updating SEO configuration with invalid maximumFileSize
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid maximumFileSize
    * eval requestPayload.maximumFileSize = "auto-invalid-file"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Maximum File Size must be greater than or equal to 1"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
    
  #REV2-3741
  Scenario: PUT - Validate error message for updating SEO configuration with invalid maximumNoOFUrlsPerFile
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid maximumNoOFUrlsPerFile
    * eval requestPayload.maximumNoOFUrlsPerFile = "auto-invalid-maxurl"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Maximum No OF Urls Per File must be greater than or equal to 1"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
  
  #REV2-3738    
  Scenario: PUT - Validate error message for updating SEO configuration with invalid siteMapGenerationFrequency
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid siteMapGenerationFrequency
    * eval requestPayload.siteMapGenerationFrequency = "auto-invalid-frequency"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "SiteMapGenerationFrequency should be Hourly"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
    
     
  #REV2-3739
	Scenario: PUT - Validate error message for updating SEO configuration with invalid siteMapPriority
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid siteMapPriority
    * eval requestPayload.siteMapPriority = "auto-invalid-priority"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "Sitemap Priority must be"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
     
	#REV2-3740    
	Scenario: PUT - Validate error message for updating SEO configuration with invalid siteMapStartTime
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid siteMapStartTime
    * eval requestPayload.siteMapStartTime = "aa:bb:cc"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains "SiteMapStartTime should be HH:MM:SS"
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
  
   
  #REV2-3737 
	Scenario: PUT - Validate error message for updating SEO configuration with invalid xmlSitemapHeader
  	
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(randomSiteId)"}
    * def requestPayload = result.requestPayload
    
    # try updating with invalid xmlSitemapHeader
    * eval requestPayload.xmlSitemapHeader = "301 Redirect"
		* karate.log(requestPayload)
    
    Given path '/sites/SEOEmail/' + randomSiteId + '/'
    And request requestPayload
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message contains 'XML Sitemap Header not valid'
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(randomSiteId)"}
    And karate.log('Test Completed !')
   
   
  #@Regression
  #REV2-3700
	Scenario: GET - Validate user able to fetch all SEO configurations
    
    Given path '/sites/SEOEmail'
		And param page = 0
	  And param size = 10
		And param sortParam = 'id:asc'
     
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.data.length >= 1
  
  
  @Regression
 	#REV2-3704
	Scenario: GET - Validate user able to fetch SEO configurations for valid siteId
	
   
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(siteId)"}
    
    Given path '/sites/SEOEmail/' + siteId + '/' 
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.id == siteId
    
    # delete SEO
    And karate.log('Deleting SEO Email ')
    * call read('./site-config-seo-test.feature@deleteSEOEmail') {siteId: "#(siteId)"}
    And karate.log('Test Completed !')
	
	
  #REV2-3702
	Scenario: GET - Validate invalid siteId error message to fetch SEO configurations 
    
    # invalid siteId
    * def siteId = '1atr'
    
    Given path '/sites/SEOEmail/' + siteId + '/'
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Id does not exist"
    
  
  #REV2-3703 
	Scenario: GET - Validate blank siteId error message to fetch SEO configurations
    
    # blank siteId
    * def siteId = '  '
    
    Given path '/sites/SEOEmail/' + siteId + '/' 
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "must not be blank"
    
  @Regression
  #REV2-3788  
	Scenario: DELETE - Validate user able to delete SEO configuration for valid siteId
  	
  	# Create SEO configuration
  	* def result = call read('./site-config-seo-test.feature@createSEOEmail') {siteId: "#(siteId)"}
  	
    # Delete created SEO configuration
    Given path '/sites/SEOEmail/' + siteId + '/'
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And match response.message == "Seo deleted successfully"
  
   
  #REV2-3789
	Scenario: DELETE - Validate invalid siteId error message for deleting SEO configurations 
    
    # invalid siteId
    * def siteId = '1atr'
    
    Given path '/sites/SEOEmail/' + siteId + '/'
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Id does not exist"
  
    
  #REV2-3790
  Scenario: DELETE - Validate blank siteId error message for deleting SEO configurations
    
    # blank siteId
    * def siteId = '  '
    
    Given path '/sites/SEOEmail/' + siteId + '/' 
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "must not be blank"
    
    
    #REV2-3712
		Scenario: POST - Validate user cannot create SEO configuration with Blank values in all parameters
   * karate.log('Creating new siteId for site configuration : ', siteId)
   * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
   * eval requestPayload.customInstructionForRobot =""
   * eval requestPayload.defaultRobots =""
   * eval requestPayload.enableSubmissionToMetaRobots =""
	 * eval requestPayload.entitiesEnabledFor ="" 
	 * eval requestPayload.hrefLangScope ="" 
	 * eval requestPayload.includeCMSInSiteMap ="" 
	 * eval requestPayload.includeLastModified ="" 
   * eval requestPayload.locale =""
	 * eval requestPayload.maximumFileSize = "" 
	 * eval requestPayload.maximumNoOFUrlsPerFile = "" 
	 * eval requestPayload.siteMapGenerationFrequency = " " 
	 * eval requestPayload.siteMapPriority = "" 
 	 * eval requestPayload.siteMapStartTime = "" 
	 * eval requestPayload.xmlSitemapHeader = "" 
	 * karate.log(requestPayload)
   
  Given path '/' + siteId + '/'
  
  #try creating SEO config with blank values
  And request requestPayload
  When method post
  Then status 400
  And karate.log('Status : 400')
  
  
    #REV2-3709
  	Scenario: POST - Validate user can create SEO configuration with Only Required parameters
   
   * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
   * eval requestPayload.customInstructionForRobot =""
   * eval requestPayload.defaultRobots =""
   * eval requestPayload.enableSubmissionToMetaRobots =""
	 * eval requestPayload.entitiesEnabledFor ="" 
	 * eval requestPayload.hrefLangScope ="" 
	 * eval requestPayload.includeCMSInSiteMap ="" 
	 * eval requestPayload.includeLastModified ="" 
   * eval requestPayload.locale =""
	 * eval requestPayload.maximumFileSize = "2" 
	 * eval requestPayload.maximumNoOFUrlsPerFile = "5" 
	 * eval requestPayload.siteMapGenerationFrequency = " " 
	 * eval requestPayload.siteMapPriority = "1" 
 	 * eval requestPayload.siteMapStartTime = "11:23:45" 
	 * eval requestPayload.xmlSitemapHeader = " " 
	 * karate.log(requestPayload)
  Given path '/sites/SEOEmail'
  #try creating SEO config with only required values
  And param id = randomSiteId
  And request requestPayload
  When method post
  Then status 201
  And karate.log('Status : 201')
  
  
   #REV2-3708
  Scenario: POST - Validate user cannot create SEO configuration with Only optional parameters
   
   * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
   * eval requestPayload.customInstructionForRobot ="demo instruction"
   * eval requestPayload.defaultRobots ="NoIndex, Follow"
   * eval requestPayload.enableSubmissionToMetaRobots ="Yes"
	 * eval requestPayload.entitiesEnabledFor ="Home" 
	 * eval requestPayload.hrefLangScope ="Global" 
	 * eval requestPayload.includeCMSInSiteMap ="Blogs" 
	 * eval requestPayload.includeLastModified ="Yes" 
   * eval requestPayload.locale ="en-sg"
	 * eval requestPayload.maximumFileSize = "" 
	 * eval requestPayload.maximumNoOFUrlsPerFile = "" 
	 * eval requestPayload.siteMapGenerationFrequency = " " 
	 * eval requestPayload.siteMapPriority = "" 
 	 * eval requestPayload.siteMapStartTime = "" 
	 * eval requestPayload.xmlSitemapHeader = " " 
	 * karate.log(requestPayload)
  Given path '/sites/SEOEmail'
  #try creating SEO config with only optional values
  And param id = randomSiteId
  And request requestPayload
  When method post
  Then status 400
  And karate.log('Status : 400')
  And karate.log('Response is:',response.errors[0].message)
  And karate.log('Test Completed !')


#REV2-3711
	Scenario: POST - create SEO configuration with duplicate values with spaces in all parameter
	 * karate.log('Creating new siteId for site configuration : ', siteId)
   * def requestPayload = read('classpath:com/fnp/api/backoffice/data/site-config-seo.json')
   * karate.log(requestPayload)
   Given path '/sites/SEOEmail'
   And param id = randomSiteId
   And request requestPayload
   When method post
   Then status 201
   And karate.log('Status : 201')
   
   * eval requestPayload.customInstructionForRobot = " " + requestPayload.customInstructionForRobot + " "
   * eval requestPayload.defaultRobots = " " + requestPayload.defaultRobots + " "
   * eval requestPayload.enableSubmissionToMetaRobots = " " + requestPayload.enableSubmissionToMetaRobots + " "
	 * eval requestPayload.entitiesEnabledFor = " " + requestPayload.entitiesEnabledFor + " "
	 * eval requestPayload.hrefLangScope = " " + requestPayload.hrefLangScope + " "
	 * eval requestPayload.includeCMSInSiteMap = " " + requestPayload.includeCMSInSiteMap + " "
	 * eval requestPayload.includeLastModified = " " + requestPayload.includeLastModified + " "
   * eval requestPayload.locale = " " + requestPayload.locale + " "
	 * eval requestPayload.maximumFileSize = " " + requestPayload.maximumFileSize + " "
	 * eval requestPayload.maximumNoOFUrlsPerFile = " " + requestPayload.maximumNoOFUrlsPerFile + " "
	 * eval requestPayload.siteMapGenerationFrequency = " " + requestPayload.siteMapGenerationFrequency + " "
	 * eval requestPayload.siteMapPriority = " " + requestPayload.siteMapPriority + " "
 	 * eval requestPayload.siteMapStartTime = " " + requestPayload.siteMapStartTime + " "
	 * eval requestPayload.xmlSitemapHeader = " " + requestPayload.xmlSitemapHeader + " "
	 
	 * header Authorization = authToken
    Given path '/beautyplus/v1/sites/SEOEmail/'
    And param id = siteId
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
   

    
