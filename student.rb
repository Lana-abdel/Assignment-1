=begin 
#Project name: Assignment-1  
#Description: Implementing an easy_enroll application based on two input files student_prefs and course_constraints. The 
application will create a plan to enroll students into courses based on their prefences and other constraints. 
#Filename: student.rb 
#Description: This is a class that defines what a student is . The students have certain attributes associated  with them such as
priority, id, semesters left that are modified and/or access to help with constraints when registering a student and outputting 
the information into a file. 
#Last modified on: 03-21-2022
=end 

class Student 

	attr_accessor :id, :year, :completed_courses, :sems_left, :desired_courses , :first, :second, :third, :enrollments, :priority, :reason
=begin 
These are set values that static across all class instances, because they 
should not be changed. The number 20 starts off our initial priority for 
every student. It was picked arbitrarily because the aim was to start with
a high enough number. The other numbers were based on seniority. 
For example we are assuming freshman do not get any advantage but 
sophmores do so we add 1 one to their priority etc.
=end 
	@@priority_initial = 20 
	@@priority_senior = 3
	@@priority_junior = 2
	@@priority_sophomore = 1
	
=begin 
This function is necessary because allows us to create instances of the
student object 
=end 
	def initialize(id:, year:, completed_courses:, sems_left:, desired_courses: , first:, second:, third:) # defining Student.new
		@id = id 
		@year = year.strip
		@completed_courses = completed_courses
		@sems_left = sems_left 
		@desired_courses = desired_courses
		@first= first.strip
		@second = second.strip
		@third = third.strip
		@enrollments = []
		@priority = set_priority 
		@reason = "N/A"
	end 

=begin 
This function sets the priority for each student. It determines the priority 
based on seniority, list of courses taken, if they don't pick 3 choices, 
semesters left
=end 
	def set_priority    
		priority = @@priority_initial 
		priority -= @sems_left.to_i 
		if @year == 'Senior' 
			priority += @@priority_senior 
		elsif @year == 'Junior'
			priority += @@priority_junior 
		elsif @year == 'Sophomore'
			priority+= @@priority_sophomore
		else 
			priority 
		end 
		priority += @completed_courses.count 
		priority - count  
	end 

=begin 
This function is used to help set the priority. It calculates
 if a student has picked three choices or not
=end 
	def count 
		choices = [@first_choice, @second_choice, @third_choice] 
		choices.select{ |choice| choice == "N/A"}.count  
	end 
end 
