class Room
  attr_reader :id
  attr_accessor :bookings

  def initialize(id)
    @id = id
    @bookings = []
  end

  def add_booking(reservation)
    #Raise exception here?
    #(reservations.date_range[0]..
    @bookings << reservation
  end

  def available?(check_in, check_out)
    requested = (check_in..check_out).to_a
    bookings.each do |booking|
      previously_reserved = (booking.date_range[0]...booking.date_range[-1]).to_a
      previously_reserved.each do |night|
        return false if requested.include? night
      end
    end
    return true
  end

end
