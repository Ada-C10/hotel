require 'date'

class Reservations

  def initialize(check_in, check_out, date_1, date_2) unique_indentifier)
    @check_in = check_in
    @check_out = check_out
    @check_in_parse = check_in_parse
    @check_out_parse = check_out_parse
    @unique_indentifier = unique_indentifier
  end

  def make_reservation(check_in, check_out) #stores reservations by dates
    check_in_parse = Date.parse(check_in)
    check_out_parse = Date.parse(check_out)
  end

  def duration(check_out_parse, check_in_parse) #length of reservation
    duration = @check_out_parse - @check_in_parse
    return duration
  end

 #how to assign duration to [hotel_rooms]

  def random_num #assign unique indentifier to durations
  end
