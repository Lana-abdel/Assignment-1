=begin 
#Project name: Assignment-1  
#Description: Implementing an easy_esnroll application based on two input files student_prefs and course_constraints. The 
application will create a plan to enroll students into courses based on their prefences and other constraints. 
#Filename: Main.rb 
#Description: Here we do error handling, create an easy_enroll object and call the course_registration function to register students 
into courses 
#Last modified on: 03-21-2022
=end 
require 'csv'
require './student.rb'
require './courses.rb'
require './easy_enroll.rb'

def main 
    #delete the files when the program is rerun   
    File.delete("./output1.csv") if File.exist?("./output1.csv")
    File.delete("./output2.csv") if File.exist?("./output2.csv")

    #call the enrollment function which takes in two parameters for the file names
    run_enrollment(file_check_student,file_check_course)
end 

=begin
this function checks the first parameter for the run_enrollment function 
if the file name exists for student information then we proceed 
otherwise it prompts the user for another file name 
=end 
def file_check_student
    puts "Please enter the file name containing all student information\n"
    studentInfo= gets.chomp
    while true
        if File.exist?(studentInfo) && File.file?(studentInfo)
            puts "The files exist and the program will proceed"
            puts studentInfo
            return studentInfo
            break 
        else 
            puts "An error occurred try again. Please enter the file name containing all student information."  
            studentInfo = gets.chomp
            if File.exist?(studentInfo) && File.file?(studentInfo)
                return studentInfo
            end 
            next
        end
    end
end  

=begin
this function checks the second parameter for the run_enrollment function 
if the file name exists for course information then we proceed 
otherwise it prompts the user for another file name 
=end 
def file_check_course
    puts "Please enter the file name containing all course information\n"
    courseInfo= gets.chomp
    while true
        if File.exist?(courseInfo) && File.file?(courseInfo)
            puts "The files exist and the program will proceed"
            return courseInfo
            break 
        else 
            puts "An error occurred try again. Please enter the file name containing all course information."  
            courseInfo = gets.chomp
            if File.exist?(courseInfo) && File.file?(courseInfo)
                return courseInfo
            end 
            next
        end
    end
end 

=begin
This is the run_enrollment function which creates an Easyenroll object 
then calls the course_registeration function from the easy_enroll.rb file
=end 
def run_enrollment(studentInfo,courseInfo)
    puts "Please write the output csv filename for student info\n" 
    studentOut= gets.chomp
    puts "Please write the output csv filename for course info\n"
    courseOut = gets.chomp 
    puts "The output files have been generated as: #{studentOut} and #{courseOut}"
    File.write(studentOut, "Student ID,  Enrolled in , Reason\n" , mode: 'w+')
    enroll_students = Easyenroll.new
    return enroll_students.course_registration(studentInfo,courseInfo,studentOut,courseOut)
end 
main()