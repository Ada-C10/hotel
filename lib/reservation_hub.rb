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

      start_date = generate_date(start_year, start_month, start_day)

      end_date = generate_date(end_year, end_month, end_day)

      reservation = Reservation.new(start_date, end_date)

      @reservations << reservation
      # return @reservations
    end


    def generate_date(year, month, day)
      return Date.new(year, month, day)
    end


    def find_reservations(year, month, day)
      
      start_date = generate_date(year, month, day)

      reservations_by_date = []
      index = 0
      all_reservations.each do
        # binding.pry
        if all_reservations[index].start_date == start_date

          reservations_by_date << all_reservations[index]
          # binding.pry
        end
        index +=1

      end
      return reservations_by_date

    end


    def all_reservations
      @reservations
    end




    # def all_reservations(reservation)
    #
    # end
    #
    #
    # def find_reservations(start_date)
    #
    # end


  end
end
