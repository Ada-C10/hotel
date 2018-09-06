require 'date'
require 'pry'

require_relative 'reservation'

module Hotel
  class ReservationHub
    attr_reader :start_date, :end_date, :rooms, :reservations
    # attr_accessor :reservation_id, :reservations

    ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]


    def initialize
      @reservations = []
      @rooms = ROOMS
    end


    def add_reservation(start_year, start_month, start_day, end_year, end_month, end_day)

      reservation = Reservation.new(start_year, start_month, start_day, end_year, end_month, end_day)

      all_reservations(reservation)
    end


    def find_reservations(start_date)
      reservations_by_date = []
      ReservationHub.add_reservation.each do |reservation|
        if reservation.start_date = start_date
          reservations_by_date << reservation
        end

      end

    end



    def all_reservations(reservation)
      @reservations << reservation
      return @reservations
    end
    #
    #
    # def find_reservations(start_date)
    #
    # end


  end
end
