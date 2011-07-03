#modified sm2 algorithm
#changes:
# - initial interval depends on given quality_response
# - states (easiness_factor is calulated using that states, sm2 for ok uses 4)
#   - 0 - bad (0, -0.8), 1 - so so(2, -0.3), 2 - ok(4, 0), 3 - more than better(5, 0.1)
require 'date'

module SpacedRepetition
  class Sm2Mod
    def initialize(quality_response, prev_interval=0, prev_ef=2.5)
      @prev_ef = prev_ef
      @prev_interval = prev_interval
      @quality_response = quality_response

      @calculated_interval = nil
      @calculated_ef = nil
      @repetition_date = nil

      #if quality_response is below 3 start repetition from the begining, but without changing easiness_factor
      if @quality_response < 2
        @calculated_interval=0
        @calculated_ef = @prev_ef
      else
        calculate_easiness_factor
	calculate_interval
      end
        
        calculate_date
    end

    def interval
      @calculated_interval
    end

    def easiness_factor
      @calculated_ef
    end

    def next_repetition_date
      @repetition_date
    end

    private
    
    def calculate_interval
      if @prev_interval == 0
        @calculated_interval = 1
        if @quality_response == 3
          @calculated_interval = 6
        end
      elsif @prev_interval == 1
        @calculated_interval = 6
      else
        @calculated_interval = (@prev_interval*@prev_ef).to_i
      end
    end

    def calculate_easiness_factor
      @calculated_ef = @prev_ef+(0.1-(3-@quality_response)*((3-@quality_response)*0.1))
      if @calculated_ef < 1.3
        @calculated_ef = 1.3
      end
      @calculated_ef
    end

    def calculate_date
      @repetition_date = Date.today + @calculated_interval
    end
  end
end
