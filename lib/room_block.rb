module Hotel

  class RoomBlock #< Reservation

    # attr_reader :room_num, :cost
    #
    def initialize(check_in, check_out, blocked_rooms, discounted_rate)
      @date_range = DateRange.new(check_in, check_out)
      @blocked_rooms = blocked_rooms
      @discounted_rate = discounted_rate

      # TODO: check if blocked_rooms contains non-repeating rooms, only from 1 - 20
    end
    #
    # def get_cost
    #   return @date_range.get_total_days * BASE_COST
    # end



  end

end
