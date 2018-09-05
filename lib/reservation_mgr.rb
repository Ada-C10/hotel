require 'pry'
require_relative 'room'

class ReservationMgr
  attr_reader :rooms
  def initialize
    @rooms = Room.create(20)
    @reservations = []

  end

  # def check_availability(check_in,check_out)
  #
  # end

end

# yay = ReservationMgr.new
# p yay.rooms[0]
# p yay.rooms[0].class
# puts Room.list
# puts Room.list.length
