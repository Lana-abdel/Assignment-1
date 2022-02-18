require 'csv'
require './student.rb'
require './courses.rb'
class Easyenroll
  
  def get_students(studentInfo) 
    #this function will get and intialize student objects from the csv file with student info to be used when registering 
    students = []
    CSV.read(studentInfo, headers: true).each do |student|
      students <<  Student.new(id: student[0], year: student[1], completed_courses: student[2].split(', '),
      sems_left:student[3], desired_courses: student[4] , first: student[5], second: student[6], third: student[7])
    end
    students
  end
  
  def sort(array= get_students) 
    #this function sorts all the students by the priority, the sorted list will be printed for all the student information in output2.csv 
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
  
  def get_courses(courseInfo) 
    #this function get and intialize course objects from the csv file with course info to be used when registering 
    courses = {}
    CSV.read(courseInfo, headers: true).each do |course|
      num_sectionstest  = course[1].to_i
      courses[course[0]] = Course.new(number: course[0], sections: Array.new(num_sectionstest){ [] }, min: course[2].to_i, max: course[3].to_i, num_sections: num_sectionstest)
    end
    courses
  end
  
  def course_registration(studentInfo, courseInfo)
    #this function will create student and course objects register students in their courses 
    students= get_students(studentInfo)
    courses = get_courses(courseInfo)
    #will sort the students before we process the information 
    students = sort(students)
    #for each student we will enroll students in a course 
    students.each do |student|
      requested_courses = [student.first, student.second, student.third]
      enrolled = []
      requested_courses.each do |request|
        #check if already enrolled or if they have already been enrolled in 2 courses or if they had 0 as their desired number of courses 
        if enrolled.include?(request) || enrolled.length == 2 || student.desired_courses < "1"
          next
        end
        if try_enroll(courses, student, request)
          enrolled << request
          open_seats(courses,request)
        end #else append to a string
        runnable_class(courses,student,request)
      end
      File.write("output1.csv", "Student ID: #{student.id}\n Enrolled in : #{student.enrollments}\n Reason: N/A\n", mode: 'a')
    end
    print_output_files courses
  end
  def try_enroll (courses, student, courseNum) 
    #makes sure to add the student id for each section based on the max number of courses and makes sure that the course is also added to the students
    course = courses[courseNum]
    if course.nil?
      return false
    end
    #puts student.first
    for i in 0...course.sections.length
      section = course.sections[i]
      if (section.length < course.max)
        section << student.id
        student.enrollments << course.number + "-" + ("%02d" % (i + 1))  #add them into an array
        return true
      end
    end
    return false
  end
  def runnable_class  (courses, student, courseNum)
    #updates if a each section in a class is runnable or not based on if the section meets it's min requirements
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
  def open_seats (courses, courseNum)
    #keeps track of how many open seats there are in a section by looping through each course and each section and subtracting the max 
    course= courses[courseNum]
    if course.nil?
      return false
    end
    course.sections.each_with_index do |section, i| 
      course.open_sections[i] = course.max - course.sections[i].length 
    end
  end
  def print_output_files(courses)
    #creates the courses output file because it is hash we append the results to a string and print them out
    s = ""
    courses.each do |key,course|
      s += "Course Number: " + course.number
      if course.sections.length < 1
        s += "\nNo sections for this course\n"
      end
      course.sections.each_with_index do |section, i|
        s += "\n[Section " + ("%02d" % (i + 1)) + "]\n"
        s += "Number of open seats: " + course.open_sections[i].to_s + "\n"
        s += "Number of filled seats: " + section.length.to_s + "\n"
        s += "Student Ids in each section: " + section.join(', ') + "\n" 
        s += "Can Run? " + course.can_run[i].to_s + "\n"
      end
      s += "\n"
    end
    File.write("output2.csv", s , mode: 'w+')
  end
end
