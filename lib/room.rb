require 'date'

module Hotel
  class Room
    attr_reader :id
    attr_accessor :calendar

    def initialize(id)
      @id = id
      @calendar = []
    end

    def self.all
      rooms = []

      20.times do |i|
        rooms << Room.new(i+1)
      end

      return rooms
    end

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
