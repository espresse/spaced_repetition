require 'date'

module SpacedRepetition
  class Sm2Lg
    
    def initialize(quality_response, prev_interval=0, prev_ef=2.5, practice_date=nil)
      @prev_ef=prev_ef
      @quality_response = quality_response
      @prev_interval = prev_interval
      @practice_date = practice_date

      if @practice_date.nil?
	@calculated_interval = first_interval
      else
	@calculated_interval = calculate_interval
      end

      @easiness_factor = calculate_easiness_factor
      
      @next_date = calculate_next_date
    end

    def interval
      @calculated_interval
    end

    def easiness_factor
      @easiness_factor
    end

    def date
      @next_date
    end
    
    private

    def first_interval
      #initial interval (0 - 0), (1 - 1), (2 - 3-5), (3 - 7-9)
      next_interval = 0

      if @quality_response == 1
	next_interval = 1
      elsif @quality_response == 2
	next_interval = my_rand(3, 5)
      elsif @quality_response == 3
	next_interval = my_rand(7, 9)
      end
     next_interval
    end

    def calculate_interval
      normal_interval = (@prev_interval*@prev_ef).to_i
      premium = ((Date.today-@practice_date)/(4-@quality_response)).to_i
      if @quality_response < 1
	premium = 0
      end

      if @quality_response == 0
	normal_interval = 0
      end
      
      normal_interval + premium
    end

    def calculate_easiness_factor
      calculated_ef = @prev_ef+(0.1-(3-@quality_response)*((3-@quality_response)*0.1))
      if calculated_ef < 1.3
        calculated_ef = 1.3
      end
      calculated_ef
    end

    def calculate_next_date
      Date.today + @calculated_interval
    end


    def my_rand(x, y)
      rand(y - x) + x
    end
      
  end
end