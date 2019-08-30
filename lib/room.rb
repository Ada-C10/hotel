# room class as part of the Hotel module
# contains id, status, cost, and potentially booked dates/availability
#
# class methods
# find all/list all room instances
require 'csv'

module Hotel
  class Room
    attr_reader(:id, :cost)
    def initialize(input)
      @id = input[:id]
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

  end
end