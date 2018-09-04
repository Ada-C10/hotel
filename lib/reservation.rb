# The resevation class will likely exist in the hotel module
# the reservation class will contain an id, a list of room id's
# that are booked in the reservation, the reservation start date,
# the reservation end date
module Hotel
  class Reservation
    attr_reader :id, :guest_name, :included_rooms, :rsv_start, :rsv_end, :total_cost
    def initialize(id, guest_name, included_rooms, rsv_start, rsv_end, total_cost)
      raise ArgumentError if rsv_end < rsv_start
      raise ArgumentError if included_rooms.empty?
      # must check nil first to stacktrace error
      raise ArgumentError if guest_name.nil? || guest_name.empty?

      @id = id # reservation id
      @guest_name = guest_name # name of guest holding reservation
      @included_rooms = [] # array - list of rooms booked for reservation
      @rsv_start = Date.parse(rsv_start) # reservation start date
      @rsv_end = Date.parse(rsv_end) # reservation end data
      @total_cost = total_cost
      # TODO: implement booking type for standard vs block booking ??? hmm
      # @booking_type = booking_type # :STANDARD, :BLOCK
    end

    # method to list all reservations
  end
end