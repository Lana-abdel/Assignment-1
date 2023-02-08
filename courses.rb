=begin 
#Project name: Assignment-1  
#Description: Implementing an easy_enroll application based on two input files student_prefs and course_constraints. The 
application will create a plan to enroll students into courses based on their prefences and other constraints. 
#Filename: courses.rb 
#Description: This is a class that defines a course. The courses have certain attributes associated with them such as
number of sections and the course number. These attributes may be modified and/or access to help with constraints when
registering a student and outputting the information into a file. 
#Last modified on: 03-21-2022
=end 

class Course
	#class course that initializes a course object
	attr_accessor :number, :sections, :min, :max , :num_sections , :can_run, :seats_open, :open_sections 

=begin
This function is necessary because allows us to create instances of the class
object
=end
	def initialize(number:, sections:, min:, max:, num_sections:)
		@number= number.strip
		@sections= sections 
		@min= min 
		@max= max
		@num_sections = num_sections 
		@can_run = {}
		@seats_open = max 
		@open_sections = {}
	end 
end
