# room class as part of the Hotel module
# contains id, status, cost, and potentially booked dates/availability
#
# class methods
# find all/list all room instances
module Hotel
  class Room
    attr_reader(:id, :cost, :booked_dates)
    def initialize(id, cost = 200.00)
      @id = id.to_i
      @booked_dates = []
      @cost = cost
    end
    # method to find info on a room
    def self.find_room(id)
      @id.find { |room| room.id == id }
    end

    # method to find all available rooms
    def self.find_available_rooms

    end



    def self.all
      all_rooms = []
      20.times do |i|
        all_rooms << Room.new(i + 1)
      end
      # binding.pry
      return all_rooms
    end
  end
end