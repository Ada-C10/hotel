require_relative 'room'
require_relative 'reservation'
require 'time'

class Booking
  attr_reader :rooms

  def initialize
    @rooms = Array.new(20)
      @rooms.length.times do |x|
        room_number = x + 1
        @rooms[x] = Room.new(room_number, :available)
      end
  end
end
