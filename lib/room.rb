#As an administrator, I can access the list of all of the rooms in the hotel
class Room
  attr_reader :id
  attr_accessor :bookings

  def initialize(id)
    @id = id
    @bookings = []
  end

  def add_booking(reservation)
    @bookings << reservation
  end

  def available?(start_date, end_date)

  end

end
