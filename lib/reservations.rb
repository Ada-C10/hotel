require 'date'

module Hotel
  class Reservation
    ROOMCOST = 200
    attr_accessor :check_in, :check_out, :room_num
    #things that only have to deal with SINGLE ROOM, one reservation at a time
    #monitors overlapping
    def initialize(check_in, check_out, room_num)
      @check_in = check_in
      @check_in = check_out
      @room_num = room_num
        if @room_num > 20 || @room_number < 1
          raise ArgumentError.new("Number must be between 1 - 20")
        end
    end

    def reserve_room(check_in, check_out, room_num)
      #reserves a room for a given date range
      in = Date.parse(check_in)
      out = Date.parse(check_out)
      @range = (out - in)

      if @reservations[@rooms.last] == room_num
        @reservations[room_num]
      end
      reservations[:room_num].value << @range
      return @reservations
    end


    def total_cost_reservation(check_in, check_out)
      #total cost for a given reservation(given range)
      range = Date.parse(check_out) - Date.parse(check_in)
      real_range = range.to_i
      date_range = real_range - 1
      cost = date_range * ROOMCOST
      total_cost = "$#{cost}"
      return total_cost
    end
