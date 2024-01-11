@ignore
Feature: Delete created tag

  Background: 
    Given url backOfficeAPIBaseUrl
    * header Accept = 'application/json'
    * def tagId = __arg.tagId
    * def token = __arg.token
    * header Authorization = token

  Scenario: Delete created tag on another featuere
    Given path '/galleria/v1/tags'
    And param tagId = tagId
    * method delete
    * def resp = response
