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

    def list_unavailable_rooms(date)
      if is_Date(date)
        days_reservations = get_reservations_by_date(date)
        occupied_rooms = get_occupied_rooms(days_reservations)
        return occupied_rooms.empty? ? nil : occupied_rooms
      else
        raise ArgumentError, "Not a valid date"
      end
    end

    def reserve_a_room(check_in, check_out)
      if is_Date(check_in) && is_Date(check_out)
        occupied_rooms_list = []
        [*check_in...check_out].each do |date|
          if list_unavailable_rooms(date)
            occupied_rooms_list.concat list_unavailable_rooms(date)
          end
        end

        occupied_rooms_list.uniq!
        available_rooms = @all_rooms - occupied_rooms_list
        room_num = available_rooms.first
      end

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
      if is_Date(date)
        occupied_rooms = list_unavailable_rooms(date)
        return occupied_rooms ? @all_rooms - occupied_rooms : @all_rooms
      else
        raise ArgumentError, "Not a valid date"
      end
    end

    def is_Date(date)
      return date.class == Date
    end

  end
end
