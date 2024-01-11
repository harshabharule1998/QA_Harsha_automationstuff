Feature: Get created tag

  Background: 
    Given url backOfficeAPIBaseUrl
    * header Accept = 'application/json'
    * def tagId = __arg.tagId
    * def token = __arg.token
    * header Authorization = token

  Scenario: Get tag with id
    Given path '/galleria/v1/tags/tag'
    And param tagId = tagId
    * method get
    * def resData = response
