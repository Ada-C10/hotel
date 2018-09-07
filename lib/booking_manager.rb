require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'

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
      
      connected_room_number = find_room_number(input[:room_number])

      reserve = { name: input[:name],
        room_number: connected_room_number,
        check_in_date: input[:check_in_date],
        check_out_date: input[:check_out_date]
      }
      reservation = Reservation.new(reserve)
      connect_reservation_to_room(connected_room_number, reservation)
      @hotel_reservations << reservation
      sort_reservations(@hotel_reservations)
    end

    def total_cost_of_stay(reservation)
      return (reservation.nights_of_stay.length * ROOM_COST)
    end

    def sort_reservations(list_of_reservations)
      list_of_reservations.sort! { |a,b| a.check_in_date <=> b.check_in_date }
    end

    def search_room_availability(check_in_date, check_out_date)
      possible_nights_of_stay = Hotel::Reservation.generate_nights(check_in_date, check_out_date)
      vacant_rooms = []
      booked_rooms = []
      @rooms.each do |room|
        if binary_search_list_of_reservations(room.reservations, possible_nights_of_stay) == false
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


    def find_room_number(find_room_number)
      return @rooms.find { |room| room.room_number == find_room_number }
    end

    def connect_reservation_to_room(connected_room_number, reservation)
      connected_room_number.reservations << reservation
      sort_reservations(connected_room_number.reservations)
    end

    def load_rooms
      rooms = []
      ROOM_NUMBERS.each do |num|
        room = Room.new(num)
        rooms << room
      end
      return rooms
    end

    def binary_search_list_of_reservations(array_of_reservations, array_of_possible_dates)

      min = 0
      max = array_of_reservations.length

      if array_of_reservations.first == nil
        return false
      end

      while min < max
        mid = (min + max )/ 2
        if !(array_of_possible_dates & array_of_reservations[mid].nights_of_stay).empty?
          return true
        elsif array_of_reservations[mid].check_in_date > array_of_possible_dates.first
          max = mid - 1
        elsif array_of_reservations[mid].check_in_date < array_of_possible_dates.first
          min = mid + 1
        end
      end

      if !(array_of_possible_dates & array_of_reservations[0].nights_of_stay).empty?
        return true
      end

      return false
    end

  end
end
