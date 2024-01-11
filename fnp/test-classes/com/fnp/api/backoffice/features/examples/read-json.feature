Feature: read json file

Background:
	* url 'dmummy url'
	* def empList = read('../../data/emp.json')
	
@smoke
Scenario: validate email from jsonfile store
	
	* def empId = empList.emp[0].id
	* def email = empList.emp[0].email
	
	Given path 'api/users/',empId
  When method get
  Then status 200
  Then match response.data.email == email
