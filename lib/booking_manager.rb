# require 'pry'
require_relative 'room'
require_relative 'reservation'

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

  # Create a new instance of Reservation # should this and add_reservation be one method?
    def reserve(room)
    end

  # Method to add a reservation to list of reservations
    def add_reservation(reservation)
      @reservations << reservation
    end

    # Method to get total cost of reservation
    # Get cost from reservation?

    # Method to check room availability here? Or in room?
    # when check if something is available
    # search through reservations for room with nil -> reserve
    # if none with nil, search from beginning for date with specific dates.
    # if found, move to next room to check.
    # do rooms have a list of reserved dates? or no knowledge of dates?

  end # of class BookingManager
end # of module Hotel
