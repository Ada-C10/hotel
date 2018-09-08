class Room
  attr_reader :room_num
  attr_accessor :reservations

  def initialize(room_num: nil, reservations: [])
    @room_num = room_num
    @reservations = reservations
  end

  def is_available?(dates)
    @reservations.each do |reservation|
      dates.each do |date|
        if reservation.dates_booked.include?(date)
          return false
        end
      end
    end
    return true
  end

  def add_reservation_to_room(reservation)
    self.reservations << reservation
  end

end
