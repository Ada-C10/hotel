require 'pry'
require 'awesome_print'

require 'date'
require_relative 'room'
require_relative 'reservation'
require_relative 'date_range'

module Hotel
  class HotelBooker
    attr_reader :rooms, :reservations, :booked_dates
    attr_accessor

    def initialize()
      @reservations = []
      @booked_dates = []
      @rooms = []

      number_of_rooms = 20
      number_of_rooms.times do |i|
        @rooms << Hotel::Room.new(i+1)
      end
    end

    def make_reservation(id, check_in, check_out)

      # TODO make check_in and check_out into dates here instad of reservation
      reservation = Hotel::Reservation.new(id, check_in, check_out)
      reservation.assign_room(@rooms)
      # room = reservation.room
      # room.reservations << reservation
      @reservations << reservation
    end

    def all_rooms()
    end

    def all_reservations()
    end

    def all_booked_dates()
    end

  end
end
