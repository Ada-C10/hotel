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
end
