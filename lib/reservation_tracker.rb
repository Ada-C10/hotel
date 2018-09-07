require 'date'

require_relative 'date_range'
require_relative 'reservation'

NUM_OF_ROOMS = 20

module Hotel
  class ReservationTracker
    attr_reader :reservations, :rooms

    def initialize
      @rooms = load_rooms
      @reservations = []
    end

    def load_rooms
      all_rooms = []
      NUM_OF_ROOMS.times { |i| all_rooms << i + 1 }
      return all_rooms
    end

    def list_reservations_by_date(specified_date)
      reservations_by_date = @reservations.find_all do |reservation|
        range = reservation.date_range.get_range
        range.include?(specified_date)
      end
      return reservations_by_date
    end

    def reservations_overlaps?(requested_dates)
      matching_reservations = @reservations.find_all do |reservation|
        range = reservation.date_range
        range.overlaps?(requested_dates)
        reservation
      end
    end

    def find_unavailable_rooms(requested_dates)
      matching_reservations = reservations_overlaps?(requested_dates)
      unavailable_rooms = matching_reservations.map do |reservation|
        reservation.room
      end
      return unavailable_rooms
    end

    def find_available_rooms(requested_dates)
      unavailable_rooms = find_unavailable_rooms(requested_dates)
      available_rooms = @rooms.reject { |room| unavailable_rooms.include?(room) }
      check_availablity?(available_rooms)
      return available_rooms
    end

    def get_first_available_room(requested_dates)
      all_available_rooms = find_available_rooms(requested_dates)
      first_available_room = all_available_rooms.first
      return first_available_room
    end

    def get_requested_dates(input)
      return DateRange.new(input[:start_date], input[:end_date])
    end

    def reserve_room(input)
      requested_dates = get_requested_dates(input)

      id = @reservations.length + 1
      room = get_first_available_room(requested_dates)

      reservation_data = {
        id: id,
        room: room,
        date_range: requested_dates
      }

      new_reservation = Reservation.new(reservation_data)
      @reservations << new_reservation
      return new_reservation
    end

    private

    def check_availablity?(available_rooms)
      raise ArgumentError.new("NO ROOMS AVAILABLE!!!") if available_rooms.empty?
    end
  end
end
