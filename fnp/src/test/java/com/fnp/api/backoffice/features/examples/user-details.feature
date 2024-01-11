Feature: check status return by api
	
	Background:
		* url 'demo url'
		# Use api domain url or apiBaseUrl from configuration
	 	* header Accept = 'application/json'
		
	@smoke @regression
	Scenario: Validate GET api status
		Given path '/api/users/2'
		When method get
		Then status 200
		Then print '*********Smoke test/regression done*************'
		
	@smoke
	Scenario: Validate GET api status
		Given path '/api/users/2'
		When method get
		Then status 200
		Then print '*********Smoke test 2 done*************'
		
	@ignore
	Scenario: Validate GET api status
		Given path '/api/users/2'
		When method get
		Then status 200
		Then print '*********Smoke test 3 ignore*************'