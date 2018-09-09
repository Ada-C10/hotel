# create module for reservations to hold classes
require 'pry'
module Reservation

  class ReserveRoom
    attr_accessor :room_status, :start_date, :end_date, :cost, :res_id

    def initialize( start_date_time, end_date_time, res_id, cost = 200)
      @start_date = DateTime.strptime(start_date_time + " 15:00", "%m/%d/%y %H:%M")
      @end_date = DateTime.strptime(end_date_time + " 11:00", "%m/%d/%y %H:%M")
      @res_id = res_id
      @cost = cost
    end

    def self.create_reservation
    end


    def check_room_status
      #@all_rooms.each do |status|
      # if :room_status == :Available
      #   puts 'Room is Available.'
      # elsif :room_status == :Unavailable
      #   puts 'Room is Unavailable.'
      # end
      #  end
    end
    def calculate_cost
       num_nights = (end_date - start_date).to_i
      @room_cost = (num_nights + 1) * 200.to_f
    end

  end
end


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
