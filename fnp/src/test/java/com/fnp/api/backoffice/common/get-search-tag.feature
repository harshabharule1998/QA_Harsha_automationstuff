@ignore
Feature: Get created tag
	 
	Background: 
		Given url 'https://api-test-r2.fnp.com' 
		* header Accept = 'application/json'
		* def tagParam = __arg.tagParam
	
	Scenario: Get tag with id and name
		Given path 'categoryservice/v1/tags/search-simple'
		And param tag_id_or_name = tagParam
		* method get
		
	   
	

