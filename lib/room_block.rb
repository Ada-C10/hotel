module Hotel

  class RoomBlock #< Reservation

    attr_reader :date_range, :blocked_rooms, :discounted_rate, :block_reservations
    #
    def initialize(check_in, check_out, blocked_rooms, discounted_rate)
      @date_range = DateRange.new(check_in, check_out)
      @blocked_rooms = blocked_rooms
      @discounted_rate = discounted_rate
      @block_reservations = []

      if @blocked_rooms.length > 5
        raise ArgumentError, "A block can contain a maximum of 5 rooms"
      end

      if !is_number(@discounted_rate)
        raise ArgumentError, "Discounted rate is not a valid number"
      end

      # TODO: this should be rescued?
      if @discounted_rate > 200
        raise ArgumentError, "Discounted rate is greater than Base rate: #{BASE_COST}."
      end

      if @blocked_rooms.uniq.length != @blocked_rooms.length
        raise ArgumentError, "Cannot have repeating rooms"
      end

      @blocked_rooms.each do |room_num|
        unless [*1..20].include?(room_num)
          raise ArgumentError, "Room: #{room_num} not in hotel"
        end
      end

      # TODO: add a block_reserved array to hotel_booker class
    end

    def is_number(num)
      return num.to_f.to_s == num.to_s || num.to_i.to_s == num.to_s
    end

    # TODO: methods to create:
    # make_block_reservation
    # check_if_block_has_availabiliy
    # make_blocked_room unavailable to be reserved by the public for that date range, or by another block



  end

end
