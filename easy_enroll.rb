require 'csv'
require './student.rb'
require './courses.rb'
class Easyenroll

  def get_students(studentInfo)
    students = []
    CSV.read(studentInfo, headers: true).each do |student|
      students <<  Student.new(id: student[0], year: student[1], completed_courses: student[2].split(', '),
                               sems_left:student[3], desired_courses: student[4] , first: student[5], second: student[6], third: student[7])
    end
    students
  end

  def sort(array= get_students)
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
    courses = {}
    #courseInfo = gets.chomp
    CSV.read(courseInfo, headers: true).each do |course|
      num_sectionstest  = course[1].to_i
      courses[course[0]] = Course.new(number: course[0], sections: Array.new(num_sectionstest){ [] }, min: course[2].to_i, max: course[3].to_i, num_sections: num_sectionstest)
    end
    courses
  end

  def course_registration(studentInfo, courseInfo)
    students= get_students(studentInfo)
    courses = get_courses(courseInfo)
    students = sort(students)
    ###
    students.each do |student|
      requested_courses = [student.first, student.second, student.third]
      enrolled = []
      requested_courses.each do |request|
        #check if already enrolled
        if enrolled.include?(request)
          next
        end
        if try_enroll(courses, student, request)
          enrolled << request
          open_seats(courses,request)
          #print_output_files(courses,student,request)
        end #else append to a string
        runnable_class(courses,student,request)
      end
      File.write("output1.csv", "Student ID: #{student.id}\n Enrolled in : #{student.enrollments}\n Reason: N/A\n", mode: 'a')
    end
    print_output_files courses
    #File.write("output1.csv", "Student ID: #{student.id}\n Enrolled in : #{student.enrollments}\n Reason: N/A\n", mode: 'a')
    #print_output_files
    #students
    #courses
  end
  def try_enroll (courses, student, courseNum)
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
      else
        break
      end
    end
    return false
  end
  def runnable_class  (courses, student, courseNum)
    course = courses[courseNum]
    if course.nil?
      return false
    end
    for i in 0...courses.length
      if (course.sections.length < course.min)
        course.can_run = false
        return true
      else
        course.can_run = true
      end
      return false
    end
  end
  def open_seats (courses, courseNum)
    ####doesn't loop through the number of students in a section
    course= courses[courseNum]
    if course.nil?
      return false
    end
    course.sections.each_with_index do |section, i| #for the length of each section
      course.open_sections[i] = course.max - course.sections[i].length  #for i in 0...students.length #section = course.sections[i] #for the students in that section
      #course.seats_open = course.max - course.sections[i].length  #subtract the max from the length of the section
    end
  end
  def print_output_files(courses)
    s = ""
    courses.each do |key,course|
      s += "Course Number: " + course.number
      s += "\nCan Run? " + course.can_run.to_s
      if course.sections.length < 1
        s += "\nNo sections for this course\n"
      end
      course.sections.each_with_index do |section, i|
        s += "\n[Section " + ("%02d" % (i + 1)) + "]\n"
        s += "Number of open seats: " + course.open_sections[i].to_s + "\n"
        s += "Number of filled seats: " + section.length.to_s + "\n"
        s += "Student Ids in each section: " + section.join(', ') + "\n"
      end
      s += "\n"
    end
    File.write("output2.csv", s , mode: 'w+')
  end
end

File.delete("./output1.csv") if File.exist?("./output1.csv")
File.delete("./output2.csv") if File.exist?("./output2.csv")
enroll_students = Easyenroll.new
puts "Please enter the file name containing all student information "
studentInfo = gets.chomp   
#enroll_students.get_students
puts "Please enter the file name containing all course information "
courseInfo = gets.chomp
enroll_students.course_registration(studentInfo,courseInfo)

puts "The output files have been generated as (output1.csv and output2.csv)"
