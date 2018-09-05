module Hotel

  class HotelBooker

    attr_reader :all_rooms, :all_reservations

    def initialize(all_reservations: [])
      @all_rooms = [*1..20]
      @all_reservations = all_reservations
    end

    def list_all_rooms
      list_of_rooms = @all_rooms.each_with_index.map { |room_num, order| "Room #{order + 1}: #{room_num}" }.join("\n")
      return list_of_rooms
    end

    def reserve_a_room(check_in, check_out)
      room_num = @all_rooms.sample

      return Hotel::Reservation.new(check_in, check_out, room_num)
    end

    def get_reservations_by_date(date)
      return @all_reservations.select do |reservation|
        reservation.date_range.is_within_date_range(date)
      end
    end

    def get_occupied_rooms(days_reservations)
      return days_reservations.map { |reservations| reservations.room_num }
    end

    def list_available_rooms(date)
      if date.class != Date 
        raise ArgumentError, "Not a valid date"
      end

      days_reservations = get_reservations_by_date(date)

      occupied_rooms = get_occupied_rooms(days_reservations)

      return @all_rooms - occupied_rooms
    end

  end
end
