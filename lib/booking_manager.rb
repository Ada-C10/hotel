require 'Date'
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

    def self.search_room_availability(check_in_date, check_out_date)

      # vacant_rooms = []
      # rooms = get_rooms
      # rooms.each do |room|
      #   min = 0
      #   max = room.reservations.length
      #   while min < max
      #     mid = (min + max )/ 2
      #     if reservations[mid].nights_of_stay.include?(check_in_date)
      #       break
      #     elsif reservations[mid].check_in_date > check_in_date
      #       max = mid - 1
      #     elsif reservations[mid].check_in_date < check_in_date
      #       min = mid + 1
      #     end
      #   end
      #   if reservations[min].nights_of_stay.include?(check_in_date)
      #     break
      #   end
      #   vacant_rooms << room
      # end
      #
      # return vacant_rooms
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

    # def binary_search_sorted_reservations(array_of_reservations, check_in_date, check_out_date)
    #   min = 0
    #   max = array_of_reservations.length
    #
    #   while min < max
    #     mid = (min + max )/ 2
    #     if array_of_reservations[] == check_in_date || array_of_reservations == check_out_date
    #       return true
    #     elsif array_of_reservations.first > check_in_date
    #       max = mid - 1
    #     elsif array.[](mid) < value_to_find
    #       min = mid + 1
    #     end
    #   end
    #   if array.[](min) == value_to_find
    #     return true
    #   end
    #   return false
    # end

  end
end
