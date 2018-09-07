# module Hotel
#   class Room
#
#     require_relative 'reservation'
#
#     module Hotel
#       class RoomBooking
#
#         ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
#
#         def initialize(start_date, end_date)
#
#           @start_date = start_date
#           @end_date = end_date
#           @booked_dates = []
#
#         end
#

    # def initialize(room_id, status = :AVAILABLE)
    #   @room_id = room_id
    #   @status = status
    #
    #   validate_room_id
    #   validate_status
    #
    # end


    # def validate_status
#       status_options = [:AVAILABLE, :UNAVAILABLE]
#
#       raise ArgumentError.new("You must enter a valid status.") unless status_options.include?(status)
#     end
#
#
#     def validate_room_id
#       room_id_options = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
#
#       raise ArgumentError.new("You must enter a valid room id.") unless room_id_options.include?(room_id)
#     end
#
# 
#   end
# end
