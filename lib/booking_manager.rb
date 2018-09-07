require_relative 'room.rb'
require_relative 'reservation.rb'


class BookingManager

  attr_reader :rooms
  attr_reader :reservations

  def initialize
    @reservations = []
    @rooms = []

    i = 1
    20.times do |i|
      @rooms << {number: i, availiable: true}
    end
  end



end
