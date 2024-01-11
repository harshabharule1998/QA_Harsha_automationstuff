Feature: karate answers 2
Background:
  * url 'demo url'
@smoke
Scenario Outline: given id, validate email from same feature file
  Given path 'api/users/<id>'
  When method get
  Then status 200
  Then match response.data.email == '<email>'
  Examples:
    | id   | email 							 |
    | 2  	 | dummy1@email.com    |
    | 3    | dummy2@email.com 	 |
    | 4 	 | dummy13@email.com 	 |