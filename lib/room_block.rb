class RoomBlock
  attr_reader :check_in_date, :check_out_date, :dates_booked
  attr_accessor :id, :room_cost, :collection_rooms

  def initialize(check_in_date, check_out_date, id: 0, room_cost: 200)
    @check_in_date = Date.parse(check_in_date)
    @check_out_date = Date.parse(check_out_date)
    raise ArgumentError, "invalid dates" if @check_in_date >= @check_out_date
    @dates_booked = date_range(check_in_date, check_out_date)
    @id = 0
    @room_cost = room_cost
    @collection_rooms = []
  end

  def date_range(check_in_date, check_out_date)
    check_in_date = Date.parse(check_in_date)
    check_out_date = Date.parse(check_out_date)
    dates = []
    date = check_in_date
    while date < check_out_date
      dates << date
      date += 1
    end
    return dates
  end

  def add_room(room)
    @collection_rooms << room
  end
end
