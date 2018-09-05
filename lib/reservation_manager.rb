module Hotel

  class ReservationManager

    attr_reader :all_rooms, :all_reservations

    def initialize(all_reservations: [])
      @all_rooms = [*1..20]
      @all_reservations = all_reservations
    end

    def list_all_rooms
      list_of_rooms = @all_rooms.each_with_index.map { |room_num, order| "Room #{order + 1}: #{room_num}" }.join("\n")
      return list_of_rooms
    end

    def reserve_a_room(start_date, end_date)

      return Reservation.new(start_date, end_date, 1)
    end

    def get_reservations_by_date(date)
      return @all_reservations.select do |reservation|
        date >= reservation.date_range.start_date && date < reservation.date_range.end_date
      end
    end

  end

end
