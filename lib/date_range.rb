require 'date'


module Hotel
  class DateRange

    def initialize(start_date, end_date)

      @start_date = start_date
      @end_date = end_date

      validate_dates

      @date_range = create_date_array(start_date, end_date)
    end


    def validate_dates
      raise ArgumentError.new("The end date must be after the start date") if @end_date <= @start_date
    end


    def create_date_array(start_date, end_date)
      number_of_nights = (end_date - start_date).to_i
      date_array = []
      number_of_nights.times do
        date_array << start_date
        start_date +=1
      end
      return date_array
    end

  end
end
