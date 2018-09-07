require_relative 'reservation_creator'

module Hotel
  class BookingSystem
    attr_reader :booked_dates

    def initialize
      @booked_dates = []
    end

    def assign_room_to_booking(reservation)
      @booked_dates = reservation.booking_date_range.map do |date|
        room_selected = [date, list_all_rooms_in_hotel.first]
      end

      return @booked_dates
    end

    def list_all_rooms_in_hotel
      all_rooms = [*1..20]
      return all_rooms
    end

    def calculate_booking_cost(reservation)
      cost = reservation.booking_date_range.length * 200
      return cost
    end

    def list_bookings_by_date(date)

    end
  end
end
