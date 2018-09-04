require_relative 'room'

class Hotel_Manager
  attr_reader :rooms

  def initialize
    @rooms = []
    @reservations = []
    number = 1
    while number <= 20
      room = Room.new(number)
      @rooms << room
      number += 1
    end
  end

end
