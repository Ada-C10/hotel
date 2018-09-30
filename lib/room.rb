module Hotel
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
        if !(requested_dates.last <= booking.date_range.first || requested_dates.first >= booking.date_range.last)
          return false
        end
      end
      return true
    end

    def available_in_block(party)
      bookings.any? { |b| b.block_available?(party)}
    end

  end
end
