require 'csv'
require './student.rb'
require './courses.rb'
require './easy_enroll.rb'
#delete the files when the program is rerun 
File.delete("./output1.csv") if File.exist?("./output1.csv")
File.delete("./output2.csv") if File.exist?("./output2.csv")
#create a easyenroll object and ask for file inputs 
enroll_students = Easyenroll.new
puts "Please enter the file name containing all student information "
studentInfo = gets.chomp   
puts "Please enter the file name containing all course information "
courseInfo = gets.chomp
#error handling if the files do not exist as the user to rerun and state the possible issues
if (File.exist?(studentInfo) && File.exist?(courseInfo) && File.file?(studentInfo) && File.file?(courseInfo)) 
    puts "the files exist and the program will proceed"
else 
    puts "the files either do not exit or are not in the correct format please rerun the program with file names in the current directory" 
    exit 
end  
#call course_registration
enroll_students.course_registration(studentInfo,courseInfo)

puts "The output files have been generated as\noutput1.csv: which includes the courses report
output2.csv: which includes the students report"