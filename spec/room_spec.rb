require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/Room'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "Room" do
  describe "#initialize" do
    it "can create a new instance of room" do
      room_hash = {
        num: 4
      }

      hotel = Hotel::Room.new(room_hash)

      expect(hotel).must_be_kind_of Hotel::Room
      expect(hotel.num).must_equal room_hash[:num]
    end
  end
end
