require 'pry'
require 'time'
require 'date'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations

    def initialize
      # times loop to create an array of 20 rooms
      @rooms = []
      20.times do |room_num|
        room_num += 1
        @rooms << Room.new(room_num)
      end
      @reservations = []
    end

    # method to find available rooms and return an array of available room
    def find_rooms_available(start_date, end_date)

      rooms_available = []

      reserv_range = DateRange.new(start_date, end_date)
      x = reserv_range.get_date_range

      @rooms.each do |room|
        if room.room_reservations.empty?
          rooms_available << room
        elsif room.room_reservations.each do |reservation|
            if reservation.date_range.check_overlap?(x) == false
              rooms_available << room
            end
          end
        end
      end
      return rooms_available
    end

    # list the reservations for a specific date
    def list_reservations(date)
      list = []
      @reservations.each do |reservation|
        if reservation.date_range.check_include?(date)
          list << reservation
        end
      end
      return list
    end


    def make_reservation(start_date, end_date)
      # find a room that is available
      room_to_book = find_rooms_available(start_date, end_date).first

      if room_to_book == nil
        raise StandardError.new ("No rooms available")
      else
        info = {id: rand(1..300),
          room: room_to_book,
          start_date: start_date,
          end_date: end_date
        }
        # Creating an instance of a new reservation
        new_reserv = Reservation.new(info)
        # Add this new reservation to the list (array) of reservations for the room in the room class
        room_to_book.add_booking(new_reserv)
        # Adding this new reservation to the list (array) of reservations in the booking class
        @reservations << new_reserv
        # calculating total cost for the new reservation and returning that
      end
      return new_reserv
    end
  end
end
