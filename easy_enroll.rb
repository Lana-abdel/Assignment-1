=begin 
#Project name: Assignment-1  
#Description: Implementing an easy_enroll application based on two input files student_prefs and course_constraints. The 
application will create a plan to enroll students into courses based on their prefences and other constraints. 
#Filename: easy_enroll.rb 
#Description: This file has the functions that read in the file data and store the information into an appropriate data 
structure, handle course registration, outputting into files, sorting, calculating if there are open seats and if a class 
can run. 
#Last modified on: 03-21-2022
=end 

require 'csv'
require './student.rb'
require './courses.rb'
class Easyenroll
    
=begin 
this function will get and intialize student objects from the csv file 
of the student info (passed as a parameter) to be used when registering.
We read in the students into and array
=end 
    def get_students(studentInfo) 
        students = []
        CSV.read(studentInfo, headers: true).each do |student|
            students <<  Student.new(id: student[0], year: student[1], completed_courses: student[2].split(', '),
            sems_left:student[3], desired_courses: student[4] , first: student[5], second: student[6], third: student[7])
        end
        students
    end
    
=begin 
this function sorts all the students by the priority (student array is passed as parameter), the sorted list will be 
printed for all the student information in the student output file. We then return the
sorted array 
=end 
    def sort(array) 
        for i in 1...(array.length)
            j = i
            while j > 0
                if array[j-1].priority < array[j].priority
                    temp = array[j]
                    array[j] = array[j-1]
                    array[j-1] = temp
                else
                    break
                end
                j = j - 1
            end
        end
        return array
    end

=begin 
this function gets and intialize course objects from the csv file with 
course info (passed as a parameter) to be used when registering. 
We read in the courses into a hash. 
=end 
    def get_courses(courseInfo) 
        courses = {}
        CSV.read(courseInfo, headers: true).each do |course|
            num_sectionstest  = course[1].to_i
            courses[course[0]] = Course.new(number: course[0], sections: Array.new(num_sectionstest){ [] }, min: course[2].to_i, max: course[3].to_i, num_sections: num_sectionstest)
        end
        courses
    end
    
=begin 
this function will create student and course objects. It is a helper function
with only one purpose to call functions that sort students and enroll students
=end 
    def course_registration(studentInfo, courseInfo, output1, output2)
        
        students= get_students(studentInfo)
        courses = get_courses(courseInfo)
        students = sort(students)
        enroll_students(students,courses,output1, output2)
    end 
    
=begin
This function enrolls students into their courses by adding student id's for each section as long as we are less than the max 
and in an attempt to balance the sections the student section can run only until the section's length is greater than the min. 
This function adds the course to the list of student enrollments and adds the student to the course's section. The function
takes the course and student object created as well as the requested course for the student as parameters. It returns true if the 
registration was successful. 
=end 
    def try_enroll (courses, student, courseNum) 
        #makes sure to add the student id for each section based on the max number of courses and makes sure that the course is also added to the students
        course = courses[courseNum]
        if course.nil?
            return false
        end
        for i in 0...course.sections.length
            section = course.sections[i]
            if (section.length < course.max) 
                until (section.length > course.min) 
                    section << student.id #add the student id into the section 
                    student.enrollments << course.number + "-" + ("%02d" % (i + 1)) #add the course into the student's enrollements 
                    return true
                end 
            end
        end
        return false
    end
    
=begin
updates if a each section in a class is runnable or not based on if the section meets it's min requirements. 
The function takes the course and student objects created well as the requested course for the student as parameters.
=end 
    def runnable_class (courses, student, courseNum)
        
        course = courses[courseNum]
        if course.nil?
            return false
        end
        course.sections.each_with_index do |section, i| 
            if (course.sections[i].length.to_i < course.min)
                course.can_run[i] = false 
            else
                course.can_run[i] = true 
            end
        end
    end
    
=begin
This function keeps track of how many open seats there are in a section by 
looping through each course and each section and subtracting the max. The function
takes the course object created as well as the requested course for the student as parameters.
=end 
    def open_seats (courses, courseNum)
        course= courses[courseNum]
        if course.nil?
            return false
        end
        course.sections.each_with_index do |section, i| 
            course.open_sections[i] = course.max - course.sections[i].length 
        end
    end

=begin
This function prints out the course information into an output file. Since the courses 
are stored in a hash we have to initialize a string and loop through to access and append
the values of the hash to. This must be done in order to output the values of 
the hash into an output file. The function takes the course object created as well as the output file
 name as parameters. 
=end
    def print_course_output(courses,output2)
        s = "Course Number, Section, Student ID in Section, Number of Filled Seats, Number of Open Seats, Can Run? \n"
        
        #for each course and each section append the appropriate values to the output file
        courses.each do |key,course|  
            if course.sections.length < 1
                s += course.number + ", "
                s += "0, N/A, N/A, N/A, false\n" 
                next
            end
            course.sections.each_with_index do |section, i|
                s +=  course.number + ", "
                s +=  ("%02d" % (i + 1)) + ", "
                if section.length < 1 
                    s += "0 ,"
                else
                    s +=  "\"#{section.join(', ')}\"" + ", " 
                end 
                s += section.length.to_s + ", "
                s += course.open_sections[i].to_s  + ", "
                s += course.can_run[i].to_s 
                s += "\n"
            end
        end
        File.write(output2, s , mode: 'w+')
    end 
    
=begin
This function updates the reason that a student couldn't get into a course, if they couldn't get their desired 
number of courses or weren't enrolled into anything then the reason changes from N/A. If the student 
listed their desired number of courses as 0 then they get a different reason. The function takes the student object and
the student's enrolled courses and the output file name as a parameters. 
=end 
    def reason_update(student, enrolled, output1)
        if  enrolled.length != student.desired_courses.to_i || enrolled.length == 0
            student.reason = "course or courses were not available" 
        end 
        if student.desired_courses < "1"
            student.reason = "you listed 0 as your desired number of courses"
        end 
        if student.enrollments.length < 1 
            student.enrollments << "N/A"
        end 
        File.write(output1, "#{student.id} ,  #{student.enrollments.join(",")},  #{student.reason}\n", mode: 'a') 
    end 
        
=begin
This function only functionality is to enroll all students by calling
easy_enroll, open_seats, runnable_class, reason_update, print_course_output. 
The function takes the course and student objects created as parameters well as the two output file names 
that the user was prompted to give. 
=end 
    def enroll_students(students,courses, output1, output2)
        students.each do |student|
            requested_courses = [student.first, student.second, student.third]
            enrolled = []
            requested_courses.each do |request|
                #check if already enrolled or if they have already been enrolled in 2 courses or if they had 0 as their desired number of courses 
                if enrolled.include?(request) || enrolled.length == 2 || student.desired_courses < "1" || (enrolled.length == 1 && student.desired_courses == "1")
                    next
                end 
                if try_enroll(courses, student, request) #try to enroll the student
                    enrolled << request  #if it was successful update the enrolled array 
                    open_seats(courses,request) #calculate open seats 
                end 
                runnable_class(courses,student,request) #check if class can run 
            end 
            reason_update(student, enrolled, output1) #update the reason for the student 
        end
        print_course_output(courses, output2) #call the print function for courses 
    end 
end 
    
