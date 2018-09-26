module Hotel
  class BookingDates
    class InvalidBookingDatesError < StandardError
    end

    attr_reader :checkin, :checkout

    def initialize(checkin, checkout)
      unless checkout > checkin
        raise InvalidBookingDatesError, "Checkin must be before checkout."
      end

      @checkin = checkin
      @checkout = checkout
    end

    def nights
      return checkout - checkin
    end

    def overlaps?(other_booking)
      return !(other_booking.checkout <= self.checkin || other_booking.checkin >= self.checkout)
    end

    def contains?(date)
      return date >= self.checkin && date < self.checkout
    end
  end
end
