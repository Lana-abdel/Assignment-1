class Course
    attr_accessor :number, :sections, :min, :max , :num_sections , :can_run, :seats_open, :open_sections 
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



