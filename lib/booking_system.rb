require_relative 'reservations'

module Hotel
  class BookingSystem
    attr_reader :reservations

     room_list = [
      "Room 1", "Room 2", "Room 3", "Room 4", "Room 5", "Room 6", "Room 7", "Room 8", "Room 9", "Room 10", "Room 11", "Room 12", "Room 13", "Room 14" , "Room 15", "Room 16", "Room 17", "Room 18", "Room 19", "Room 20"
    ]

    def initalize
      @reservations = []
      @availibility = # boolean
      @list_of_avail_rooms
      @list_of_booked_rooms
    end

    # methods
    # - Check availibility of room
    # - generate a list of availible rooms?
    # - generate a list of booked rooms?
  end
end
