# require_relative 'spec_helper'
#
# describe "Room" do
#   let(:room) {Hotel::Room.new({num: 4})}
#
#   describe "#initialize" do
#     it "can create a new instance of room" do
#       expect(room).must_be_kind_of Hotel::Room
#       expect(room.num).must_equal 4
#     end
#
#     it "has room id as an integer" do
#       expect(room.num).must_be_kind_of Integer
#     end
#
#     it "throws an argument error with a bad room num value" do
#       expect {
#         Hotel::Room.new(num: 21)
#       }.must_raise ArgumentError
#
#       expect {
#         Hotel::Room.new(num: 0)
#       }.must_raise ArgumentError
#     end
#
#     it "sets reservations to an empty array if not provided" do
#       expect(room.reservations).must_be_kind_of Array
#       expect(room.reservations.length).must_equal 0
#     end
#   end
#
#   describe "add_reservation" do
#     let(:reservation_1) {Hotel::Reservation.new({
#       room: 4,
#       check_in: "2004-4-1",
#       check_out: "2004-4-4",
#       })}
#     let(:reservation_2) {Hotel::Reservation.new({
#       room: 4,
#       check_in: "2004-6-1",
#       check_out: "2004-7-4",
#       })}
#     let(:reservation_3) {Hotel::Reservation.new({
#       room: 4,
#       check_in: "2004-7-25",
#       check_out: "2004-7-30",
#       })}
#
#     it "can add a Reservation to a blank list" do
#       room.add_reservation(reservation_1)
#
#       expect(room.reservations[0]).must_be_kind_of Hotel::Reservation
#     end
#
#     it "each item in array is a Reservation instance" do
#       room.add_reservation(reservation_1)
#       room.add_reservation(reservation_2)
#       room.add_reservation(reservation_3)
#
#       room.reservations.each do |reservation|
#         expect(reservation).must_be_kind_of Hotel::Reservation
#       end
#     end
#
# # TODO: room num or room obj?
#     it "each Reservation instance has same room number" do
#       room.add_reservation(reservation_1)
#       room.add_reservation(reservation_2)
#       room.add_reservation(reservation_3)
#
#       room.reservations.each do |reservation|
#         expect(reservation.room).must_equal 4
#       end
#     end
#   end
# end
