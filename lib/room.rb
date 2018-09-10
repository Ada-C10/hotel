require 'pry'
require 'Date'

module Hotel
  class Room
    attr_reader :id
    attr_accessor :reservations

    def initialize(number)
      @id = number
      @reservations = []
      #define room as physical space
    end

   #  def self.find_room(id)
   #    if room.id == id
   #      return room
   #    end
   # end

    #wave 2 def is_available(check_in:, check_out:)
    #   date_range = Date.parse(check_in)..Date.parse(check_out)
    #   #loop through room reservations, reject rooms with reservations that conflict with
    #   #requested date range
    #   self.reservations.reject {@reservations} date_range
    #   # end
    # end
  end
end
