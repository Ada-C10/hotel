module Lodging #name space to contain all info, including non-inherited classes
  class Room < Hotel
    def initialize(room_number, status)
      @room_number = room_number
      @status = status #available, unavailable, hold?
    end
  end

end
