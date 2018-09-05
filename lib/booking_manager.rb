# require 'pry'
require_relative 'room'

module Hotel
  class BookingManager
    attr_accessor :rooms, :reservations

    def initialize(number_rooms)
      @rooms = populate_room_list(number_rooms) #(20)
      @reservations = make_reservation_list
    end # of def initialize

    # Create list of rooms as list of room Instances
    def populate_room_list(number_rooms)
      rooms = []
      num = 1

      number_rooms.times do |room|
        room = Room.new(num)
        # room = "Room \# #{num}"
        rooms << room
        num += 1
      end # of number_rooms loop

      return rooms
    end # of populate_room_list method

    # Create array to store all of reservations
    def make_reservation_list
      reservations = []
      return reservations
    end

    # Method to list all reservations
    def list_reservations
      return @reservations
    end
# binding.pry
    # Method to list all rooms in hotel
    def list_rooms
      @rooms
    end

    # Method to add a reservation to list of reservations
    # def add_reservation(reservation)
    #   @reservations << reservation
    # end

    # Method to get total cost of reservation

  end # of class BookingManager
end # of module Hotel
