require 'pry'
require_relative 'room'

class ReservationMgr
  attr_reader :rooms
  def initialize
    @rooms = []
    20.times do |room_number|
      @rooms << Room.new(room_number)
    end
  end
end
