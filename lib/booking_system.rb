require_relative 'reservation_creator'

module Hotel
  class BookingSystem
    # attr_reader :reservation_date

    def initialize
      @booked_dates = []
    end

    def new_reservation(reservation)
      @booked_dates << reservation.booking_date_range
      return @booked_dates.flatten!
    end

    def assign_room_to_booking(reservation)
      assigned_room = []

      reservation.booking_date_range.each do |date|
        room_selected = [date, list_all_rooms_in_hotel.first]
        assigned_room << room_selected
      end

      return assigned_room
    end

    def list_all_rooms_in_hotel
      all_rooms = [*1..20]
      return all_rooms
    end

    def calculate_booking_cost(reservation)
      cost = reservation.booking_date_range.length * 200
      return cost
    end
  end
end
