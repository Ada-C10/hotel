require 'pry'
require_relative 'room'

class ReservationMgr
  attr_reader :rooms
  def initialize
    @rooms = Room.create(20)

  end
end

yay = ReservationMgr.new
p yay.rooms[0]
p yay.rooms[0].class
