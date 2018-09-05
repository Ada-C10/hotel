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
  end
end
