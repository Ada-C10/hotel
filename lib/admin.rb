require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'

class Admin
  attr_reader :reservations, :rooms

  def initialize
    @rooms = []
    @reservations = []
    20.times do |i|
      room_new = Room.new(i+1)
      @rooms << room_new
    end
  end

  # def make_reservation
  #
  # end
  #
  # def find_room(id)
  #   check_id(id)
  #   return @rooms.find { |room| room.room_num == id }
  # end
  #
  # def calculate_cost
  #
  # end
  #
  # private
  #   def check_id(id)
  #     raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
  #   end
  #

end
