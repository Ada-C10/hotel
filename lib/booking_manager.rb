require_relative 'room.rb'
require_relative 'reservation.rb'


class BookingManager

  attr_reader :rooms
  attr_reader :reservations
  @@reservations = []

  def initialize
    @rooms = []
    i = 0
    20.times do |i|
      @rooms << {number: i+1, availiable: true}
      i += 1

    end
    #binding.pry
  end

  def find_room
    room_number = 237
    searching = true
    while searching
      @rooms.each do |hash|
        if hash[:availiable]
          room_number = hash[:number]
          return room_number
        end
        searching = false
      end
    end
  end

end
