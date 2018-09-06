require 'date'

#a reservation class
module Hotel

  class Reservation

    attr_reader :checkin_date, :checkout_date, :total_cost, :confirmation_id, :room_number

    ROOM_COST = 200
    NAME_REGEXP = /^[A-Z]{3}+[\d]{5}/

    #initializes a reservation with date #MM/DD/YYYY
    def initialize(input)
      #room number or room object?

      @checkin_date = Date.parse(input[:checkin_date])
      @checkout_date = Date.parse(input[:checkout_date])
      @room_number = input[:room_number]

      @confirmation_id = generate_random_id
      @total_cost = calculate_total_cost
    end

    def calculate_total_cost
      return ROOM_COST * (@checkout_date - @checkin_date)
      #modified julian number #starts from midnight # .mjd #do I need?
    end

    private

    def generate_random_id
      return (Array('A'..'Z').sample(3) + Array(0..9).sample(5)).join
    end

  end

end
