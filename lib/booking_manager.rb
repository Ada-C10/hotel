require_relative 'room'

module Hotel
  class BookingManager
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = populate_room_list
      @reservations = reservations
    end # of def initialize

    # Create list of rooms as list of room Instances
    def populate_room_list(number_rooms)
      rooms = []
      num = 1

      number_rooms.times do |room|
        room = Room.new(num)
        rooms << room
        num += 1
      end # of number_rooms loop
    end # of populate_room_list method 

    # Method to list all rooms in hotel
    # def list_rooms
    #   @rooms
    # end

    # Method to list all reservations
    # def list_reservations
    # end

    # Method to get total cost of reservation

  end # of class BookingManager
end # of module Hotel
