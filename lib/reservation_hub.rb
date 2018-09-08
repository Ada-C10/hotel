require 'date'
require 'pry'

require_relative 'reservation'

module Hotel
  class ReservationHub
    class NoRoomsAvailableError < StandardError; end

    attr_reader :reservations, :room_bookings


    def initialize
      @reservations = []
      @room_bookings = {1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [], 10 => [], 11 => [], 12 => [], 13 => [], 14 => [], 15 => [], 16 => [], 17 => [], 18 => [], 19 => [], 20 => []}
    end


    def add_reservation(start_year, start_month, start_day, end_year, end_month, end_day)

      start_date = generate_date(start_year, start_month, start_day)

      end_date = generate_date(end_year, end_month, end_day)

      room_id = assign_room(start_date, end_date)

      reservation = Reservation.new(start_date, end_date, room_id)

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

      available_rooms = []

      @room_bookings.each do |room, dates|
        overlap = reservation_dates & dates

        if overlap.length == 0
          available_rooms << room
        end

      end
      return available_rooms
    end


    def assign_room(start_date, end_date)

      available_rooms = check_available_rooms(start_date, end_date)

      reservation_dates = create_date_array(start_date, end_date)

      if available_rooms == nil
        raise NoRoomsAvailableError, "No rooms are available."
      end

      room_id = available_rooms[0]

      reservation_dates.each{|date| @room_bookings[room_id] << date}

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
