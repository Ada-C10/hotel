# create module for reservations to hold classes
require 'pry'
require_relative 'date_range'
module Hotel

  class ReserveRoom < DateRange
    attr_reader :room_number
    attr_accessor :cost

    def initialize(start_date,end_date, cost)
      @cost = cost
      super(start_date, end_date)
    end

    def self.create_reservation
    end

    def calculate_cost
      nights = @end_date - @start_date
      @cost = nights * 200.to_f
    end

    def available_rooms
      dates = DateRange.new(start_date, end_date)
      available_rooms = @rooms
    end
  end
end

#     def check_room_status
#       @rooms.each do |status|
#         if :room_status == :Available
#           puts 'Room is Available.'
#         elsif :room_status == :Unavailable
#           puts 'Room is Unavailable.'
#         end
#       end
#     end
#   end
# end
#
#
# open_rooms = []
# reserved_rooms = []
# def lists_booked_rooms
# start_date = Date.parse('20/09/2018')
# end_date = Date.parse ('30/09/2018')
# date_range = (start_date..end_date)
# @all_rooms.to_a.each do |room|
#   @booked_rooms.to_a.each do |room|
#     if all_rooms.room_number != booked_rooms.room_number
#       open_rooms << room
#     elsif all_rooms.room_number == booked_rooms.room_number
#       reserved_rooms << room
#     end
#    end
# end
# end

# Two date ranges *do* overlap if range A compared to range B:
# - Same dates
# - Overlaps in the front
# - Overlaps in the back
# - Completely contained
# - Completely containing
#
# Two date ranges are *not* overlapping if range A compared to range B:
# - Completely before
# - Completely after
# - Ends on the checkin date
# - Starts on the checkout date
