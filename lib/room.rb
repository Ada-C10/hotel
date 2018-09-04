# require_relative 'room'
# require_relative 'hotel'
# require_relative 'block'
# require_relative 'reservation'

module Lodging #name space to contain all info, including non-inherited classes
  class Room
    attr_reader :room_number, :status, :cost

    def initialize(room_number, cost = 200) #default price is 200/night
      @room_number = room_number
      @status = :AVAILABLE #available, unavailable, hold?
      @cost = cost
    end
  end
end
