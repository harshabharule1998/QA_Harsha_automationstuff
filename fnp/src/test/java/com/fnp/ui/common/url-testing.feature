Feature: FNP URL Testing

	Background:
  	* configure driver = driverConfig
  	* def ArrayList = Java.type('java.util.ArrayList')
  	* def list = new ArrayList()
  	
  	* def writeToCSVFile =
  	"""
  		function(url, status) { 
  			var UrlStatusGeneratorUtils = Java.type('com.fnp.ui.common.UrlStatusGeneratorUtils')
  			var urlStatusGenerator = new UrlStatusGeneratorUtils('services2')
  			urlStatusGenerator.generateURLStatusData(url, status) 
  		}
  	"""
  	
  	* def readFromCSVFile =
  	"""
  		function(name) { 
  			var UrlStatusGeneratorUtils = Java.type('com.fnp.ui.common.UrlStatusGeneratorUtils')
  			var urlStatusGenerator = new UrlStatusGeneratorUtils(name)
  			list = urlStatusGenerator.readCSV(name) 
  			return list
  		}
  	"""
		
	#@smoke123	
	Scenario Outline: Verify url page has data
			
    Given driver '<url>'
    * delay(3000) 
    #And maximize()
    * def errorMsgImage = locateAll("div[class*='error-message'] img[src*='something-went-wrong.png']")
    * delay(1000)
    * def status = ""
    * karate.sizeOf(errorMsgImage) > 0 ? status = 'Not found' : status = 'Found'
		* delay(2000)
		* writeToCSVFile('<url>', status)
		
	  Examples:
	   | read('classpath:com/fnp/ui/backoffice/data/services.csv')|
	   
	   
	Scenario: Read url page data
				
    Given driver 'https://uat.fnp.com/article/7-types-of-flowering-plants-that-will-grow-in-every-weather'
    * delay(2000) 
    And maximize()
    * delay(2000) 
    * def errorMsgImage = locateAll("div[class*='error-message'] img[src*='something-went-wrong.png']")
    * delay(1000)
    * def status = ""
    * karate.sizeOf(errorMsgImage) > 0 ? status = 'Not found' : status = 'Found'
		* delay(2000)
		
		* def urlList = readFromCSVFile('articles')
		* karate.log(urlList)
		
		#* writeToCSVFile('<url>', status)
	