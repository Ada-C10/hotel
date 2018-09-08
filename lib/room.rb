# Keeps track of 1 room_
class Room
  attr_reader :room_number

  def initialize(room_number)
    @room_number = room_number
  end

  def is_room_available?(date)
    @reservation.each do |reservation|
      return false if reservation.check_in_date <= date && reservation.check_out_date > date
    end
    return true
  end
end
# end
