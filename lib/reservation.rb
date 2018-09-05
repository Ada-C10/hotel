require 'date'

module Hotel
  class Reservation

    @@total_reservations = 0

    attr_reader :start_date, :end_date

    attr_accessor :reservation_id

    def initialize(start_date, end_date)

      @reservation_id = create_id
      @start_date = Date.new(start_date)
      @end_date = Date.new(end_date)

    end

    def create_id
      new_id = @@total_reservations + 1
    end


  end
end


#tests: 
