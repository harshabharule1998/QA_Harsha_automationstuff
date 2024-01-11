Feature: Tag Management Tag Manager CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    And path '/galleria/v1/tags'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagManager"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken

	@Regression
  #REV2-4034
  Scenario Outline: POST - Validate Tag Manager can create new tag with different tag types
    * def result = call read('../../common/create-tag.feature') {tagType: '<tagType>', token: "#(authToken)"}
    And match result.responseStatus == 201
    * def tagId = result.requestPayload.tagName
    * def result = call read('./tag-crud-tagmgr-test.feature@validateTagData') {tagId: "#(tagId)"}
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


  #REV2-4041
  Scenario: POST - Validate Tag Manager should not be able to create new tag with duplicate tag values
    * def result = call read('../../common/create-tag.feature') {tagType: 'G', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    * header Authorization = authToken
    # try creating tag with duplicate tag values
    And request result.requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    Then match response.errors[0].message == "Tag id already exists"
    And karate.log('Error message :', response.errors[0].message)
    And karate.log('Deleting created tag')
    And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ', tagId)
    And karate.log('Test Completed !')


  #REV2-4039
  # open bug : https://revvit2fnp.atlassian.net/browse/REV2-4109
  Scenario: POST - Validate Tag Manager should be able to create new tag with spaces in values
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(9)
    * def tagName = 'tag-auto-'+num
    # try creating tag with tag values having space
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = 1
    * eval requestPayload.tagName = " " + tagName + " "
    * eval requestPayload.tagTypeId = " G"
    #* def tagId = tagName
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    * def tagId = response.id
    And karate.log('Deleting created tag')
    And call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ', tagId)
    And karate.log('Test Completed !')


  #REV2-4038
  Scenario: POST- Validate Tag Manager should be not able to create new tag with invalid sequence value
    # try creating new tag with invalid sequence value
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = "123##"
    * eval requestPayload.tagName = "auto-123"
    * eval requestPayload.tagTypeId = "G"
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[0].message == "Invalid input data"
    And karate.log('Response is:', response.errors[0].message)
    And karate.log('Test Completed !')


  #REV2-4038
  Scenario: POST - Validate Tag Manager should be not able to create new tag with invalid tagName value
    # try creating new tag with invalid tagName value
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = "123"
    * eval requestPayload.tagName = "12345-com"
    * eval requestPayload.tagTypeId = "G"
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.message)
  #  And match response.message contains "createTag.tagCreateRequest.tagName: size must be between 1 and 100"
    And karate.log('Test Completed !')


  #REV2-4038
  Scenario: POST - Validate Tag Manager should be not able to create new tag with invalid tagType value
    # try creating new tag with invalid tagType value
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = "123"
    * eval requestPayload.tagName = "auto-123"
    * eval requestPayload.tagTypeId = "abc123"
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message == "Invalid tag type"
    And karate.log('Test Completed !')
    

  #REV2-4036
  Scenario: POST - Validate Tag Manager should not be able to create new tag with all blank parameters
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

  @Regression
  #REV2-4034
  Scenario: POST - Validate Tag Manager can create new tag with only required parameters
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


  #REV2-4035
  Scenario: POST - Validate Tag Manager should not be able to create new tag with only optional parameters
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

  @Regression
  #REV2-4032
  Scenario: GET - Validate Tag Manager can fetch tag with specific tagId
    * def result = call read('../../common/create-tag.feature') {tagType: 'O', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    * def getResponse = call read('../../common/get-tag.feature') {tagId: "#(tagId)"}
    Then getResponse.responseStatus == 200
    And match getResponse.tagId == "#(tagId)"
    And karate.log('Deleting created tag')
    * call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And karate.log('Tag is Deleted: ',tagId)
    And karate.log('Test Completed !')


  #REV2-4032
  Scenario: GET - Validate Tag Manager can fetch all tags and validate tagId is not null
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


  #REV2-4033
  Scenario: GET - Validate Tag Manager get error message while trying to delete tag with invalid tagid
    * def uuid = java.util.UUID.randomUUID().toString()
    * def randomTagId = uuid.substring(uuid.length()-4,uuid.length())
    And karate.log('Deleting tag with invalid tagId')
    * def result = call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(randomTagId)", token: "#(authToken)"}
    Then result.responseStatus == 400
    Then match result.resp.errors[0].message == 'Tag id does not exists'
    And karate.log('Test Completed !')


  #REV2-4045
  Scenario: DELETE - Validate Tag Manager cannot delete tag without token authorization
    * def uuid = java.util.UUID.randomUUID().toString()
    * def randomTagId = uuid.substring(uuid.length()-4,uuid.length())
    And karate.log('Deleting tag without token authorization')
    * def result = call read('classpath:com/fnp/api/backoffice/common/delete-tag.feature') {tagId:"#(randomTagId)", token: ""}
    Then result.responseStatus == 401
    And karate.log('Test Completed !')
    
  @Regression
  #REV2-4040
  Scenario: PUT - Validate Tag Manager can update tag sequence and comment
  
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    And karate.log('tagId is:', tagId)
    * header Authorization = authToken
    Given param tagId = tagId
    # updating tag sequence and comment
    * karate.log('updating tag sequence and comment')
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
    And karate.log('Status : 202',response)
    And karate.log('Response is:', response)
    And match response.message == "Tag updated successfully"
    
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


  #REV2-4043
  Scenario: PUT - Validate response message when Tag Manager updates existing tag with duplicate values
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    * header Authorization = authToken
    * def requestPayload =
      """
      {
      "comment": "New tag created",
      "isEnabled": true,
      "sequence": 1,
      "tagType": "PT"
      }
      """
    Given param tagId = tagId
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


  #REV2-4042
  Scenario: PUT - Validate Tag Manager cannot update existing tag with invalid values
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    * header Authorization = authToken
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
    Given param tagId = tagId
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

    
  @validateTagData
  Scenario: Validate created tag data
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