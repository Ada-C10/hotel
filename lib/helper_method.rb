module Hotel
  class Helper_Method

    def self.binary_search_list_of_reservations_for_vacancy(array_of_reservations, array_of_possible_dates)
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

    def self.binary_search_reservations_return_index_if_found(array_of_reservations, date)
      # GIVEN A DATE, IT RETURNS INDEX OF A RESERVATION ON THAT DATE, NIL IF NO RESERVATIONS
      min = 0
      max = array_of_reservations.length

      if array_of_reservations.first == nil
        return nil
      end

      while min < max
        mid = (min + max )/ 2
        if array_of_reservations[mid].nights_of_stay.include?(date)
          return mid
        elsif array_of_reservations[mid].check_in_date > date
          max = mid - 1
        elsif array_of_reservations[mid].check_in_date < date
          min = mid + 1
        end
      end

      if array_of_reservations[0].nights_of_stay.include?(date)
        return 0
      end

      return nil
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

    def self.connect_reservation_to_room_and_sort(list_of_rooms, room_number, reservation)
      connected_room_number = Hotel::Helper_Method.find_room_number(list_of_rooms, room_number)
      if Hotel::Helper_Method.check_a_room_for_availability(connected_room_number, reservation.check_in_date, reservation.check_out_date) == :BOOKED
        return raise ArgumentError, 'No Rooms Available in date range'
      end
      connected_room_number.reservations << reservation
      Hotel::Helper_Method.sort_reservations(connected_room_number.reservations)
    end

    def self.check_valid_date_range(check_in, check_out)
      if check_out < check_in
        return raise StandardError, 'Check_out date before check_in date.'
      end
    end

    def self.find_room_number(list_of_rooms,room_number_to_find)
      return list_of_rooms.find { |room| room.room_number == room_number_to_find }
    end

    def self.check_a_room_for_availability(connected_room_number, check_in_date, check_out_date)
        possible_nights_of_stay = Hotel::Helper_Method.generate_nights(check_in_date, check_out_date)
        if Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(connected_room_number.reservations, possible_nights_of_stay) == true
            return :BOOKED
          else
            return :VACANCY
        end
    end
  end
end
