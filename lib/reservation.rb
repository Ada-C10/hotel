require 'date'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date
    attr_accessor :reservation_id

    
    @@total_reservations = 0
    ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]


    def initialize(start_date, end_date)

      @reservation_id = create_id
      @start_date = Date.new(start_date)
      @end_date = Date.new(end_date)

      validate_dates

    end



    #create a new reservation id by adding 1 to total reservations
    def create_id
      new_id = @@total_reservations + 1
    end



    #make sure there are valid start/end dates
    def validate_dates
      raise ArgumentError.new("The end date must be after the start date") if @end_date >= @start_date

      raise ArgumentError.new("The start date can't be nil") if @start_date == nil

      raise ArgumentError.new("The end date can't be nil") if @end_date == nil
    end




  end
end


#tests: make sure params for start/end date are in the right format (else argument error)
