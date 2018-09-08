require 'awesome_print'
require 'date'
require 'pry'
#reservation CREATES reservations
#reservation TOTALS costs of stay

module Lodging

  def self.room_status(input) #check room_status
    avail = input.find do |room|
      room[:status] == :available #returns first instance it finds of available room
    end

    return avail
  end

  # module Reservation

    def self.reservation(input) #switches status from avail to unavail
      room = Lodging.room_status(input)

      room[:status] = status

      Lodging::Room.status_change(room[:room_number], status)

      room[:start_date] = nil
      room[:end_date] = nil
      # check status, if available
      # takes date range
      # switches status to unavailable
    end
  # end

  def self.receipt #calculates total cost of stay
    #counts days in range
    #multiply count by
    #can date var -= 1 to get day before

  end


end
