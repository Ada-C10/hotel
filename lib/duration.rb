module Hotel
  class Duration

    def initialize(start_date, end_date)
      @start_date = Date.parse
      @end_date = Date.parse
    end

    def number_of_nights
      return (@end_date - @start_date).to_i
    end

  end
end
