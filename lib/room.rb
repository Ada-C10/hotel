class Room
  attr_reader :id

  def initialize(id)
    @id = id
    @unavailable_dates = []
    @status = :AVAILABLE
  end




  def self.create(number_rooms)
    rooms = []
    number_rooms.times do |room_number|
      rooms << Room.new(room_number + 1)
    end
    return rooms
  end

  def self.list
    return ObjectSpace.each_object(self).to_a
  end

end
