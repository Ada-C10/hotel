require_relative 'reservation.rb'
require_relative 'room.rb'
require 'Date'


ROOMS_PRIOR_TO_BOOKING =  [{1=>[]},{2=>[]},{3=>[]},{4=>[]},{5=>[]},{6=>[]},{7=>[]},{8=>[]},
{9=>[]},{10=>[]},{11=>[]},{12=>[]},{13=>[]},{14=>[]},{15=>[]},{16=>[]},{17=>[]},
{18=>[]},{19=>[]},{20=>[]}]

class Admin

  @@rooms = ROOMS_PRIOR_TO_BOOKING

  # def initialize
  #   @check_array = []
  # end

  def view_all_rooms
    puts @@rooms
  end

  def reserve(room_number, check_in_date, check_out_date)
    if Date.parse(check_in_date).class != Date ||
      Date.parse(check_out_date).class != Date ||
      Date.parse(check_in_date) > Date.parse(check_out_date)
       raise StandardError, "Dates are invalid!"
    end
    # if @check_array != []
    #   @check_array.each do |array|
    #     if array[0] == room_number &&
    #        Date.parse((array[1])[0]) >= check_in_date &&
    #         Date.parse((array[1])[1]) <= check_out_date
    #           raise Error, "Dates booked!!"
    #     end
    #   end
    # end
    Reservation.new(room_number, check_in_date, check_out_date)
    rooms_sent = @@rooms
    Room.new(room_number, check_in_date, check_out_date, rooms_sent)
    @@rooms = Room.rooms
  end

  def rooms_reserved_by_date(date)
    @@rooms.each do |hash|
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
    Reservation.reservations.each do |array|
      if array[3] == reservation_id
        puts array[4]
      end
    end
  end

  def check_availability (check_in_date, check_out_date = nil)
    if check_out_date == nil
      date = check_in_date
      @@rooms.each do |hash|
        hash.each do |key,value|
          value.each do |date_range|
            if Date.parse(date) < Date.parse(date_range[0]) || Date.parse(date) >= Date.parse(date_range[1])
             puts "Date is available for room number #{key}"
            # else
            #   @check_array << [key,value]
            end
          end
          if value == []
            puts "Date is available for room number #{key}"
          end
        end
        return false
      end
   else
    #unavailable = 0
    @@rooms.each do |hash|
      hash.each do |key, value|
        if value != []
          value.each do |date_range|
            if Date.parse(check_in_date) < Date.parse(date_range[0]) && Date.parse(check_out_date) <= Date.parse(date_range[0]) ||
              Date.parse(check_in_date) >= Date.parse(date_range[1]) && Date.parse(check_out_date) > Date.parse(date_range[1])
              puts "Room #{key} is available"
            # else
            #   @check_array << [key,value]
            end
          end
        else
          puts "Room #{key} is available"
        end
        if unavailable == 20
          puts "No rooms available!"
        end
      end
    end
  end
end
end

test = Admin.new
test.reserve(7,"2018-08-09","2018-08-11")
test.reserve(7,"2018-08-10","2018-08-11")
# test.print_total_cost_per_reservation("2018/1")
# # #
# test.reserve(8,"2018-06-21","2018-07-05")
# #print Reservation.reservations
# test.print_total_cost_per_reservation("2018/2")
#test.view_all_rooms


test.view_all_rooms
#test.rooms_available_by_date("2018-08-19")
test.rooms_reserved_by_date("2018-08-14")
#test.check_availability("2018-08-17")
#test.print_total_cost_per_reservation(3)
# test.view_reservations_on_a_date("2018-08-24")
