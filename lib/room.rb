# module Hotel
#   class Room
#     attr_reader :status, :room_id
#
#     def initialize(room_id, status = :AVAILABLE)
#       @room_id = room_id
#       @status = status
#
#       validate_room_id
#       validate_status
#
#     end
#
#
#     def validate_status
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
