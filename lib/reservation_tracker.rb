require 'pry'
require_relative 'room'
# Keeps track of the list of reservations
# module Hotel
class ReservationTracker
  attr_reader :rooms

  def initialize
    @rooms = create_rooms
    # @reservations = []
    # @existing_reservations = []
    # @unreserved_rooms = []

  end

  def create_rooms
    rooms = []
    (1..20).each do |room|
      room = Room.new(room)
      rooms << room
    end
    # binding.pry
    return rooms
  end

  # to access the list of all of the rooms in the hotel
  def list_of_all_rooms
    # binding.pry
    return @rooms
  end

  # def list_of_reservations
  # end

end
# end
