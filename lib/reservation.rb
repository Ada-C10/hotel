# Nessary - do not remove
# gems
require "date"
# libfiles

# Optional - for developer use
require "pry"
require "awesome_print"

# .conflict?

module HotBook
# Reservation.new(daterange:) #optional: room_number: :1, room_rate: 200.0
  class Reservation
    attr_reader :daterange, :room_number, :room_rate,

    def initialize(daterange:, room_number: :1, room_rate: 200.0)
      @daterange = daterange
      @room_number = room_number # what about room.number
      @room_rate = room_rate # and room.rate
      # check_errors
    end

    # def check_errors
    #   raise ArgumentError, "something's missing in your args hash" if
    #     start_date == nil || end_date == nil
    #   raise ArgumentError, "couldn't parse a date to date object" unless
    #     start_date.class == Date || end_date.class == Date
    #   raise StandardError, "end date must be later than start date" unless
    #     duration > 0
    # end

    def cost
      return duration * room_rate
    end

  end

end

# TODO:
# Custom error message!
# valid as a class method?
#
# - provide :start_date and :end_date
#     - later, reservation class comes up with a room number
#     - ruby makes a reservation object
#         - :start_date
#         - :end_date
#         - :room_number (default to default, define default as room 1)
# provide reservation
#    - reservation returns number of nights total
#    - RoomCharge class knows it's duration - 1, and multiplies nights by room cost
  # - reservation shouldn't know anything about cost
# later, reservation could ask hotel for room number
# to assign to a new reservation


# ## WAVE2
# - provide: start_date and :end_date
#     - Reservation class can return
