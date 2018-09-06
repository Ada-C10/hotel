require 'date'
require_relative "reservation"
require_relative "date_range"


module Hotel
  class BookingSystem
    attr_reader :rooms, :reservations, :availibility

    def initialize (rooms, reservations, availibility)
      @rooms =
      [
        {room_number: 1}, {room_number: 2}, {room_number: 3}, {room_number: 4}, {room_number: 5}, {room_number: 6}, {room_number: 7}, {room_number: 8}, {room_number: 9}, {room_number: 10}, {room_number: 11}, {room_number: 12}, {room_number: 13}, {room_number: 14}, {room_number: 15}, {room_number: 16}, {room_number: 17}, {room_number: 18}, {room_number: 19}, {room_number: 20}
      ]

      @reservations = []
      @availibility = availibility


      # keep track of reservations - make sure # of reservations have increased by 1

      # method to make_reservation
      # return if successful return res_id, or "sucess", or return true

      #method to find an availible room:
      # input:start, end. output:availible room

      # use a helper method to check_overlapping dates:
      # input: reservation attempt: (start date and end date) compare to an existing reservation
      # Output: boolean
      #edge case: begining of res or end of res can overlap(but check_out and check_in can be same date)

      #edge case - what if there are no available rooms?
      #edge case -
      #
      #





      # methods
      # - Check availibility of room
      # - generate a list of availible rooms?
      # - generate a list of booked rooms?
    end
  end
end
