class Booking

  attr_reader :rooms

  def initialize
    # Creating 20 rooms
    @rooms = []
    i = 1
    20.times do
      @rooms << Room.new(i, [])
      i += 1
    end
  end

  def list_all
    @rooms.each do |room|
      puts "Room: #{room.room_number}"
    end
  end

end
