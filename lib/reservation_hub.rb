require 'date'
require 'pry'

require_relative 'reservation'

module Hotel
  class ReservationHub
    attr_reader :start_date, :end_date, :rooms, :reservations

    # ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]


    def initialize
      @reservations = []
      @room_bookings = {1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [], 10 => [], 11 => [], 12 => [], 13 => [], 14 => [], 15 => [], 16 => [], 17 => [], 18 => [], 19 => [], 20 => []}
    end


    def add_reservation(start_year, start_month, start_day, end_year, end_month, end_day)

      start_date = generate_date(start_year, start_month, start_day)

      end_date = generate_date(end_year, end_month, end_day)

      reservation = Reservation.new(start_date, end_date)

      @reservations << reservation
    end


    def generate_date(year, month, day)
      return Date.new(year, month, day)
    end


    def create_date_array(start_date, end_date)
      number_of_nights = (end_date - start_date).to_i
      date_array = []
      number_of_nights.times do
        date_array << start_date
        start_date +=1
      end
      return date_array
    end


    def check_available_rooms(start_date, end_date)
      reservation_dates = create_date_array(start_date, end_date)

      @room_bookings.each do |room|

        reservation_dates.each do |date|
          if @room_bookings[room].include?(date)
            break
          end
        end

        room_id = assign_room(room, reservation_dates)
        return room_id
      end

      return "I'm sorry but there are no rooms available for your dates."
    end


    def assign_room(room_id, reservation_dates)
      @room_bookings[room_id] << reservation_dates
      return room_id
    end



    def find_reservations(year, month, day)

      start_date = generate_date(year, month, day)
      reservations_by_date = []
      index = 0

      all_reservations.each do
        if all_reservations[index].start_date == start_date

          reservations_by_date << all_reservations[index]
        end
        index +=1

      end
      return reservations_by_date
    end


    def all_reservations
      @reservations
    end


  end
end
