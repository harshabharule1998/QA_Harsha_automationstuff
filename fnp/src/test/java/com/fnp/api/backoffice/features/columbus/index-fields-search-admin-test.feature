Feature: Configuration API for Index Fields scenarios for search Admin role

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
    
    * def invalidDomainId = 'fnp.ccom'
    * def domainId = 'fnp.com'
    
  
  @columbusRegression
  #REV2-10280
  Scenario: GET - Validate request for indexable attribute with Search Admin access with valid domain
    
    Given path '/indexfields/'
    And param domainId = domainId
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
   
  #REV2-10281
  Scenario: GET - Validate request for indexable attribute with Search Admin access with invalid domain
    
    Given path '/indexfields/'
    And param domainId = invalidDomainId
    When method get
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
   
  #REV2-10282
  Scenario: GET - Validate request for indexable attribute with Search Admin access with blank domain
    
    Given path '/indexfields/'
    And param domainId = ''
    When method get
    Then status 400
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
     
  #REV2-10283
  Scenario: GET - Verify 404 Error for indexable attribute with Search Admin access
    
    Given path '/indexfiel//'
    And param domainId = domainId
    When method get
    Then status 404
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
    
  @columbusRegression
  #REV2-10285
  Scenario: PUT - Validate request for updating indexable attribute with all valid data for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldName = 'name'
    * eval requestPayload[0].fieldDisplayName = 'Product Name'
    * eval requestPayload[0].fieldVal = 10
    
    * eval requestPayload[1].fieldName = 'product_id'
    * eval requestPayload[1].fieldDisplayName = 'product id'
    * eval requestPayload[1].fieldVal = 5
    
    * eval requestPayload[2].fieldName = 'sku'
    * eval requestPayload[2].fieldDisplayName = 'Product sku'
    * eval requestPayload[2].fieldVal = 5
    
    * eval requestPayload[3].fieldName = 'long_description'
    * eval requestPayload[3].fieldDisplayName = 'Product long description'
    * eval requestPayload[3].fieldVal = 80
    
    * eval requestPayload[4].fieldName = 'description'
    * eval requestPayload[4].fieldDisplayName = 'Product short description'
    * eval requestPayload[4].fieldVal = 0
    
    * eval requestPayload[5].fieldName = 'brand_name'
    * eval requestPayload[5].fieldDisplayName = 'brand'
    * eval requestPayload[5].fieldVal = 0
    
    * eval requestPayload[6].fieldName = 'city'
    * eval requestPayload[6].fieldDisplayName = 'City'
    * eval requestPayload[6].fieldVal = 0
    
    * eval requestPayload[7].fieldName = 'occasion'
    * eval requestPayload[7].fieldDisplayName = 'Relevancy of Occasion Tag'
    * eval requestPayload[7].fieldVal = 0
    
    * eval requestPayload[8].fieldName = 'recipient_tags'
    * eval requestPayload[8].fieldDisplayName = 'Relevancy of Recipient Tag'
    * eval requestPayload[8].fieldVal = 0
    
    * eval requestPayload[9].fieldName = 'product_type_tags'
    * eval requestPayload[9].fieldDisplayName = 'Product type'
    * eval requestPayload[9].fieldVal = 0
    
    * eval requestPayload[10].fieldName = 'destination_country'
    * eval requestPayload[10].fieldDisplayName = 'Destination Country'
    * eval requestPayload[10].fieldVal = 0
    
    * eval requestPayload[11].fieldName = 'feature_data'
    * eval requestPayload[11].fieldDisplayName = 'Features'
    * eval requestPayload[11].fieldVal = 0
    
    * eval requestPayload[12].fieldName = 'internal_name'
    * eval requestPayload[12].fieldDisplayName = 'Internal Name'
    * eval requestPayload[12].fieldVal = 0
    
    * eval requestPayload[13].fieldName = 'conversion_rate'
    * eval requestPayload[13].fieldDisplayName = 'Conversion Rate'
    * eval requestPayload[13].fieldVal = 0
    
    * eval requestPayload[14].fieldName = 'click_thru_rate'
    * eval requestPayload[14].fieldDisplayName = 'Click Through Rate'
    * eval requestPayload[14].fieldVal = 0
    
    * eval requestPayload[15].fieldName = 'total_viewed'
    * eval requestPayload[15].fieldDisplayName = 'Impression'
    * eval requestPayload[15].fieldVal = 0
    
    * eval requestPayload[16].fieldName = 'listprice_inr'
    * eval requestPayload[16].fieldDisplayName = 'Website Price'
    * eval requestPayload[16].fieldVal = 0
   
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
  
  #REV2-10287
  Scenario: PUT - Validate request for updating indexable attribute with invalid field name and field display name data for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldName = 'NameTest1'
    * eval requestPayload[0].fieldDisplayName = 'Product Name description'
    * eval requestPayload[0].fieldVal = 10
    
    * eval requestPayload[1].fieldName = 'product_id54'
    * eval requestPayload[1].fieldDisplayName = 'product id test'
    * eval requestPayload[1].fieldVal = 5
    
    * eval requestPayload[2].fieldName = 'sku'
    * eval requestPayload[2].fieldDisplayName = 'Product sku'
    * eval requestPayload[2].fieldVal = 5
    
    * eval requestPayload[3].fieldName = 'long_description'
    * eval requestPayload[3].fieldDisplayName = 'Product long description'
    * eval requestPayload[3].fieldVal = 80
    
    * eval requestPayload[4].fieldName = 'description'
    * eval requestPayload[4].fieldDisplayName = 'Product short description'
    * eval requestPayload[4].fieldVal = 0
    
    * eval requestPayload[5].fieldName = 'brand_name'
    * eval requestPayload[5].fieldDisplayName = 'brand'
    * eval requestPayload[5].fieldVal = 0
    
    * eval requestPayload[6].fieldName = 'city'
    * eval requestPayload[6].fieldDisplayName = 'City'
    * eval requestPayload[6].fieldVal = 0
    
    * eval requestPayload[7].fieldName = 'occasion'
    * eval requestPayload[7].fieldDisplayName = 'Relevancy of Occasion Tag'
    * eval requestPayload[7].fieldVal = 0
    
    * eval requestPayload[8].fieldName = 'recipient_tags'
    * eval requestPayload[8].fieldDisplayName = 'Relevancy of Recipient Tag'
    * eval requestPayload[8].fieldVal = 0
    
    * eval requestPayload[9].fieldName = 'product_type_tags'
    * eval requestPayload[9].fieldDisplayName = 'Product type'
    * eval requestPayload[9].fieldVal = 0
    
    * eval requestPayload[10].fieldName = 'destination_country'
    * eval requestPayload[10].fieldDisplayName = 'Destination Country'
    * eval requestPayload[10].fieldVal = 0
    
    * eval requestPayload[11].fieldName = 'feature_data'
    * eval requestPayload[11].fieldDisplayName = 'Features'
    * eval requestPayload[11].fieldVal = 0
    
    * eval requestPayload[12].fieldName = 'internal_name'
    * eval requestPayload[12].fieldDisplayName = 'Internal Name'
    * eval requestPayload[12].fieldVal = 0
    
    * eval requestPayload[13].fieldName = 'conversion_rate'
    * eval requestPayload[13].fieldDisplayName = 'Conversion Rate'
    * eval requestPayload[13].fieldVal = 0
    
    * eval requestPayload[14].fieldName = 'click_thru_rate'
    * eval requestPayload[14].fieldDisplayName = 'Click Through Rate'
    * eval requestPayload[14].fieldVal = 0
    
    * eval requestPayload[15].fieldName = 'total_viewed'
    * eval requestPayload[15].fieldDisplayName = 'Impression'
    * eval requestPayload[15].fieldVal = 0
    
    * eval requestPayload[16].fieldName = 'listprice_inr'
    * eval requestPayload[16].fieldDisplayName = 'Website Price'
    * eval requestPayload[16].fieldVal = 0
    
    
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
   
  #REV2-10288
  Scenario: PUT - Validate request for updating indexable attribute with blank field name and field display name data for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldName = ''
    * eval requestPayload[0].fieldDisplayName = ''
    * eval requestPayload[0].fieldVal = 10
    
    * eval requestPayload[1].fieldName = ''
    * eval requestPayload[1].fieldDisplayName = ''
    * eval requestPayload[1].fieldVal = 5
    
    * eval requestPayload[2].fieldName = 'sku'
    * eval requestPayload[2].fieldDisplayName = 'Product sku'
    * eval requestPayload[2].fieldVal = 5
    
    * eval requestPayload[3].fieldName = 'long_description'
    * eval requestPayload[3].fieldDisplayName = 'Product long description'
    * eval requestPayload[3].fieldVal = 80
    
    * eval requestPayload[4].fieldName = 'description'
    * eval requestPayload[4].fieldDisplayName = 'Product short description'
    * eval requestPayload[4].fieldVal = 0
    
    * eval requestPayload[5].fieldName = 'brand_name'
    * eval requestPayload[5].fieldDisplayName = 'brand'
    * eval requestPayload[5].fieldVal = 0
    
    * eval requestPayload[6].fieldName = 'city'
    * eval requestPayload[6].fieldDisplayName = 'City'
    * eval requestPayload[6].fieldVal = 0
    
    * eval requestPayload[7].fieldName = 'occasion'
    * eval requestPayload[7].fieldDisplayName = 'Relevancy of Occasion Tag'
    * eval requestPayload[7].fieldVal = 0
    
    * eval requestPayload[8].fieldName = 'recipient_tags'
    * eval requestPayload[8].fieldDisplayName = 'Relevancy of Recipient Tag'
    * eval requestPayload[8].fieldVal = 0
    
    * eval requestPayload[9].fieldName = 'product_type_tags'
    * eval requestPayload[9].fieldDisplayName = 'Product type'
    * eval requestPayload[9].fieldVal = 0
    
    * eval requestPayload[10].fieldName = 'destination_country'
    * eval requestPayload[10].fieldDisplayName = 'Destination Country'
    * eval requestPayload[10].fieldVal = 0
    
    * eval requestPayload[11].fieldName = 'feature_data'
    * eval requestPayload[11].fieldDisplayName = 'Features'
    * eval requestPayload[11].fieldVal = 0
    
    * eval requestPayload[12].fieldName = 'internal_name'
    * eval requestPayload[12].fieldDisplayName = 'Internal Name'
    * eval requestPayload[12].fieldVal = 0
    
    * eval requestPayload[13].fieldName = 'conversion_rate'
    * eval requestPayload[13].fieldDisplayName = 'Conversion Rate'
    * eval requestPayload[13].fieldVal = 0
    
    * eval requestPayload[14].fieldName = 'click_thru_rate'
    * eval requestPayload[14].fieldDisplayName = 'Click Through Rate'
    * eval requestPayload[14].fieldVal = 0
    
    * eval requestPayload[15].fieldName = 'total_viewed'
    * eval requestPayload[15].fieldDisplayName = 'Impression'
    * eval requestPayload[15].fieldVal = 0
    
    * eval requestPayload[16].fieldName = 'listprice_inr'
    * eval requestPayload[16].fieldDisplayName = 'Website Price'
    * eval requestPayload[16].fieldVal = 0
     
   
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
   
  #REV2-10289
  Scenario: PUT - Verify 404 error code for updating request for indexable attribute for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldName = 'Name'
    * eval requestPayload[0].fieldDisplayName = 'Product Name'
    * eval requestPayload[0].fieldVal = 10
    
    * eval requestPayload[1].fieldName = 'product_id'
    * eval requestPayload[1].fieldDisplayName = 'product id'
    * eval requestPayload[1].fieldVal = 5
    
    * eval requestPayload[2].fieldName = 'sku'
    * eval requestPayload[2].fieldDisplayName = 'Product sku'
    * eval requestPayload[2].fieldVal = 5
    
    * eval requestPayload[3].fieldName = 'long_description'
    * eval requestPayload[3].fieldDisplayName = 'Product long description'
    * eval requestPayload[3].fieldVal = 80
    
    * eval requestPayload[4].fieldName = 'description'
    * eval requestPayload[4].fieldDisplayName = 'Product short description'
    * eval requestPayload[4].fieldVal = 0
    
    * eval requestPayload[5].fieldName = 'brand_name'
    * eval requestPayload[5].fieldDisplayName = 'brand'
    * eval requestPayload[5].fieldVal = 0
    
    * eval requestPayload[6].fieldName = 'city'
    * eval requestPayload[6].fieldDisplayName = 'City'
    * eval requestPayload[6].fieldVal = 0
    
    * eval requestPayload[7].fieldName = 'occasion'
    * eval requestPayload[7].fieldDisplayName = 'Relevancy of Occasion Tag'
    * eval requestPayload[7].fieldVal = 0
    
    * eval requestPayload[8].fieldName = 'recipient_tags'
    * eval requestPayload[8].fieldDisplayName = 'Relevancy of Recipient Tag'
    * eval requestPayload[8].fieldVal = 0
    
    * eval requestPayload[9].fieldName = 'product_type_tags'
    * eval requestPayload[9].fieldDisplayName = 'Product type'
    * eval requestPayload[9].fieldVal = 0
    
    * eval requestPayload[10].fieldName = 'destination_country'
    * eval requestPayload[10].fieldDisplayName = 'Destination Country'
    * eval requestPayload[10].fieldVal = 0
    
    * eval requestPayload[11].fieldName = 'feature_data'
    * eval requestPayload[11].fieldDisplayName = 'Features'
    * eval requestPayload[11].fieldVal = 0
    
    * eval requestPayload[12].fieldName = 'internal_name'
    * eval requestPayload[12].fieldDisplayName = 'Internal Name'
    * eval requestPayload[12].fieldVal = 0
    
    * eval requestPayload[13].fieldName = 'conversion_rate'
    * eval requestPayload[13].fieldDisplayName = 'Conversion Rate'
    * eval requestPayload[13].fieldVal = 0
    
    * eval requestPayload[14].fieldName = 'click_thru_rate'
    * eval requestPayload[14].fieldDisplayName = 'Click Through Rate'
    * eval requestPayload[14].fieldVal = 0
    
    * eval requestPayload[15].fieldName = 'total_viewed'
    * eval requestPayload[15].fieldDisplayName = 'Impression'
    * eval requestPayload[15].fieldVal = 0
    
    * eval requestPayload[16].fieldName = 'listprice_inr'
    * eval requestPayload[16].fieldDisplayName = 'Website Price'
    * eval requestPayload[16].fieldVal = 0
    
    
    Given path '/indexfis/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
    
  @columbusRegression  
  #REV2-10291
  Scenario: PUT - Validate request for updating indexable attribute with valid data in fieldVal for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = 10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = 80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 0
    * eval requestPayload[6].fieldVal = 0
    * eval requestPayload[7].fieldVal = 0
    * eval requestPayload[8].fieldVal = 0
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-10292
  Scenario: PUT - Validate request for updating indexable attribute with negative data in fieldVal for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = -10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = -80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 0
    * eval requestPayload[6].fieldVal = 0
    * eval requestPayload[7].fieldVal = 0
    * eval requestPayload[8].fieldVal = 0
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')
    
    
  #REV2-10293
  Scenario: PUT - Validate request for updating indexable attribute with invalid data in fieldVal which sumation not equal to 100 for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = 10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = 80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 5
    * eval requestPayload[6].fieldVal = 5
    * eval requestPayload[7].fieldVal = 5
    * eval requestPayload[8].fieldVal = 5
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Index Fields Update Failed due to Bad data, Sum of all weightages should to be 100"
    And karate.log('Test Completed !')
    
    
  #REV2-10294
  Scenario: PUT - Validate request for updating indexable attribute with blank data in fieldVal for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = ''
    * eval requestPayload[1].fieldVal = ''
    * eval requestPayload[2].fieldVal = ''
    * eval requestPayload[3].fieldVal = ''
    * eval requestPayload[4].fieldVal = ''
    * eval requestPayload[5].fieldVal = ''
    * eval requestPayload[6].fieldVal = ''
    * eval requestPayload[7].fieldVal = ''
    * eval requestPayload[8].fieldVal = ''
    * eval requestPayload[9].fieldVal = ''
    * eval requestPayload[10].fieldVal = ''
    * eval requestPayload[11].fieldVal = ''
    * eval requestPayload[12].fieldVal = ''
    * eval requestPayload[13].fieldVal = ''
    * eval requestPayload[14].fieldVal = ''
    * eval requestPayload[15].fieldVal = ''
    * eval requestPayload[16].fieldVal = ''
    
    Given path '/indexfields/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Index Fields Update Failed due to Bad data, Sum of all weightages should to be 100"
    And karate.log('Test Completed !')
    
    
  #REV2-10295
  Scenario: PUT - Verify 404 error code for updating indexable attribute with valid data in fieldVal for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = 10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = 80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 0
    * eval requestPayload[6].fieldVal = 0
    * eval requestPayload[7].fieldVal = 0
    * eval requestPayload[8].fieldVal = 0
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/index/'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message == "http.request.not.found"
    And karate.log('Test Completed !')
    
    
  @columbusRegression    
  #REV2-10297
  Scenario: PUT - Validate request for updating reset indexable attribute with valid domainId for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = 10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = 80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 0
    * eval requestPayload[6].fieldVal = 0
    * eval requestPayload[7].fieldVal = 0
    * eval requestPayload[8].fieldVal = 0
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/indexfields/reset'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Test Completed !')
    
    
  #REV2-10298
  Scenario: PUT - Validate request for updating reset indexable attribute with invalid domainId for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = 10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = 80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 0
    * eval requestPayload[6].fieldVal = 0
    * eval requestPayload[7].fieldVal = 0
    * eval requestPayload[8].fieldVal = 0
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/indexfields/reset'
    And param domainId = invalidDomainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
   
  #REV2-10299
  Scenario: PUT - Validate request for updating reset indexable attribute with blank domainId for admin access role.	 
    
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    * eval requestPayload[0].fieldVal = 10
    * eval requestPayload[1].fieldVal = 5
    * eval requestPayload[2].fieldVal = 5
    * eval requestPayload[3].fieldVal = 80
    * eval requestPayload[4].fieldVal = 0
    * eval requestPayload[5].fieldVal = 0
    * eval requestPayload[6].fieldVal = 0
    * eval requestPayload[7].fieldVal = 0
    * eval requestPayload[8].fieldVal = 0
    * eval requestPayload[9].fieldVal = 0
    * eval requestPayload[10].fieldVal = 0
    * eval requestPayload[11].fieldVal = 0
    * eval requestPayload[12].fieldVal = 0
    * eval requestPayload[13].fieldVal = 0
    * eval requestPayload[14].fieldVal = 0
    * eval requestPayload[15].fieldVal = 0
    * eval requestPayload[16].fieldVal = 0
    
    Given path '/indexfields/reset'
    And param domainId = ''
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid domain Id"
    And karate.log('Test Completed !')
    
    
  #REV2-10300
  Scenario: PUT - Verify 404 error code for reset indexable attribute with valid domainId for admin access role.	 
      
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/index-attribute.json')
    
    Given path '/indexfields/set'
    And param domainId = domainId
    And request requestPayload
    And karate.log(requestPayload)
    When method put
    Then status 404
    And karate.log('Status : 404')
    And karate.log('Test Completed !')
    
    