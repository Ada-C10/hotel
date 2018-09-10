require_relative 'booking_system'

module Hotel
  class BlockRoom

    attr_reader :date_range, :block_rooms, :rate

    def initialize(date_range, block_rooms, rate)
      @date_range = date_range
      @block_rooms = block_rooms
      @rate = rate
    end


  end
end


# date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
# # date_range_2 = Hotel::DateRange.new('2018-09-15', '2018-09-20')
# # date_range_3 = Hotel::DateRange.new('2018-08-29', '2018-09-02')
# # date_range_4 = Hotel::DateRange.new('2018-10-01', '2018-10-20')
# reservation_1 = Hotel::BookingSystem.new()
#
# reservation = Hotel::BlockRoom.new()
# # reservation_1 = Hotel::BookingSystem.new()
#
# 5.times do
#   reservation_1.make_reservation(date_range_1)
# end
#
# puts "This is the 5 first reservations"
# p reservation_1.reservations[0].room_number
# p reservation_1.reservations[1].room_number
# p reservation_1.reservations[2].room_number
# p reservation_1.reservations[3].room_number
# p reservation_1.reservations[4].room_number
# puts
#
#
# 5.times do
#   reservation.make_reservation(date_range_1)
# end
#
# puts "This should include all previous reservations"
# # reservation.each_with_index do |room, index|
# # p room.reservations[i]
# # end
#
# p reservation.reservations[1].room_number
# p reservation.reservations[2].room_number
# p reservation.reservations[3].room_number
# p reservation.reservations[4].room_number
# p reservation.reservations[5].room_number
# # p reservation.reservations[6].room_number
# # p reservation.reservations[7].room_number
# # p reservation.reservations[8].room_number
# # p reservation.reservations[9].room_number
# # 2.times do
# #   reservation.make_reservation(date_range_2)
# # end
# #
# # 3.times do
# #   reservation.make_reservation(date_range_3)
# # end
# #
#
# reservation.find_available_rooms(date_range_1)
#
# puts "block rooms"
# p reservation.block_rooms
# p reservation.reservations[1].block_room_cost
# # puts reservation.find_available_rooms(date_range_1).class
# # puts "#{reservation.list_available_rooms(date_range_1)}"
# # puts "#{reservation_1.list_available_rooms(date_range_1)}"
# # puts "#{reservation.list_available_rooms(date_range_4)}"
