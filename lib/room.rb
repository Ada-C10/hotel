# room class as part of the Hotel module
# contains id, status, cost, and potentially booked dates/availability
#
# class methods
# find all/list all room instances
require 'csv'

module Hotel
  class Room
    attr_reader(:id)
    attr_accessor(:cost)
    def initialize(input)
      # binding.pry
      @id = input[:id]
      # @booked_dates = []
      @cost = input[:cost]
    end
    # factory method to create room objects
    def self.all
      all_rooms = []
      20.times do |i|
        all_rooms << Room.new(id: i + 1, cost: 200.00)
      end

      return all_rooms
    end

    # method to find a room
    def self.find_room(id)
      @id.find { |room| room.id == id }
    end
  end
end