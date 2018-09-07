require 'awesome_print'
#reservation CREATES reservations
#reservation STORES reservations
#reservation TOTALS costs of stay

module Lodging

  def self.room_status(input) #check room_status
    input.find do |room|
      room[:status] == :available #returns first instance it finds of available room
    end
  end

  def self.reservation #creates reservation
    #check status, if available
    #takes date range
    #switches status to unavailable
    #
  end

  def self.receipt #calculates total cost of stay
    #counts days in range
    #multiply count by

  end

end
