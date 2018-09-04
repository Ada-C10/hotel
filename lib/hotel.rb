class Hotel


  def initialize
    @rooms = []
    set_up_rooms(20)
  end


  def set_up_rooms(number_of_rooms)
    number_of_rooms.times do |i|
      @rooms << Room.new(i + 1, 200)
    end
  end

  def room_list
    return @rooms
  end

  def make_reservation(start_date, end_date)
  end

  def find_reservations_by_date(date)
  end

  def find_price_of_reservation(reservation_id)
  end


end
