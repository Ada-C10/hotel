require 'pry'

module Hotel
  class Room
    attr_reader
    def initialize(number)
      @id = number
      @reservations = []
    end

    def self.create_rooms(number_of_rooms)
      rooms = []
      (1..number_of_rooms).each do |number|
        @rooms << Room.new(number)
      end
      return rooms
  end
end
