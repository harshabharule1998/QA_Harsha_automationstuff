Feature: Redirect campaign search feature for superadmin

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/columbus/v1/configurations'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"columbusSearchAdmin"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(8)
    
    * def campaignId = 'S_01262'
    * def invalidCampaignId = 'S_1101132'
    
    * def campaignName = 'automation2'
    * def invalidCampaignName = 'automations'
    
    * def invalidDomainId = 'fnp.ccom'
    * def domainId = 'fnp.com'
    
    * def validKeyword = 'auto'
    * def invalidKeyword = 'autoo'
       
    * def validTargetUrl = 'https://www.fnp.com/automation'
    * def invalidTargetUrl = 'automations'
    
    * def validGeoId = "India"
    * def invalidGeoId = "100"
    
    * def invalidFromDate = "2025"
    * def invalidThruDate = "9999"
    

  @columbusRegression
  #REV2-9995
  Scenario: GET - Validate request for Redirect Search with Search Admin access with valid campaignID
    
    Given path '/redirect-campaigns/' + campaignId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And match response.id == campaignId
    And karate.log('Test Completed !')
    
  
  #REV2-9996
  Scenario: GET - Validate request for Redirect Search with Search Admin access with invalid campaignID
    
    Given path '/redirect-campaigns/' + invalidCampaignId
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Campaign not Present for provided campaignId"
    And karate.log('Test Completed !')
    
  
  #REV2-9997
  Scenario: GET - Validate request for Redirect Search with Search Admin access with blank campaignID
  
  	* def blankCampaignId = "''"
    Given path '/redirect-campaigns/'+ blankCampaignId  
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Campaign not Present for provided campaignId"
    And karate.log('Test Completed !')
  
  
  @columbusRegression
  #REV2-9998
  Scenario: GET - Validate request for Redirect Search with Search Admin access with valid domainName
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Total Records found : ', response.total)
    And assert response.total >= 1
    And karate.log('Test Completed !')
    
  
  #REV2-9999
  Scenario: GET - Validate request for Redirect Search with Search Admin access with invalid DomainName
    
    Given path '/redirect-campaigns'
    And param domainId = invalidDomainId
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
        
  
  #REV2-10000
  Scenario: GET - Validate request for Redirect Search with Search Admin access with blank DomainName
    
    Given path '/redirect-campaigns'
    And param domainId = ' '
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
    
  @columbusRegression
  #REV2-10001
  Scenario: GET - Validate request for Redirect Search with Search Admin access with valid DomainName with default value
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = '0'
    And param size = '10'
    And param sortParam = 'createdAt:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
 
  @columbusRegression 
  #REV2-10002
  Scenario: GET - Validate request for Redirect Search with Search Admin access with valid DomainName with valid user defined value
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '2'
    And param simpleSearchValue = '0'
    And param size = '20'
    And param sortParam = 'createdAt:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And assert response.total >= 1
    And karate.log('Test Completed !')
  
  
     
  #Defect id - REV2-22362
  #REV2-10003
  Scenario: GET - Validate request for Redirect Search with Search Admin access with valid DomainName with invalid user defined value
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '-0'
    And param simpleSearchValue = '0'
    And param size = '-10'
    And param sortParam = 'createdAt:desc'
        
    When method get
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
  
  @columbusRegression 
  #REV2-10004
  Scenario: GET - Validate request for Redirect Search with Search Admin access with searchParam as valid campaign name.
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = campaignName
    And param size = '10'
    And param sortParam = 'campaignName:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
  
  
  @columbusRegression
  #REV2-10005
  Scenario: GET - Validate request for Redirect Search with Search Admin access with searchParam as valid keyword.
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = validKeyword
    And param size = '10'
    And param sortParam = 'campaignName:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  @columbusRegression
  #REV2-10006
  Scenario: GET - Validate request for Redirect Search with Search Admin access with searchParam as valid URL.
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = validTargetUrl
    And param size = '10'
    And param sortParam = 'campaignName:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  
  #REV2-10007
  Scenario: GET - Validate request for Redirect Search with Search Admin access with searchParam as invalid URL.
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = invalidTargetUrl
    And param size = '10'
    And param sortParam = 'campaignName:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-10008
  Scenario: GET - Validate request for Redirect Search with Search Admin access with blank searchParam.
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = ''
    And param size = '10'
    And param sortParam = 'campaignName:desc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
  
  
  @columbusRegression
  #REV2-10009
  Scenario: GET - Validate request for Redirect Search with Search Admin access with Sorting using GeoId
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = ''
    And param size = '10'
    And param sortParam = 'geoId:asc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
      
  @columbusRegression 
  #REV2-10011
  Scenario: GET - Validate request for Redirect Search with Search Admin access with Sorting using Url
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = ''
    And param size = '10'
    And param sortParam = 'targetUrl:asc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  @columbusRegression
  #REV2-10012
  Scenario: GET - Validate request for Redirect Search with Search Admin access with Sorting using From date and Time
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = ''
    And param size = '10'
    And param sortParam = 'fromDate:asc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-10013
  Scenario: GET - Validate request for Redirect Search with Search Admin access with Sorting using thruDate date and Time
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And param page = '0'
    And param simpleSearchValue = ''
    And param size = '10'
    And param sortParam = 'thruDate:asc'
        
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #@columbusRegression  
  #Defect ID - REV2-22400
  #REV2-10014
  Scenario: POST - Validate request for creating new campaign with valid request for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = campaignName+'-'+num
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 201
    And karate.log('Status : 201')
    And karate.log('Test Completed !')
    
   
  #REV2-10015
  Scenario: POST - Validate request for creating new campaign with invalid domain for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = campaignName+'-'+num
    
    Given path '/redirect-campaigns'
    And param domainId = invalidDomainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
  
   
  #REV2-10016
  Scenario: POST - Validate request for creating new campaign with invalid campaignName for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = ''
    
    Given path '/redirect-campaigns'
    And param domainId = invalidDomainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "CampaignName should not be blank"
    And karate.log('Test Completed !')
    
    
   
  #REV2-10017
  Scenario: POST - Validate request for creating new campaign with invalid geoId for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.geoId = invalidGeoId
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "GEO must have alphabetical  value"
    And karate.log('Test Completed !')
    
   
  #REV2-10018
  Scenario: POST - Validate request for creating new campaign with blank keywords for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.keywords = ''
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "keyword should not be blank"
    And karate.log('Test Completed !')
    
   
  #REV2-10019
  Scenario: POST - Validate request for creating new campaign with invalid URL for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.targetUrl = invalidTargetUrl
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "URL is not valid. Please provide valid URL"
    And karate.log('Test Completed !')
    
   
  #REV2-10020
  Scenario: POST - Validate request for creating new campaign with invalid Fromdate for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.fromDate = invalidFromDate
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid date format"
    And karate.log('Test Completed !')
    
    
   
  #REV2-10021
  Scenario: POST - Validate request for creating new campaign with invalid thruDate for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.thruDate = invalidThruDate
    
    Given path '/redirect-campaigns'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid date format"
    And karate.log('Test Completed !')
    
  
  @columbusRegression 
  #REV2-10022
  Scenario: PUT - Validate request for updating campaign with valid data for admin access role.	 
      
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = requestPayload.campaignName+' '+num
    
    Given path '/redirect-campaigns/' +campaignId
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-10023
  Scenario: PUT - Validate request for updating campaign with invalid domainId for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = requestPayload.campaignName+' '+num
    
    Given path '/redirect-campaigns/' +campaignId
    And param domainId = invalidDomainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
   
  #REV2-10024
  Scenario: PUT - Validate request for updating campaign with blank domainId for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = requestPayload.campaignName+' '+num
    
    Given path '/redirect-campaigns/' +campaignId
    And param domainId = ''
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
   
  #REV2-10025
  Scenario: PUT - Validate request for updating campaign with valid domainId and other missing value for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName =' '
    
    Given path '/redirect-campaigns/' +campaignId
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "CampaignName should not be blank"
    And karate.log('Test Completed !')
    
    
  @columbusRegression
  #REV2-10026
  Scenario: Delete - Validate request for deleting campaign with valid value for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/redirect-campaign.json')
    * eval requestPayload.campaignName = requestPayload.campaignName+' '+num
    
    Given path '/redirect-campaigns/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def attrId = response.id
    And karate.log("New Campaign ID" + attrId )
        
    * header Authorization = authToken    
        
    Given path '/columbus/v1/configurations/redirect-campaigns/' +attrId
    When method delete
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-10027
  Scenario: Delete - Validate request for deleting campaign with invalid value for admin access role.	 
    
    Given path '/redirect-campaigns/' +invalidCampaignId
    
    When method delete
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
  #REV2-10028
  Scenario: Delete - Validate 404 error message for admin access role.	 
    
    Given path '/redirect-campaign' +campaignId
    
    When method delete
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')