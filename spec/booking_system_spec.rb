require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/booking_system'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "BookingSystem class" do
  let(:booking) {Hotel::BookingSystem.new()}

  describe "#initialize" do
    it "can create a new instance of BookingSystem" do
      expect(booking).must_be_kind_of Hotel::BookingSystem
    end
  end

  describe "#load_rooms" do
    let(:rooms_list) {booking.load_rooms()}

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

  describe "#list_all_rooms" do
      let(:all_rooms_str) {booking.list_all_rooms()}

    it "lists all rooms as a string" do
      beginning_text = "Here is a list of all rooms:"
      room_2 = "Room 2"

      expect(all_rooms_str).must_be_kind_of String
      expect(all_rooms_str).must_include beginning_text
      expect(all_rooms_str).must_include room_2
    end
  end
end
