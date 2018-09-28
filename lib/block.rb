module Hotel

  class Block

    attr_reader :date_range, :blocked_rooms, :discounted_rate, :block_reservations, :block_id

    def initialize(date_range, blocked_rooms, discounted_rate, block_id, block_reservations: [])
      @date_range = date_range
      @blocked_rooms = blocked_rooms
      @discounted_rate = discounted_rate
      @block_reservations = block_reservations
      @block_id = block_id

      if @blocked_rooms.length > 5 || @blocked_rooms.uniq.length != @blocked_rooms.length
        raise ArgumentError, "Blocked Rooms: #{blocked_rooms}, Invalid set of rooms"
      end

      @blocked_rooms.each do |room_num|
        unless [*1..20].include?(room_num)
          raise ArgumentError, "Room: #{room_num} not in hotel"
        end
      end

      if !is_number(@discounted_rate) || @discounted_rate > 200
        raise ArgumentError, "Rate: $#{@discounted_rate} is not a valid discounted_rate."
      end

    end


    def is_number(num)
      return num.is_a? Numeric
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

    def overlaps?(range)
      return @date_range.overlaps?(range)
    end

    def includes_room?(room)
      return @blocked_rooms.include?(room)
    end

    def add_reservation(reservation)
      @block_reservations << reservation
    end

    def get_first_available_room
      return list_available_block_rooms.first
    end

  end
end
