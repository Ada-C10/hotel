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
      num = 5
      hotel = Hotel::Room.new(num)

      expect(hotel).must_be_kind_of Hotel::Room
      expect(hotel.num).must_equal num
    end
  end
end
