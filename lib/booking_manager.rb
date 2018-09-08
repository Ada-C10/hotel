require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'
require_relative 'helper_method'

module Hotel
  class Booking_Manager
    attr_reader :rooms, :hotel_reservations

    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    ROOM_COST = 200

    def initialize
      @rooms = load_rooms
      @hotel_reservations = []
    end

    def reserve_room(input)

      search_room_availability(input[:check_in_date], input[:check_out_date])
      connected_room_number = Hotel::Helper_Method.find_room_number(@rooms, input[:room_number])

      reserve = { name: input[:name],
        room_number: connected_room_number,
        check_in_date: input[:check_in_date],
        check_out_date: input[:check_out_date]
      }
      reservation = Reservation.new(reserve)
      Hotel::Helper_Method.connect_reservation_to_room_and_sort(connected_room_number, reservation)
      @hotel_reservations << reservation
      Hotel::Helper_Method.sort_reservations(@hotel_reservations)
    end

    def search_room_availability(check_in_date, check_out_date)
      possible_nights_of_stay = Hotel::Helper_Method.generate_nights(check_in_date, check_out_date)
      vacant_rooms = []
      @rooms.each do |room|
        if Hotel::Helper_Method.binary_search_list_of_reservations(room.reservations, possible_nights_of_stay) == false
          vacant_rooms << room.room_number
        end
      end
      if vacant_rooms.empty?
        return raise ArgumentError, 'No Rooms Availble in date range'
      end
      return vacant_rooms
    end

    def get_rooms
      return @rooms
    end

    def list_reservations(date)
      return reservations_on_date = @hotel_reservations.find_all { |reservation| reservation.nights_of_stay == date }
    end

    def total_cost_of_stay(reservation)
      return (reservation.nights_of_stay.length * ROOM_COST)
    end

    def load_rooms
      rooms = []
      ROOM_NUMBERS.each do |num|
        room = Room.new(num)
        rooms << room
      end
      return rooms
    end

  end
end
