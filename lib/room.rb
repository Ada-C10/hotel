require 'awesome_print'
require 'Date'

class Room

  def initialize(room_number, check_in_date, check_out_date, rooms_sent)
      @room_number = room_number
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @dates = [check_in_date, check_out_date]
      @@rooms_array = rooms_sent
      #confirm_valid_dates
      book_room
  end

  attr_writer :room_number, :check_in_date, :check_out_date, :rooms
   #
   # def confirm_valid_dates
   #   @@rooms_array.each do |room|
   #     room.each do |key, value|
   #       if room.keys[0] == @room_number && room.values != []
   #          room.values.each do |date_pair|
   #            if Date.parse(date_pair[0]) <= Date.parse(@dates[0]) &&
   #               Date.parse(date_pair[1]) > Date.parse(@dates[0])
   #               raise ArgumentError, "Already booked!!"
   #            end
   #          end
   #       end
   #    end
   #   end
   # end

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

def self.rooms
  return @@rooms_array
end

end
