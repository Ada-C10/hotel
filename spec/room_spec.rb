require_relative 'spec_helper'


describe "Room in Wave 1" do
  describe "#initialize" do
    it "Takes a room number" do
      id = 1
      room_1 = Room.new(id)

      expect(room_1).must_respond_to :id
      expect(room_1.id).must_equal id
      expect(room_1.rate).must_equal 200
      expect(room_1.reservations).must_equal []

    end

    it "Raises an ArgumentError for invalid room numbers" do
      expect {
          Room.new('a')
        }.must_raise ArgumentError
      expect {
          Room.new(21)
        }.must_raise ArgumentError
    end
  end
end
