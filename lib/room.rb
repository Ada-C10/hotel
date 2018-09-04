
require 'pry'

class Room
  attr_reader :room_number
  attr_reader :availability

  def initialize(room_number, availability)
    @room_number = room_number
    @availability = availability

    valid_rooms = (1..20).to_a
    if valid_rooms.include?(room_number)
      red_rum = false
    else
      raise ArgumentError.new("Invalid room number")
    end

    valid_status = [:available, :unavailable]
    if valid_status.include?(availability)
      bad_status = false
    else
      raise ArgumentError.new("Invalid room status")
    end

  end

  def is_available?
    if @availability == :available
      status = true
    else
      status = false
    end
    return status
  end
end
