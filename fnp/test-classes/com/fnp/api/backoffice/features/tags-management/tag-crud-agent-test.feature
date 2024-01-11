Feature: Tag Management Tag Agent CRUD feature

  Background: 
    Given url backOfficeAPIBaseUrl
    And header Accept = 'application/json'
    * def loginResult = callonce read('classpath:com/fnp/api/utils/generate-token.feature') {userType:"tagAgent"}
    * def authToken = loginResult.accessToken
    * header Authorization = authToken
    Given path '/galleria/v1/tags'

  @validateTagData
  Scenario: Validate created tag data
    * def tagId = __arg.tagId
    * def tagData = call read('../../common/get-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    And match tagData.resData.id == tagId
    And match tagData.resData.isEnabled == true
    And match tagData.resData.workFlowStatus == "APPROVED"
    And karate.log('Created tag validated successfully !')
    And karate.log('Fetched tag :', tagData.resData)

  @Regression
  #REV2-4054
  Scenario Outline: POST - Validate Tag Agent can create new tag with different tag types
    * def result = call read('../../common/create-tag.feature') {tagType: '<tagType>', token: "#(authToken)"}
    And match result.responseStatus == 201
    * def tagId = result.requestPayload.tagName
    * def result = call read('./tag-crud-agent-test.feature@validateTagData') {tagId: "#(tagId)"}
    * karate.log('Test Completed !')

    Examples: 
      | tagType |
      | G       |
      | PT      |
      | O       |
      | C       |
      | R       |


  #REV2-4057
  Scenario: POST - Validate Tag Agent should not be able to create new tag with duplicate tag values
    * def result = call read('../../common/create-tag.feature') {tagType: 'G', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    # try creating tag with duplicate tag values
    And request result.requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    Then match response.errors[0].message == 'Tag id already exists'
    And karate.log('Test Completed !')


  #REV2-4059
  # open bug : https://revvit2fnp.atlassian.net/browse/REV2-4109
  Scenario: POST - Validate Tag Agent should be able to create new tag with tag values having space
    * def today = new java.util.Date().time
    * def num = today + ""
    * def num = num.substring(9)
    * def tagName = 'tag-auto-'+num
    # try creating tag with tag values having space
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = 1
    * eval requestPayload.tagName = " " + tagName + " "
    * eval requestPayload.tagType = " G"
    * def tagId = tagName
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Test Completed !')


  #REV2-4058
  Scenario: POST - Validate Tag Agent should be not able to create new tag with invalid sequence value
    # try creating new tag with invalid sequence value
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = "123##"
    * eval requestPayload.tagName = "auto-123"
    * eval requestPayload.tagType = "G"
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And match response.errors[0].message contains "Invalid input data"
    And karate.log('Test Completed !')


  #REV2-4058
  Scenario: Validate Tag Agent should be not able to create new tag with invalid tagName value
    # try creating new tag with invalid tagName value
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = "123"
    * eval requestPayload.tagName = "123-com"
    * eval requestPayload.tagTypeId = "G"
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.errors[0].message)
    And karate.log('Test Completed !')


  #REV2-4058
  Scenario: POST - Validate Tag Agent should be not able to create new tag with invalid tagType value
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


  #REV2-4056
  Scenario: POST - Validate Tag Agent should not be able to create new tag with all blank parameters
    * karate.log('Creating new tag with all blank parameters')
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Tag type id should not be empty"
    And match response.errors[*].message contains "Tag name should not be empty"
    And karate.log('Test Completed !')

  @Regression
  #REV2-4054
  Scenario: POST - Validate Tag Agent can create new tag with only required parameters
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
    And request requestPayload
    When method post
    Then status 201
    And karate.log('Status : 201')
    Then response.message == 'Tag create successfully'
    * def result = call read('./tag-crud-agent-test.feature@validateTagData') {tagId: "#(tagName)", token: "#(authToken)"}
    * karate.log('Test Completed !')


  #REV2-4055
  Scenario: POST - Validate Tag Agent should not be able to create new tag with only optional parameters
    * karate.log('Creating new tag with only optional parameters')
    * def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
    * eval requestPayload.sequence = 1
    * karate.log(requestPayload)
    And request requestPayload
    When method post
    Then status 400
    And karate.log('Status : 400')
    And match response.errors[*].message contains "Tag type id should not be empty"
    And match response.errors[*].message contains "Tag name should not be empty"
    And karate.log('Test Completed !')

  @Regression
  #REV2-4053
  Scenario: GET - Validate Tag Agent can fetch tag with specific tagId
    * def result = call read('../../common/create-tag.feature') {tagType: 'O', token: "#(authToken)"}
    * def tagId = result.requestPayload.tagName
    * def getResponse = call read('../../common/get-tag.feature') {tagId: "#(tagId)"}
    Then getResponse.responseStatus == 200
    And match getResponse.tagId == "#(tagId)"
    And karate.log('Test Completed !')


  #REV2-4063
  Scenario: PUT - Validate Tag Agent should not be able to enable newly created tag
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    And karate.log('tagId is:', tagId)
    Given param tagId = tagId
    # updating tag sequence and comment
    * karate.log('updating tag sequence and comment')
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
    * method put
    * status 200
    And karate.log('Status : 200')
    And karate.log('Response is:', response)
    And match response.message == "There is nothing to update"
    And karate.log('Response message :', response.message)
    And karate.log('Test Completed !')

  @Regression
  #REV2-4060
  Scenario: PUT - Verify Method: PUT with Tag Agent with Edit permission access - Update with Valid data
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    And karate.log('tagId is:', tagId)
    Given param tagId = tagId
    # updating tag sequence and comment
    * karate.log('updating tag sequence and comment')
    * def requestPayload =
      """
      {
      "comment": "updating tag sequence",
      "isEnabled": false,
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
    And karate.log('Test Completed !')


  #REV2-4061
  Scenario: PUT - Validate response message when Tag Agent updates existing tag with duplicate values
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    Given param tagId = tagId
    * def requestPayload =
      """
      {
      "comment": "New tag created",
      "isEnabled": false,
      "sequence": 1,
      "tagType": "PT"
      }
      """
    When request requestPayload
    And method put
    Then status 202
    And karate.log('Status : 202')
    And karate.log('Response is:', response)
    And match response.message == "Tag updated successfully"
    And karate.log('Test Completed !')


  #REV2-4062
  Scenario: PUT - Validate Tag Agent cannot update existing tag with invalid values
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    Given param tagId = tagId
    # updating tag sequence with invalid value
    * def requestPayload =
      """
      {
      "comment": "New tag created",
      "isEnabled": false,
      "sequence": "abc",
      "tagType": "PT"
      }
      """
    * karate.log('updating tag sequence with invalid value')
    When request requestPayload
    And method put
    Then status 400
    And karate.log('Status : 400')
    And karate.log('Response is:', response.message)
    And match response.errors[0]message contains "Invalid input data"
    And karate.log('Test Completed !')

 @Regression
 #REV2-4065
  Scenario: DELETE - Validate Tag Agent cannot delete tag
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    * karate.log('Trying to delete created tag')
    * def data = call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    * match data.responseStatus == 403
    * karate.log('Tag Agent unable to delete created tag with id : ', tagId)
    
   @Regression
      #REV2-4051 
      Scenario: DELETE with Tag Agent with View permission access
    * def result = call read('classpath:com/fnp/api/backoffice/common/create-tag.feature') {tagType: 'PT', token: "#(authToken)"}
    * karate.log('Tag created : ', result.requestPayload)
    * def tagId = result.requestPayload.tagName
    * karate.log('tagId is:', tagId)
    * karate.log('Trying to delete created tag')
    * def data = call read('../../common/delete-tag.feature') {tagId:"#(tagId)", token: "#(authToken)"}
    * match data.responseStatus == 403
    * karate.log('Tag Agent unable to delete created tag with id : ', tagId)
