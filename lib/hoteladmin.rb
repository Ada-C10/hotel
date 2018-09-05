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
    reservations_for_date = []
    reservations.each do |res|
      check_in = res.date_range.first
      check_out = res.date_range.last
      if (check_in..check_out).include? date
        reservations_for_date << res
      end
    end
    reservations_for_date
  end

end
