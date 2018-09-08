require 'awesome_print'
require 'Date'
#require_relative 'admin'

class Room
  @@rooms = [{1=>[]},
{2=>[]},
{3=>[]},
{4=>[]},
{5=>[]},
{6=>[]},
{7=>[]},
{8=>[]},
{9=>[]},
{10=>[]},
{11=>[]},
{12=>[]},
{13=>[]},
{14=>[]},
{15=>[]},
{16=>[]},
{17=>[]},
{18=>[]},
{19=>[]},
{20=>[]}]

  attr_accessor :room_number, :check_in_date, :check_out_date
  def initialize(room_number, check_in_date = nil, check_out_date = nil)
    @room_number = room_number
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @dates = [Date.parse(check_in_date), Date.parse(check_out_date)]
  end

  def create_rooms_list
    rooms = []
    20.times do |i|
      index = i + 1
      new_room = {}
      new_room = {index => []}
      rooms << new_room
    end
    @@rooms = rooms
    return @@rooms
  end

  def book_room
    @@rooms.each do |room|
      room.each do |key, value|
        if room.keys[0] == @room_number
          room.values[0] << @dates
          puts "Your room has been booked!"
        end
      end
    end
  end

  def check_availability #(check_in_date, check_out_date)
    #unavailable = 0
    @@rooms.each do |hash|
      hash.each do |key, value|
        if value != []
          value.each do |date_range|
            if Date.parse(@check_in_date) < date_range[0] && Date.parse(@check_out_date) <= date_range[0] ||
              Date.parse(@check_in_date) >= date_range[1] && Date.parse(@check_out_date) > date_range[1]
              puts "Room #{key} is available"
            # else
            #   unavailable += 1
            end
          end
        else
          puts "Room #{key} is available"
        end
      end
    end
  end
    # if unavailable == 20
    #   puts "Sorry no rooms available for given date range"
    # end


  def self.rooms_available_by_date(date)
    @@rooms.each do |hash|
      hash.each do |key,value|
        value.each do |date_range|
          if Date.parse(date) < date_range[0] || Date.parse(date) > date_range[1]
           puts "Dates are available for room number #{key}"
          end
        end
      end
    end
  end

  def self.rooms_reserved_by_date(date)
    @@rooms.each do |hash|
      hash.each do |key, value|
        value.each do |date_range|
          if Date.parse(date) > date_range[0] && Date.parse(date) < date_range[1]
            puts "Room number #{key} is booked during this date"
          end
        end
      end
    end
  end

end

x = Room.new(3,"2018-08-21", "2018-08-30" )
x.create_rooms_list
x.book_room
x.check_availability
Room.rooms_available_by_date("2018-08-22")
Room.rooms_reserved_by_date("2018-08-22")

# Room.rooms_reserved_by_date("2018-08-27")
# Room.rooms_available_by_date("2018-08-27")

# xyz = Room.new(5, "2018-12-07", "2018-11-03")
# print xyz.view_rooms
#
# tun = Room.new(6)
