require 'awesome_print'
#concierge can VIEW reservations
#concierge can RESERVE reservation
#concierge can ACCESS receipt for completed stay
#concierge can ACCESS hotel room list = yes

module Lodging #namespace
  #similar to the main.rb of other projects
  class Concierge #small hotels have concierges

    def self.all_rooms
      Room.show_list.each do |room|
        ap "Room #{room.room_number} costs $#{room.cost} a night and is #{room.status}."
      end
    end


  end
end
