require_relative 'reservation.rb'
require_relative 'room.rb'
require 'Date'
require 'pry'


ROOMS_PRIOR_TO_BOOKING =  [{1=>[]},{2=>[]},{3=>[]},{4=>[]},{5=>[]},{6=>[]},{7=>[]},{8=>[]},
{9=>[]},{10=>[]},{11=>[]},{12=>[]},{13=>[]},{14=>[]},{15=>[]},{16=>[]},{17=>[]},
{18=>[]},{19=>[]},{20=>[]}]

class Admin
  # @@rooms = ROOMS_PRIOR_TO_BOOKING
  # @@blocked_rooms = []
  def initialize
    @rooms = ROOMS_PRIOR_TO_BOOKING
    @blocked_rooms = []
    @blocked_start_date = nil
    @blocked_end_date = nil
  end

  attr_accessor :blocked_start_date, :blocked_end_date

  def block_rooms(number_blocked, check_in_date, check_out_date)
    @blocked_start_date = check_in_date
    @blocked_end_date = check_out_date
    number_blocked.times do |i|
      rooms_sent = @rooms
      entry = Room.new((20 - i), @blocked_start_date, @blocked_end_date, rooms_sent)
      entry.block_room_in_room
      @rooms = Room.rooms
      @blocked_rooms << 20 - i
    end
    return @blocked_rooms
  end

  def book_blocked_room
    if @blocked_rooms != []
      room = @blocked_rooms[0]
      special_reservation = Reservation.new(room, @blocked_start_date, @blocked_end_date)
      special_reservation.cost_special
      rooms_sent = @rooms
      entry = Room.new(room, @blocked_start_date, @blocked_end_date, rooms_sent)
      entry.book_blocked_room_in_room
      @rooms = Room.rooms
      @blocked_rooms.delete(@blocked_rooms[0])
    end
    return @blocked_rooms
  end

  def view_all_rooms
    return @rooms
  end

  def reserve(room_number, check_in_date, check_out_date)
    if Date.parse(check_in_date) > Date.parse(check_out_date) ||
      Date.parse(check_in_date).class != Date ||
      Date.parse(check_out_date).class != Date
       raise StandardError, "Dates are invalid!"
    end

    Reservation.new(room_number, check_in_date, check_out_date)
    rooms_sent = @rooms
    entry = Room.new(room_number, check_in_date, check_out_date, rooms_sent)
    entry.book_room
    @rooms = Room.rooms
  end

  def rooms_reserved_by_date(date)
    @rooms.each do |hash|
      hash.each do |key, value|
        value.each do |date_range|
          if Date.parse(date) > Date.parse(date_range[0]) &&
            Date.parse(date) < Date.parse(date_range[1])
            puts "Room number #{key} is booked during this date"
          end
        end
      end
    end
  end

  def print_total_cost_per_reservation(reservation_id)
    Reservation.reservations.each do |reservation|
      if reservation[3] == reservation_id
        puts reservation[4]
      end
    end
  end

  def check_availability (check_in_date, check_out_date = nil)
    if check_out_date == nil
      date = check_in_date
      @rooms.each do |hash|
        hash.each do |key,value|
          value.each do |date_range|
            if Date.parse(date) < Date.parse(date_range[0]) || Date.parse(date) >= Date.parse(date_range[1])
             puts "Date is available for room number #{key}"
            end
          end
          if value == []
            puts "Date is available for room number #{key}"
          end
        end
      end
   else
    @rooms.each do |hash|
      hash.each do |key, value|
        if value != []
          value.each do |date_range|
            if Date.parse(check_in_date) < Date.parse(date_range[0]) && Date.parse(check_out_date) <= Date.parse(date_range[0]) ||
              Date.parse(check_in_date) >= Date.parse(date_range[1]) && Date.parse(check_out_date) > Date.parse(date_range[1])
              puts "Room #{key} is available"
            end
          end
        else
          puts "Room #{key} is available"
        end
      end
    end
  end
end



end

# test = Admin.new
# test.reserve(7,"2018-08-09","2018-08-11")
# test.reserve(7,"2018-08-02","2018-08-05")
# # test.print_total_cost_per_reservation("2018/1")
# # # #
# #test.reserve(8,"2018-06-21","2018-07-05")
# # #print Reservation.reservations
# # test.print_total_cost_per_reservation("2018/2")
# #test.view_all_rooms
#
# test.reserve(8,"2018-06-23","2018-07-02")
#test.block_rooms(4, "2018-06-11","2018-07-11")
#puts r.length
# print test.view_all_rooms
# test.rooms_reserved_by_date("2018-08-10")
# test.check_availability("2018-08-10")
# test.rooms_reserved_by_date("2018-07-10")
#test.book_blocked_room
# test.view_all_rooms
# Reservation.reservations
#test.print_total_cost_per_reservation("2018/2")
# # test.view_reservations_on_a_date("2018-08-24")
