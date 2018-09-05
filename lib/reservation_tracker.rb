require 'time'
require 'date'

class ReservationTracker
  attr_reader :all_rooms

  def initialize()
    @all_rooms = []

    room_numbers = [*1..20]
    room_numbers.each do |room_num|
      new_room = Room.new(room_num)
      @all_rooms << new_room
    end

    @all_reservations = []
  end

end
