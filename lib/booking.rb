require 'pry'
require 'time'
require 'date'

module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations,

    def initialize(rooms, reservations)
      # times loop to create an array of 20 rooms
      @rooms = []
      20.times do |room_num|
        room_num += 1
        @rooms << Room.new(room_num)
      end
      @reservations = []
    end

    # list all of the rooms in the hotel
    def list_rooms
      return @rooms
    end

    def list_rooms_avaialable(start_date, end_date)
    # TODO  # use this method to check for avaialable room and return one instead of having multiple methods
      reserve_range = DateRange.new(start_date, end_date)

      x = reserve_range.get_date_range

      rooms_avaiable = []

      @rooms.each do |room|
        room_reservations.each do |reservation|
          if reservation.date_range.check_overlap(x) == true
            rooms_avaiable << reservation.room
          end
        end
      end
      return rooms_avaiable
    end

    # list the reservations for a specific date
    def list_reservations(date)

      return @reservations.select {|reservation| reservation.start_date == date }
    end

    # checking for room availability before booking the room
    # def find_available_room(start_date, end_date)
    #
    #   reserve_range = DateRange.new(start_date, end_date)
    #
    #   x = reserve_range.get_date_range
    #
    #
    #   @rooms.each do |room|
    #     room_reservations.each do |reservation|
    #       if reservation.date_range.check_overlap(x) == true
    #         return reservation.room
    #       end
    #     end
    #   end
    #
    #   return false
    #
    # end

    def make_booking(start_date, end_date)

      # find a room that is available
      room_to_book = find_available_room(start_time, end_time)

      if room_to_book == false
        raise StandardError
        # TODO  # raise an exception when trying to reserve and there are no available room
      else
        # Tallying the estimated total cost from the date range
        estimated_cost = reservation.cost_calculator

        info = {id: rand(1..300),
          room: room_to_book,
          start_date: start_date,
          end_date: end_date,
          total_cost: estimated_cost
        }
        # Creating an instance of a new reservation
        new_reserv = Reservation(info)
        # Addint this new reservation to the list (array) of reservations for the room in the room class
        room.add_bookings(new_reserv)
        # Adding this new reservation to the list (array) of reservations in the booking class
        @reservations << new_reserv
      end
    end



  end
end
