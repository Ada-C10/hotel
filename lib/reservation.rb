require 'date'

module Hotel

  class Reservation

    attr_reader :checkin_date, :checkout_date, :total_cost, :confirmation_id, :room_number

    #initializes a reservation with date #MM/DD/YYYY
    def initialize(input)

      @checkin_date = Date.parse(input[:checkin_date])
      @checkout_date = Date.parse(input[:checkout_date])
      validate_date

      @room_number = input[:room_number].to_i
      @total_cost = input[:total_cost].to_i
      @confirmation_id = input[:confirmation_id].to_s
    end

    def validate_date
      raise StandardError.new("Are you sure that order is right? Checkout can't be before checkin.") if (@checkout_date <= @checkin_date)
    end

  end
end
