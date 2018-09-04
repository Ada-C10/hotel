# require 'awesome_print'
# require_relative 'block'
# require_relative 'room'
# require_relative 'reservation'

#can access list of all rooms in hotel? = yes
#can create new rooms automagically? = yes

module Lodging #name space to contain all info, including non-inherited classes
  class Hotel
    attr_reader :name, :room_count, :rooms

    def initialize(hotel_name, room_count)
      raise ArgumentError if room_count == nil || room_count <= 0

      @name = hotel_name
      @room_count = room_count
      @rooms = create_rooms(room_count)
    end

    def create_rooms(room_number) #method to create instances of room based on room_count
      rooms = []
      room_number = 1

      @room_count.times do
        new_room = Room.new(room_number)
        room_number += 1
        rooms << new_room
      end
      return rooms
    end


  end
end
