# room class as part of the Hotel module
# contains id, status, cost, and potentially booked dates/availability
#
# class methods
# find all/list all room instances
module Hotel
  class Room
    attr_reader(:id, :cost, :booked_dates)
    def initialize(id, booked_dates, cost = 200.00)
      @id = id
      # @booked_dates = {}
      @cost = cost
    end

    def self.make_rooms
      all_rooms = []
      20.times do |i|
        all_rooms << Room.new(i + 1, {})
      end
      # binding.pry
      return all_rooms
    end
  end
end