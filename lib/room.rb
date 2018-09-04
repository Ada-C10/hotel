module Hotel
  class Room
    attr_reader :id
    def initialize(id)
      @id = id
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
