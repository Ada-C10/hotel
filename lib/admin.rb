require 'awesome_print'
#concierge can VIEW reservations
#concierge can RESERVE reservation
#concierge can ACCESS receipt for completed stay
#concierge can ACCESS hotel room list

module Lodging #namespace
  #similar to the main.rb of other projects
  class Concierge #small hotels have concierges

    def self.all_rooms
      print Room.show_list

    end


  end
end
