require 'date'

module Hotel
  class HotelManager
    attr_reader :rooms

    # As an administrator, I can access the list of all of the rooms in the hotel
    def initialize
      @rooms = Room.all
      # @reservations = []
    end

    # As an administrator, I can reserve a room for a given date range


    # def self.available_rooms(check_in, check_out)
    #   available = []
    #   rooms = self.all
    #
    #   date_array = *(Date.parse(check_in)...Date.parse(check_out))
    #
    #   rooms.each do |room|
    #     available << room if (room.calendar & date_array).empty?
    #   end
    #
    #   if available.empty?
    #     return nil
    #   else
    #     return available
    #   end
    #
    # end
  end
end
