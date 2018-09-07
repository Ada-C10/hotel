require 'date'

class Reservation
  attr_reader :check_in_date, :check_out_date, :room_cost
  attr_accessor :id, :total_cost

  def initialize(check_in_date, check_out_date, room_cost: 200)
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
    raise ArgumentError, "invalid dates" if @check_in_date >= @check_out_date
    @id = 0
    @room_cost = room_cost
  end

  def length_of_stay
    duration = check_out_date - check_in_date
    return duration
  end

  def total_cost
    total = length_of_stay * @room_cost
    return total
  end
end

class BlockOfRooms < Reservation
  attr_accessor :collection_rooms

  def initialize(check_in_date, check_out_date, room_cost: 200)
    super(check_in_date, check_out_date)
    @id = 0
    @room_cost = room_cost
    @collection_rooms = []
  end

  def add_room(room)
    @collection_rooms << room
  end
end
