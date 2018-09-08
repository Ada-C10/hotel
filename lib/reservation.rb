# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# The Reservation class is responsible for calculating reservation cost
  class Reservation
    require "date"

    attr_reader :range, :room_number, :room_rate

    def initialize(daterange:, room_number:, room_rate:)
      @range = daterange.to_range
      @room_number = room_number # what about room.number
      @room_rate = room_rate # and room.rate
    end

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
