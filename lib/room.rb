require 'awesome_print'
require 'Date'

class Room

  def initialize(room_number, check_in_date, check_out_date, rooms_sent)
      @room_number = room_number
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @dates = [check_in_date, check_out_date]
      @@rooms_array = rooms_sent
  end

  attr_writer :room_number, :check_in_date, :check_out_date, :rooms


  def book_room
    @@rooms_array.each do |room|
      room.each do |key, value|
        if room.keys[0] == @room_number
          room.values[0] << @dates
          puts "Room number #{room.keys[0]} has been booked!"
        end
      end
    end
  end

  def block_room
    @@rooms_array.each do |room|
      room.each do |key, value|
        if room.keys[0] == @room_number
          room.values[0] << @dates
          puts "Room number #{room.keys[0]} has been blocked #{@dates}!"
        end
      end
    end
  end

  def book_blocked_room
    @@rooms_array.each do |room|
      room.each do |key, value|
        if room.keys[0] == @room_number
          puts "Room number #{room.keys[0]} has been booked - BLOCKED ROOM!"
        end
      end
    end
  end

def self.rooms
  return @@rooms_array
end

end
