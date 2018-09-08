module Hotel

  class BookingSystem

    attr_reader :all_rooms, :all_reservations, :all_room_blocks

    def initialize(all_reservations: [])
      @all_rooms = [*1..20]
      @all_reservations = all_reservations
      @all_room_blocks = []
    end


    def list_rooms
      return @all_rooms.map { |room_num| "Room #{room_num}"}.join("\n")
    end


    def list_printable_available_rooms(check_in, check_out)
      range = Hotel::DateRange.new(check_in, check_out)
      room_list = list_available_rooms(range)
      return "Available Rooms:\n" + room_list.map { |room_num| "Room #{room_num}"}.join("\n")
    end


    def list_available_rooms(range)
        occupied_rooms = list_unavailable_rooms(range)
        return @all_rooms - occupied_rooms
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
    end


    def list_reservations_by_date(date)
      return @all_reservations.select do |reservation|
        reservation.date_range.is_within_date_range(date)
      end
    end


    def make_reservation(range, room, block: false)
      unless block

        if !is_room_available(range, room)
          raise UnavailableRoomError, "Room not available"
        end

        new_reservation = Hotel::Reservation.new(range, room)
        @all_reservations << new_reservation

      else

        if block.blocked_rooms.include?(room)
          new_reservation = Hotel::Reservation.new(range, room, rate: block.discounted_rate)
          block.block_reservations << new_reservation
        else
          raise UnavailableRoomError, "Room in different block"
        end

      end

      return new_reservation
    end


    def reserve_standard_room(check_in, check_out)
      range = Hotel::Date.new(check_in, check_out)

      open_rooms = list_available_rooms

      if open_rooms.empty?
        raise UnavailableRoomError, "No Rooms available for #{check_in} to #{check_out}"
      else
        make_reservation(range, open_rooms.first)
      end
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
      make_reservation(block.date_range, room_num, block: block)
    end


    def create_a_block(check_in, check_out, num_of_rooms, discounted_rate)
      range = Hotel::DateRange.new(check_in, check_out)

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


    def is_room_available(range, room)
      return list_available_rooms(range).include?(room)
    end


    def check_id(id)
      raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
    end


    def find_block(id)
      check_id(id)
      return @all_room_blocks.find{ |block| block.block_id == id}
    end


  end

  class UnavailableRoomError < StandardError
  end

end
