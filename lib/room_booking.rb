# require 'date'
# require 'pry'
#
# require_relative 'reservation'
#
# module Hotel
#   class RoomBooking
#
#     ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
#
#     def initialize(start_date, end_date)
#
#       @start_date = start_date
#       @end_date = end_date
#       @room_id = find_room_id(@start_date, @end_date)
#       @booked_dates = {}
#
#     end
#
#
#     def create_date_array(start_date, end_date)
#       number_of_nights = (end_date - start_date).to_i
#       date_array = []
#       number_of_nights.times do
#         date_array << start_date
#         start_date +=1
#       end
#       return date_array
#     end
#
#
#     def find_room_id(start_date, end_date)
#
#       reservation_dates = create_date_array(start_date, end_date)
#
#       ROOMS.each do |room|
#
#         if @booked_dates.key?(room) == false
#           add_booked_dates(room, reservation_dates)
#           return room
#         end
#
#         reservation_dates.each do |date|
#           if booked_dates.include?(date)
#             break
#           else
#             add_booked_dates(room, reservation_dates)
#             return room
#           end
#         end
#       end
#       return "I'm sorry but there are no rooms available for your dates."
#     end
#
#
#       def add_booked_dates(room_id, reservation_dates)
#         @booked_dates[:room_id] = reservation_dates
#         return room_id
#       end
#
#
#
#
#
#
#
#
#
#       #this method checks to see if there is a key/value pair for a given room number (so no booked dates)
#       # def never_been_booked?(room, reservation_dates)
#       #   if @booked_dates.has_key?(room) == false
#       #     return true
#       #   end
#       # end
#
#       #this method is assuming a room already has some dates assigned to it
#       # def check_each_date(reservation_dates, booked)
#       #   reservation_dates.each do |date|
#       #     if booked_dates.include?(date)
#       #       break
#       #     end
#       # end
#
#
#     end
#   end
