require_relative 'room'

module Hotel
  class BookingManager
    attr_accessor :rooms, :reservations

    def initialize
      @rooms = list_rooms
      @reservations = list_reservations
    end # of def initialize

    # Create list of rooms as list of room Instances
    def populate_room_list

    end

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
