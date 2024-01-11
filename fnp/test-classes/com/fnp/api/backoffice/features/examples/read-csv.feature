Feature: karate answers 2
Background:
  * url 'demo url'
@regression
Scenario Outline: given id, validate email from same feature file
  Given path 'api/users/<id>'
  When method get
  Then status 200
  Then match response.data.email == '<email>'

  Examples:
   | read('classpath:com/fnp/api/backoffice/data/id.csv')|