Feature: validate DB connection using feature file
	
	Background:
	* url 'https://demourl'
	
	Scenario: Validate GET api status
	Given path 'path'
	When method get
	Then status 200
	Then print 'done'
	#Then print response.data.id == '#number'
	#Then print 'fuzzy matching pass'
	* def DbUtils = Java.type('com.fnp.api.utils.MySqlUtils')
	#assume mysql is db name
	* def db = new DbUtils('mysql') 
	Then print 'connection done'
	* def cities = db.readRows('SELECT * from city')
	Then print cities
	Then print cities[5].Name
	#fuzzy matching that name is string or number
	#Then match cities[5].Name == '#number' should fail
	Then match cities[5].Name == '#string'
	* def readSpecificRow = db.readRow('SELECT * FROM city where id = 4')
	Then print readSpecificRow
	* def readSpecificValue = db.readValue('SELECT name FROM world.city where id = 5')
	Then print readSpecificValue
	
	
	Scenario: mongodb test
	
	* def dbUtils = Java.type('com.fnp.api.utils.MongoDBUtils')
	# db is mongodb and collection name is student
	* def db = new dbUtils('mongodb', 'student') 
	* print 'connection done'
	
	# read all rows/documents from student table/collection 
	* def students = db.readAllRows()
	* print students
	
	# read row/document from student table/collection with name matching 'Tim Fish'
	* def student = db.readRowContainingFieldvalue(students, 'name', 'Tim Fish')
	* print student
	
	# read fieldValue of age for student having name 'Tim Fish' 
	* def fieldValue = db.readFieldValue(student, 'age')
	* print fieldValue
	
	
	