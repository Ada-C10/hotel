class Room
  attr_reader :id
  attr_accessor :unavailable_dates

  def initialize(id)
    @id = id
    @unavailable_dates = []
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

  def is_available?(check_in,check_out)
    date_range = (check_in...check_out).to_a
    if date_range.all? { |date| unavailable_dates.include?(date) }
      return 0
    else
      return self.id
    end
  end


end
