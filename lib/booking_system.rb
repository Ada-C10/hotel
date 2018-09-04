require_relative 'room.rb'

class BookingSystem
  attr_reader :num_rooms, :rooms

  def initialize()
    @num_rooms = 20
    @rooms = []
  end

  # access the list of all of the rooms in the hotel
  def list_all_rooms
    @num_rooms.times do |room|
      @rooms << Room.new(room)
    end
    return @rooms
  end

  # reserve a room for a given date range
  def reserve(check_in_date, check_out_date)
  end

  # access the list of reservations for a specific date
  # get the total cost for a given reservation
end
