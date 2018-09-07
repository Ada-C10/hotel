require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'
require_relative 'booking_manager'

module Hotel
  class Helper_Method

    def self.binary_search_list_of_reservations(array_of_reservations, array_of_possible_dates)
      # RETURNS TRUE IF BOOKED, FALSE IF VACANT
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

    def self.generate_nights(check_in, check_out)
      nights_stay = []
      num_nights = (check_out - check_in)
      num_nights.to_i.times do |x|
        night = check_in + x
        nights_stay << night
      end
      return nights_stay
    end

    def self.sort_reservations(list_of_reservations)
      list_of_reservations.sort! { |a,b| a.check_in_date <=> b.check_in_date }
    end

    def self.find_room_number(list_of_rooms,find_room_number)
      return list_of_rooms.find { |room| room.room_number == find_room_number }
    end

    def self.connect_reservation_to_room_and_sort(connected_room_number, reservation)
      connected_room_number.reservations << reservation
      Hotel::Helper_Method.sort_reservations(connected_room_number.reservations)
    end

    def self.check_valid_date_range(check_in, check_out)
      if check_out < check_in
        return raise StandardError, 'Check_out date before check_in date.'
      end
    end

  end
end
