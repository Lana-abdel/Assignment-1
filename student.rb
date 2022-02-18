class Student 
    attr_accessor :id, :year, :completed_courses, :sems_left, :desired_courses , :first, :second, :third, :enrollments, :priority  

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
    end 
    def set_priority    
        priority = 20 
        priority -= @sems_left.to_i 
        if @year == 'Senior' 
            priority += 3
        elsif @year == 'Junior'
            priority += 2
        elsif @year == 'Sophmore'
            priority+= 1
        else 
            priority 
        end 
        priority += @completed_courses.count 
        priority - count  
    end 
    def count
        choices = [@first_choice, @second_choice, @third_choice] 
        choices.select{ |choice| choice == "N/A"}.count  
    end 
end 
