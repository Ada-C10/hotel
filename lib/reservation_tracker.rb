require 'date'

require_relative 'reservation'
require_relative 'room'

module Hotel

  class ReservationTracker
    attr_reader :reservations, :rooms, :date_range

    def initialize(reservations)
      @reservations = load_reservations
    end

    def load_reservations
      reservations = []
      return reservations
    end

    def list_reservations(date)
      reservations_by_date = @reservations.find_all do |reservation|
        reservation.date_range.include?(date)
      end
      return reservations_by_date
    end

    def find_room(room_number)
      check_room_number(room_number)
      return @rooms.find { |room| room.room_number == room_number }
    end

    def reserve_room(requested_dates)
      room = find_room(room_number)
      reservation_data = {
        id: id,
        room: room,
        start_date: start_date,
        end_date: end_date
      }

      new_reservation = Hotel::Reservation.new(reservation_data)

      room.add_booked_reservation(new_reservation)
      @reservations<< new_reservation
      return new_reservation
    end

    def get_first_available_room(requested_dates)
      first_available_room = find_available_rooms(requested_dates)
    end

    def find_available_rooms(requested_dates)
      available_rooms = @rooms.map do |room|
        return room if room.is_available?(requested_dates)
      end
      # Raise error if no rooms available for dates
    end

    private

    def check_room_number(room_number)
      raise ArgumentError, "Room number cannot be blank or less than zero. (got #{room_number})" unless room_number.between?(1, 20)
    end
  end
end
