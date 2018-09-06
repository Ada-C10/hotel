# room class as part of the Hotel module
# contains id, status, cost, and potentially booked dates/availability
#
# class methods
# find all/list all room instances
module Hotel
  class Room
    attr_reader(:id, :cost, :booked_dates)
    def initialize(id, cost = 200.00)
      @id = id
      @booked_dates = []
      @cost = cost
    end
    # method to find info on a room
    def self.find_room(id)
      @id.find { |room| room.id == id }
    end
    # method to populate an array with dates in reserved range
    def get_date_range_arr(rsv_start, rsv_end)
      @booked_dates << (rsv_start...rsv_end).map do |date|
        date.strptime('%d-%m-%Y')
      end
    end


    def self.make_rooms
      all_rooms = []
      20.times do |i|
        all_rooms << Room.new(i + 1)
      end
      # binding.pry
      return all_rooms
    end
  end
end