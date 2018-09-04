require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/booking_system'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "BookingSystem class" do
  let(:booking) {Hotel::BookingSystem.new()}
  let(:rooms_list) {booking.load_rooms()}

  describe "#initialize" do
    it "can create a new instance of BookingSystem" do
      expect(booking).must_be_kind_of Hotel::BookingSystem
    end

    it "can load a list of rooms" do
      expect(rooms_list).must_be_kind_of Array
    end

    it "accurately loads room info in array" do
      first_room = rooms_list[0]
      last_room= rooms_list[-1]

      expect(first_room).must_be_kind_of Hotel::Room
      expect(first_room.num).must_equal 1

      expect(last_room).must_be_kind_of Hotel::Room
      expect(last_room.num).must_equal 20
end
  end
end
