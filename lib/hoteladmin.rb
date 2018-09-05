class HotelAdmin
  attr_accessor :rooms, :reservations

  def initialize
    @rooms = []
    @reservations = []
  end

  def list_rooms
    rooms
  end

  def retrieve_by_date(date)
    raise ArgumentError, "Valid date format was not provided." if date.class != Date
    reservations.select { |res| (res.date_range.first..res.date_range.last).include? date }
  end

  # def reserve_room
  #
  #   # @guest_id = guest_id
  #   # @room_id = room_id
  #   # @date_range = date_range
  # end

end
