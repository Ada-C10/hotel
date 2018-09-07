require 'awesome_print'
#concierge can VIEW reservations
#concierge can RESERVE reservation
#concierge can ACCESS receipt for completed stay
#concierge can ACCESS hotel room list = yes

module Lodging #namespace
  #similar to the main.rb of other projects
  class Concierge #small hotels have concierges
    attr_accessor :room_hash

    @room_hash = []

    def self.all_rooms
      Room.show_list.each do |room|
        room_info = {}
        # room = "Room #{room.room_number} costs $#{room.cost} a night and is #{room.status}."
        room_info[:room_number] = room.room_number
        room_info[:price] = room.cost
        room_info[:status] = room.status

        @room_hash << room_info
      end
      return @room_hash
    end


  end
end
