require 'awesome_print'

module Lodging

  #creates multiple rooms at once, and assigns room number
  def self.create_rooms(room_count, cost = 200) #creates new rooms, assigns room no.
    raise ArgumentError if !room_count.is_a? Integer
    i = 1
    room_count.times do
      Room.new(i, cost)
      i += 1
    end
  end

def self.room_status(input, check_in) #check room_status
  avail = input.find do |room|
    room[:reserved_dates].last == Date.parse(check_in) || room[:status] == "available" #returns first instance it finds of available room
  end

  raise ArgumentError if avail == false

  return avail
end

def self.total_owed(multiplier, price) #date step method to determine day count
    total = multiplier.to_f * price.to_f
    return total.round(2)
end

def self.create_date_range(date1, date2)
  return (Date.parse(date1)..Date.parse(date2)).to_a
end


end
