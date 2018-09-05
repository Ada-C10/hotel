require 'date'

# class HotelManager retrieves and saves information about rooms and reservations
module Hotel
  class HotelManager
    attr_reader :rooms
    attr_accessor :reservations

    # As an administrator, I can access the list of all of the rooms in the hotel
    def initialize(room_file = 'support/rooms.csv',
                    reservations_file = 'support/reservations.csv')
      @rooms = load_rooms(room_file)
      @reservations = load_reservations(reservations_file)
    end

    # As an administrator, I can reserve a room for a given date range
    def reserve(check_in, check_out, room_number)
      new_reservation = Hotel::Reservation.new(room_number, check_in, check_out)

      @reservations << new_reservation
    end

    # As an administrator, I can access the list of reservations for a specific date
    def find_reservations_by_date(date)
      found_reservations = []

      @reservations.each do |reservation|
        date_array = *(reservation.check_in...reservation.check_out)
        if date_array.include? Date.parse(date)
          found_reservations << reservation
        end
      end

      return found_reservations
    end

    # def available_rooms(check_in, check_out)
    #   date_array = *(Date.parse(check_in)...Date.parse(check_out))
    #
    #   @rooms.each do |room|
    #     date_array.each do |date|
    #       if room.calendar[date] == :UNAVAILABLE
    #         return nil
    #       end
    #     end
    #   end
    #
    #   return :AVAILABLE
    # end

    def load_rooms(filename)
      all_rooms = []
      room_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      room_data.each do |room|
        new_room = Room.new(room[:id])
        all_rooms << new_room
      end

      return all_rooms
    end

    def load_reservations(filename)
      all_reservations = []
      reservation_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      reservation_data.each do |reservation|
        new_reservation = Reservation.new(reservation[:room_number], reservation[:check_in], reservation[:check_out])
        all_reservations << new_reservation
      end

      return all_reservations
    end

  end
end
