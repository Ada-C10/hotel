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

  def find_bookings(date)
    bookings.select { |b| b.date_range.include? date }
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

  def available_in_block(party)
    bookings.any? { |b| b.block_available?(party)}
  end

end
