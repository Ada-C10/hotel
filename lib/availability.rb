require 'date'

class Availibility

  def range

    rooms.each do |room, reservation|
      puts room, reservation
    end

    reservation.each do |time|
      range = (time[:check_in]..time[:check_out])
    end
    return range
  end

  def avail_rooms (room_num, time_in, time_out)
    if range.include(time_in)
      raise ArgumentError.new("This date is reserved")
    elsif range.include(time_out)
      raise ArgumentError.new("This date is reserved")
    else
      rooms[:key] = room_num
      rooms[:key].value << 
