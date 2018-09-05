require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/Room'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "Room" do
  let(:room_hash) {{num: 4}}
  let(:room) {Hotel::Room.new(room_hash)}


  describe "#initialize" do
    it "can create a new instance of room" do

      expect(room).must_be_kind_of Hotel::Room
      expect(room.num).must_equal room_hash[:num]
    end

    it "has room id as an integer" do
      expect(room.num).must_be_kind_of Integer
    end

    it "throws an argument error with a bad room num value" do
      expect {
        Hotel::Room.new(num: 21)
      }.must_raise ArgumentError

      expect {
        Hotel::Room.new(num: 0)
      }.must_raise ArgumentError
    end

    it "sets reservations to an empty array if not provided" do
      expect(room.reservations).must_be_kind_of Array
      expect(room.reservations.length).must_equal 0
    end
  end

  describe "add_reservation" do
    let(:start_date) {Date.parse("2004, 7, 1")}
    let(:end_date) {Date.parse("2004, 7, 4")}
    let(:reservation_hash_1) {{
      id: 2,
      room_num: 4,
      start_date: start_date,
      end_date: end_date,
      }}
    let(:reservation_1) {Hotel::Reservation.new(reservation_hash)}

    it "each item in array is a Reservation instance" do
      room.add_reservation(reservation_1)
      expect(room.reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end
end
#
#   it "all Reservation instances must have the same passenger's user id" do
#   @user.trips.each do |trip|
#     expect(trip.passenger.id).must_equal 9
#   end
# end
#     it "can add a reservation to a list of reservations" do
#     end
#
#     it "can add a reservation to a blank list" do
#     end
#   end
end
