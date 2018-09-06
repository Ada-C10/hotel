require 'date'

require_relative 'reservation'

NUMBER_OF_ROOMS = 20

module Hotel
  class ReservationTracker
    attr_reader :reservations, :rooms

    def initialize
      @rooms = load_rooms
      @reservations = []
    end

    def load_rooms
      all_rooms = []
      NUMBER_OF_ROOMS.times do |i|
        all_rooms << i + 1
      end
      return all_rooms
    end

    def list_reservations_by_date(date)
      reservations_by_date = @reservations.find_all do |reservation|
        reservation.date_range.include?(date)
      end
      return reservations_by_date
    end

    def find_unavailable_rooms(requested_dates)
      unavailable_rooms = @reservations.map do |reservation|
        reservation_period = reservation.date_range
        if reservation_period.overlap?(requested_dates)
          reservations.room
        end
      end
    end

    def find_available_rooms(requested_dates)
      unavailable_rooms = find_unavailable_rooms(requested_dates)

      available_rooms = @rooms.reject { |room|  unavailable_rooms.include?(room) }

      return available_rooms
    end

    def get_first_available_room(requested_dates)
      first_available_room = find_available_rooms(requested_dates)
    end

    def reserve_room(requested_dates)
      room = get_first_available_room(requested_dates)

      reservation_data = {
        id: id,
        room: room,
        start_date: start_date,
        end_date: end_date
      }

      new_reservation = Hotel::Reservation.new(reservation_data)
      @reservations << new_reservation
      return new_reservation
    end

    # def find_available_rooms(requested_dates)
    #   available_rooms = @rooms.map do |room|
    #     return room if room.is_available?(requested_dates)
    #   end
    #   # Raise error if no rooms available for dates
    # end

    private

    def check_room_number(room_number)
      raise ArgumentError, "Room number cannot be blank or less than zero. (got #{room_number})" unless room_number.between?(1, 20)
    end
  end
end
