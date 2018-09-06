module Hotel

  class HotelBooker

    attr_reader :all_rooms, :all_reservations, :all_room_blocks

    def initialize(all_reservations: [])
      @all_rooms = [*1..20]
      @all_reservations = all_reservations
      @all_room_blocks = []
    end

    def create_a_block(check_in, check_out, num_of_rooms, discounted_rate)

      # TODO: send message, rescue, or error if no available rooms or less than num_of_rooms
      # TODO: check if num_of_rooms is 1 <= 5, or does room_block already check for this?
      all_available_rooms = list_available_rooms(check_in, check_out)

      if all_available_rooms.empty? || all_available_rooms.length < num_of_rooms
        raise StandardError, "Not enough rooms available"
      end

      available_rooms = all_available_rooms[0..num_of_rooms - 1]
      room_block = Hotel::RoomBlock.new(check_in, check_out, available_rooms, discounted_rate)
      @all_room_blocks << room_block
      return room_block

    end


    def get_printable_all_rooms
      return @all_rooms.map { |room_num| "Room #{room_num}"}.join("\n")
    end


    def get_printable_available_rooms(check_in, check_out)
      room_list = list_available_rooms(check_in, check_out)
      return "Available Rooms:\n" + room_list.map { |room_num| "Room #{room_num}"}.join("\n")
    end


    def reserve_a_room(check_in, check_out, room)
      if check_if_invalid_dates(check_in, check_out)
        raise ArgumentError, "Invalid Dates Given"
      end
      if !is_room_available(check_in, check_out, room)
        raise UnavailableRoomError, "Room not available"
      else
        new_reservation = Hotel::Reservation.new(check_in, check_out, room)
        @all_reservations << new_reservation
        return new_reservation
      end
    end


    def is_room_available(check_in, check_out, room)
      return list_available_rooms(check_in, check_out).include?(room)
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


    def list_unavailable_rooms(check_in, check_out)

      occupied_rooms = []
      [*check_in...check_out].each do |date|
        if !get_reservations_by_date(date).empty?
          occupied_rooms.concat get_occupied_rooms(get_reservations_by_date(date))
        end
        if !get_room_blocks_by_date(date).empty?
          # binding.pry
          get_room_blocks_by_date(date).each do |room_block|
            occupied_rooms.concat room_block.blocked_rooms
          end
        end
          # days_reservations.map { |reservations| reservations.room_num }
      end
      # binding.pry
      occupied_rooms.uniq!

      return occupied_rooms #occupied_rooms.empty? ? nil : occupied_rooms
    end


    def list_available_rooms(check_in, check_out)
      unless check_if_invalid_dates(check_in, check_out)
        occupied_rooms = list_unavailable_rooms(check_in, check_out)
        return @all_rooms - occupied_rooms
      else
        #TODO: should this be it's own method? or in data validation class?
        raise ArgumentError, "Invalid Dates Given"
      end
    end

    # TODO: should this be in it's own class of validation methods?
    def is_Date(date)
      return date.class == Date
    end


    def check_if_invalid_dates(check_in, check_out)
      return check_in > check_out || !is_Date(check_in) || !is_Date(check_out)
    end


  end

  class UnavailableRoomError < StandardError
  end

end
