module Hotel

  class BookingSystem

    attr_reader :all_rooms, :all_reservations, :all_room_blocks

    def initialize(all_reservations: [])
      @all_rooms = [*1..20]
      @all_reservations = all_reservations
      @all_room_blocks = []
    end

    def check_id(id)
      raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
    end

    def find_block(id)
      check_id(id)
      return @all_room_blocks.find{ |block| block.block_id == id}
    end

    def reserve_a_room_in_block(id)
      block = find_block(id)

      unless block
        raise ArgumentError, "Block not found in system"
      end

      unless block.get_block_availability
        raise ArgumentError, "Block has no availability"
      end

      room_num = block.list_available_block_rooms.first
      # rate = block.discounted_rate
      reserve_a_room(block.date_range.check_in, block.date_range.check_out, room_num, block: block) #, id: id, rate: rate)

    end

    def create_a_block(check_in, check_out, num_of_rooms, discounted_rate)
      range = Hotel::DateRange.new(check_in, check_out)

      # TODO: send message, rescue, or error if no available rooms or less than num_of_rooms
      # TODO: check if num_of_rooms is 1 <= 5, or does room_block already check for this?
      all_available_rooms = list_available_rooms(range)

      if all_available_rooms.empty? || all_available_rooms.length < num_of_rooms
        raise StandardError, "Not enough rooms available"
      end

      available_rooms = all_available_rooms[0..num_of_rooms - 1]
      block_id = @all_room_blocks.length + 1
      room_block = Hotel::Block.new(range, available_rooms, discounted_rate, block_id)
      @all_room_blocks << room_block
      return room_block

    end


    def get_printable_all_rooms
      return @all_rooms.map { |room_num| "Room #{room_num}"}.join("\n")
    end


    def get_printable_available_rooms(check_in, check_out)
      range = Hotel::DateRange.new(check_in, check_out)
      room_list = list_available_rooms(range)
      return "Available Rooms:\n" + room_list.map { |room_num| "Room #{room_num}"}.join("\n")
    end


    def reserve_a_room(check_in, check_out, room, block: false) #, id: nil, rate: nil)
      range = Hotel::DateRange.new(check_in,check_out)
      unless block
        # if check_if_invalid_dates(check_in, check_out)
        #   raise ArgumentError, "Invalid Dates Given"
        # end

        if !is_room_available(range, room)
          raise UnavailableRoomError, "Room not available"
        end

        new_reservation = Hotel::Reservation.new(range, room)
        @all_reservations << new_reservation
        return new_reservation

      else

        # block = find_block(id)
        new_reservation = Hotel::Reservation.new(range, room, rate: block.discounted_rate)
        # @all_reservations << new_reservation
        block.block_reservations << new_reservation
        return new_reservation
      end
    end


    def is_room_available(range, room)
      return list_available_rooms(range).include?(room)
    end


    def get_occupied_rooms(days_reservations)
      return days_reservations.map { |reservations| reservations.room_num }
    end


    def get_reservations_by_date(date)
      return @all_reservations.select do |reservation|
        reservation.date_range.is_within_date_range(date)
      end
    end

    def get_room_blocks_by_date(date)
      return @all_room_blocks.select do |room_block|
        room_block.date_range.is_within_date_range(date)
      end
    end


    def list_unavailable_rooms(range)
      overlapping_reservations = @all_reservations.select { |reservation| reservation.date_range.overlaps?(range) }
      occupied_rooms = overlapping_reservations.map { |reservation| reservation.room_num}

      overlapping_blocks = @all_room_blocks.select { |block|
        block.date_range.overlaps?(range) }
      overlapping_blocks.each do |block|
        occupied_rooms.concat block.blocked_rooms
      end

      return occupied_rooms



      # occupied_rooms = []
      # [*check_in...check_out].each do |date|
      #   if !get_reservations_by_date(date).empty?
      #     occupied_rooms.concat get_occupied_rooms(get_reservations_by_date(date))
      #   end
      #   if !get_room_blocks_by_date(date).empty?
      #     get_room_blocks_by_date(date).each do |room_block|
      #       occupied_rooms.concat room_block.blocked_rooms
      #     end
      #   end
      # end
      # occupied_rooms.uniq!
      #
      # return occupied_rooms
    end


    def list_available_rooms(range)
      # range = DateRange.new(chec)
      # unless check_if_invalid_dates(range)
        occupied_rooms = list_unavailable_rooms(range)
        return @all_rooms - occupied_rooms
      # else
      #   #TODO: should this be it's own method? or in data validation class?
      #   raise ArgumentError, "Invalid Dates Given"
      # end
    end

    # TODO: should this be in it's own class of validation methods?
    # def is_Date(date)
    #   return date.class == Date
    # end


    # def check_if_invalid_dates(date_range)
    #   return check_in > check_out || !is_Date(check_in) || !is_Date(check_out)
    # end


  end

  class UnavailableRoomError < StandardError
  end

end
