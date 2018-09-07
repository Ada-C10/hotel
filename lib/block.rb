module Hotel

  class Block #< Reservation

    attr_reader :date_range, :blocked_rooms, :discounted_rate, :block_reservations, :block_id
    #
    def initialize(date_range, blocked_rooms, discounted_rate, block_id)
      @date_range = date_range
      @blocked_rooms = blocked_rooms
      @discounted_rate = discounted_rate
      @block_reservations = []
      @block_id = block_id

      if @blocked_rooms.length > 5
        raise ArgumentError, "A block can contain a maximum of 5 rooms"
      end

      if !is_number(@discounted_rate)
        raise ArgumentError, "Discounted rate is not a valid number"
      end

      # TODO: this should be rescued?
      if @discounted_rate > 200
        raise ArgumentError, "Discounted rate is greater than Base rate: 200."
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

    def get_block_availability
      return list_available_block_rooms.length > 0
    end

    def list_available_block_rooms
      occupied_block_rooms = @block_reservations.map do |reservation|
        reservation.room_num
      end

      return (@blocked_rooms - occupied_block_rooms)
    end
  end
end
