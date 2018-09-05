module Hotel
  class RoomBooker
    attr_reader :rooms, :reservations

    def initialize
      # All my rooms
      @rooms = (1..20).to_a
      # List of reservations. Organized by room?
      @reservations = []

      # If we need reservations for a particular room:
      # @reservations.select { |res| res.room_number == room_number }
    end

    def list_rooms
      return @rooms
    end

    # def make_reservation(start_date, end_date)
    #
    #   reservation = Reservation.new(...)
    #   @reservations << reservation
    # end



  end
end

# a = Hotel::RoomBooker.new()
# puts a.list_rooms
