require_relative 'spec_helper'

# describe "Calendar" do
#   let(:id) {
#
#   }
#
# end

# Each room should have its own calendar
# I can click on a room and see when it is available,unavailable

# The hotel should have its own calendar
# I can click on a date and see all available rooms

# describe "#available_rooms" do
#     let (:check_in) {
#       "2018-10-07"
#     }
#     let (:check_out) {
#       "2018-10-16"
#     }
#     let (:my_hotel) {
#       Hotel::HotelManager.new
#     }
#
#   it "returns an array of Rooms" do
#     expect(my_hotel.available_rooms(check_in, check_out)).must_be_kind_of Array
#   end
#
#   it "Returns an array full of Rooms" do
#     my_hotel.rooms.each do |room|
#       expect(room).must_be_kind_of Hotel::Room
#     end
#   end
#
#   it "Returns the correct number of rooms" do
#     all_rooms = my_hotel.rooms
#     all_rooms.first.calendar[Date.parse("2018-10-10")] = :UNAVAILABLE
#     expect(my_hotel.available_rooms(check_in, check_out)).must_equal 19
#   end


  # it "returns nil if there are no rooms available" do
  #   rooms.each do |room|
  #     room.calendar << Date.parse("2018-02-12")
  #   end
  #
  #   expect(open_rooms).must_be_nil
  # end

  # all_rooms = my_hotel.rooms
  # all_rooms.each do |room|
  #   room
  #
  # available_rooms = my_hotel.available_rooms(check_in, check_out)
