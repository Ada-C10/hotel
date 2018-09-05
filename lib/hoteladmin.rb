class HotelAdmin
  attr_accessor :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []
  end

  def list_rooms
    rooms
  end

end
