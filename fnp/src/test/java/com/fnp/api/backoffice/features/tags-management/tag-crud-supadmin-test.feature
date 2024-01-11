Feature: Tag Management Super Admin CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/tags'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"superAdminQA"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken

	@Regression
  #REV2-3308
  #REV2-3324
  Scenario Outline: Validate Super Admin can create new tag with different tag types
    * def result = call read('../../common/create-tag.feature') {tagType: '<tagType>', token: "#(authToken)"}
    And match result.responseStatus == 201
    And match result.tagName == result.requestPayload.tagName
    * def tagId = result.requestPayload.tagName
    * def result = call read('./tag-crud-supadmin-test.feature@validateAndDeleteTag') {tagId: "#(tagId)"}
    And match result.deleteResponse.message == 'Tag deleted successfully'
    And karate.log('created tag is deleted')
    * karate.log('Test Completed !')

    Examples: 
      | tagType |
      | G       |
      | PT      |
 			| O       |
 			| C       |
 			| R       |
      
	@Regression
  #REV2-3308
  Scenario: POST - Validate Super Admin can create new tag with only required parameters
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(9)
    * def tagName = 'tag-auto-'+num
    * def tagTypeId = 'PT'
    * karate.log('Creating new tag with only required parameters')
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.tagName = tagName
    * eval requestPayload.tagTypeId = tagTypeId
    * karate.log(requestPayload)
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    Then response.message == 'Tag created successfully'
    * def result = call read('./tag-crud-supadmin-test.feature@validateAndDeleteTag') {tagId: "#(tagName)", token: "#(authToken)"}
    And match result.deleteResponse.message == 'Tag deleted successfully'
    * karate.log('Test Completed !')

	
  #REV2-3309
  Scenario: POST - Validate Super Admin should not be able to create new tag with only optional parameters
    * karate.log('Creating new tag with only optional parameters')
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = 1
    * karate.log(requestPayload)
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Tag type id should not be empty"
    And match response.errors[*].message contains "Tag name should not be empty"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Error message :', response.errors[1].message)
    And karate.log('Test Completed !')
    

  #REV2-3310
  Scenario: POST - Validate Super Admin should not be able to create new tag with all blank parameters
    * karate.log('Creating new tag with all blank parameters')
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * karate.log(requestPayload)
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Tag type id should not be empty"
    And match response.errors[*].message contains "Tag name should not be empty"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Error message :', response.errors[1].message)
    And karate.log('Test Completed !')


  #REV2-3318
  Scenario: POST - Validate Super Admin should not be able to create new tag with existing tag values
    * def result = call read('../../common/create-tag.feature') {tagType: 'G', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    * header Authorization = authToken
    # try creating tag with existing tag values
    And request result.requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Tag id already exists"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Deleting created tag')
    And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ', tagId)
    And karate.log('Test Completed !')


  #REV2-3318
  Scenario: POST - Validate Super Admin should not be able to create new tag with existing tag values having space as suffix
    * def result = call read('../../common/create-tag.feature') {tagType: 'G', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    # try creating tag payload with existing tag values having space as suffix
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = result.requestPayload.sequence + " "
    * eval requestPayload.tagName = result.requestPayload.tagName + " "
    * eval requestPayload.tagType = result.requestPayload.tagType + " "
    * karate.log(requestPayload)
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Tag type id should not be empty"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Deleting created tag')
    And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ', tagId)
    And karate.log('Test Completed !')


  Scenario: POST - Validate Super Admin should not be able to create new tag with existing tag values having space as prefix
    * def result = call read('../../common/create-tag.feature') {tagType: 'G', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    # try creating tag payload with existing tag values having space as prefix
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = " " + result.requestPayload.sequence
    * eval requestPayload.tagName = " " + result.requestPayload.tagName
    * eval requestPayload.tagType = " " + result.requestPayload.tagType
    * karate.log(requestPayload)
    * header Authorization = authToken
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Tag type id should not be empty"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Deleting created tag')
    And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ', tagId)
    And karate.log('Test Completed !')

  @Regression
  #REV2-3306
  Scenario: GET - Validate Super Admin can get all created tags and validate it is not null
    * param pageNumber = 0
    * param pageSize = 20
    * param sortDirection = 'ASC'
    * param sortField = 'sequence'
    When method get
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Validated tagId should not be null')
    And match each response.data contains { tagId: '#notnull'}
    And karate.log('Test Completed !')

  @Regression
  #REV2-3307
  Scenario: GET - Validate Super Admin can fetch tag with specific tagId
    * def result = call read('../../common/create-tag.feature') {tagType: 'O', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    * def getResponse = call read('../../common/get-tag.feature') {tagId: "#(tagId)"}
    Then getResponse.responseStatus == 200
    And match getResponse.tagId == "#(tagId)"
    And karate.log('Deleting created tag')
    * call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ',tagId)
    And karate.log('Test Completed !')


  Scenario: GET - Validate system throws error for while try to fetch invalid tagid
  
    * def uuid = java.util.UUID.randomUUID().toString()
    * def getRandomTagId = uuid.substring(uuid.length()-4,uuid.length())
  
    Given path '/categoryservice/v1/tags/'+getRandomTagId
    And method get
    Then status 404
    And karate.log('Status : 404')
    And match response.errors[0].message contains "http.request.not.found"
    And karate.log('Error message :', response.error)
    And karate.log('Test Completed !')

  @Regression
  #REV2-3324
  Scenario: PUT - Validate Super Admin can disable newly created tag with tag type as PT and delete it
  
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    And karate.log('tagId is:', tagId)
    * header Authorization = authToken
    Given param tagId = tagId
    * def requestPayload =
      """
      {
      "comment": "tag disabled",
      "isEnabled": false,
      "sequence": 1,
      "tagType": "PT"
      }
      """
    When request requestPayload
    * method put
    * status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message == "Tag updated successfully"
    And karate.log('Response message :', response.message)
    And karate.log('Deleting created tag')
    * call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ',tagId)
    And karate.log('Test Completed !')

 
  #REV2-3321
  Scenario: PUT - Validate Super Admin can update existing tag sequence
  
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    And karate.log('tagId is:', tagId)
    * header Authorization = authToken
    Given param tagId = tagId
    # updating tag sequence
    * karate.log('updating tag sequence...')
    * def requestPayload =
      """
      {
      "comment": "updating tag sequence",
      "isEnabled": true,
      "sequence": 5,
      "tagType": "PT"
      }
      """
    When request requestPayload
    * method put
    * status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message == "Tag updated successfully"
    And karate.log('Response message :', response.message)
    And karate.log('Deleting created tag')
    * call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ',tagId)
    And karate.log('Test Completed !')


  Scenario: PUT - Validate response message when Super Admin updates existing tag with duplicate values
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    * header Authorization = authToken
    Given param tagId = tagId
    * def requestPayload =
      """
      {
      "comment": "New tag created",
      "isEnabled": true,
      "sequence": 1,
      "tagType": "PT"
      }
      """
    When request requestPayload
    And method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Update Response is:', response.message)
    And match response.message == "There is nothing to update"
    
    # update tag with duplicate values
    * header Authorization = authToken
    Given path '/galleria/v1/tags'
    And param tagId = tagId
    When request requestPayload
    And method put
    Then status 200
    And karate.log('Status : 200')
    And karate.log('Update Response is:', response.message)
    And match response.message == "There is nothing to update"
    
    And karate.log('Deleting created tag')
    * call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ',tagId)
    And karate.log('Test Completed !')


  #REV2-3321
  Scenario: PUT - Validate Super Admin cannot update existing tag with invalid values
  
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    * header Authorization = authToken
    Given param tagId = tagId
    # updating tag sequence with invalid value
    * def requestPayload =
      """
      {
      "comment": "New tag created",
      "isEnabled": true,
      "sequence": "abc",
      "tagType": "PT"
      }
      """
    * karate.log('updating tag sequence with invalid value')
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Deleting created tag')
    * call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ',tagId)
    And karate.log('Test Completed !')
    
    
  @validateAndDeleteTag
  Scenario: Validate and delete created tag
    * def tagId = __arg.tagId
    * def tagData = call read('../../common/get-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And match tagData.resData.id == tagId
    And match tagData.resData.isEnabled == true
    And match tagData.resData.workFlowStatus == "APPROVED"
    And karate.log('Created tag validated successfully !')
    And karate.log('Fetched tag :', tagData.resData)
    And karate.log('Deleting created tag')
    And def data = call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And match data.responseStatus == 200
    * def deleteResponse = data.resp
    And karate.log('Tag is Deleted: ', tagId)
    
