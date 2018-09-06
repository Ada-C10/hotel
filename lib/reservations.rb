require 'date'

class Reservations

  def initialize(check_in, check_out, date_1, date_2) unique_indentifier)
    @check_in = time_in
    @check_out = time_out
    @check_in_parse = check_in_parse
    @check_out_parse = check_out_parse
    @room_num = room_num
    @unique_indentifier = unique_indentifier
  end

  def make_reservation(time_in, time_out, room_num) #stores reservations by dates
    if 
    @check_in = Date.parse(time_in)
    @check_out = Date.parse(time_out)
  end

  def duration(check_out, check_in) #length of reservation
    duration = @check_out - @check_in
    return duration
  end

 #how to assign duration to [hotel_rooms]

  def random_num #assign unique indentifier to durations
  end
