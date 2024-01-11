@ignore
Feature: Create tag and reuse it.

	Background: 
		Given url backOfficeAPIBaseUrl
		* header Accept = 'application/json'
		* def today = new java.util.Date().time
		* def num = today + ""
		* def num = num.substring(6)
		* def tagName = 'tag-auto-'+num
		* def random_string =
         """
             function(s) {
		           var text = "";
		           var possible = "abcdefghijklmnopqrstuvwxyz";
		               
		               for (var i = 0; i < s; i++)
		                 text += possible.charAt(Math.floor(Math.random() * possible.length));
		           
		           return text;
             }
         """
     
		* def randomText =  random_string(8)
    * def domainTagName = 'tagauto' + randomText + ".com"
     
		
	#Take tagType and auth token as input and create new tag
	Scenario: Create new tag with all parameters
		* def requestPayload = read('classpath:com/fnp/api/backoffice/data/tags.json')
		* karate.log('Creating new tag with all parameters')
		* def tagType = __arg.tagType
		* def token = __arg.token
		
		* eval tagName = tagType == 'D' ? domainTagName : tagName
		
		* header Authorization = token
		
		* eval requestPayload.sequence = 1
		* eval requestPayload.tagName = tagName
		* eval requestPayload.tagTypeId = tagType
		* karate.log(requestPayload)
		
		Given path '/galleria/v1/tags'
		When request requestPayload
		And method post
		* def responseData = response
		* karate.log('********tag created into tag feature file*****************')
