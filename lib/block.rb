require 'pry'


module Hotel
  class Block

    attr_reader :rooms, :reservations, :date_range, :check_in, :check_out, :discount_rate, :id

    def initialize(number, check_in:, check_out:, number_of_rooms:1, discount_rate: 0.8)
      @id = number
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @date_range = (@check_in...@check_out)
      @rooms = [] #if i change this to rooms can i use available rooms on it?
      @discount_rate = discount_rate
      @reservations = []
      #change this to standard error / rescue
      if @check_out != nil
        if @check_out <= @check_in
        raise ArgumentError, "Invalid date range"
        end
      end
    end

    # def available_rooms_in_block(check_in, check_out)
    #   available_rooms = self.rooms.select {|room| room.is_booked?(check_in, check_out) == false}
    #   #loop through Reservations @match dates on the reservations#reject dates that match
    #   return available_rooms #array
    # end
  end
end
