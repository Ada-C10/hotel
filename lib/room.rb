require 'pry'
class Room
  attr_reader :id, :bookings

  def initialize(id)
    @id = id
    @bookings = []
  end

  def add_booking(reservation)
    raise ArgumentError, "Conflicting reservation, cannot complete transaction." if !available?(reservation.date_range)
    @bookings << reservation
    reservation
  end


  def available?(requested_dates)
    bookings.each do |booking|
      previously_reserved = booking.date_range
      previously_reserved.each do |night|
        return false if requested_dates.include? night
      end
    end
    return true
  end

end
