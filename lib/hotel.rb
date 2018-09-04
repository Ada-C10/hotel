module Lodging #name space to contain all info, including non-inherited classes
class Hotel
  attr_reader :hotel_name

  def initialize(hotel_name, rooms)
    @hotel_name = hotel_name
    @room_count = rooms
  end


end

end
