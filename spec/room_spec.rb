require_relative 'spec_helper'


describe "Room in Wave 1" do
  describe "#initialize" do
    it "Takes a room number" do
      id = 1
      room_1 = Room.new(id)

      expect(room_1).must_respond_to :room_num
      expect(room_1.room_num).must_equal id
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

  # describe "#add_reservation" do
  #   before do
  #     @room_1 = Room.new(3)
  #     @reservation_1 = Reservation.new(123, "Mike Smith", Date.new(2018,10,4), Date.new(2018,10,7))
  #   end
  #
  #   it "throws an argument error if reservation is not provided" do
  #
  #     expect{ @room_1.add_reservation('') }.must_raise ArgumentError
  #   end
  #
  #   it "will throw ArgumentError if attemps to add reservation objects to the reservation array more than once" do
  #
  #     @room_1.add_reservation(@reservation_1)
  #     expect{ @room_1.add_reservation(@reservation_1) }.must_raise ArgumentError
  #   end
  #
  #
  #   it "increases the reservation count by one" do
  #     previous = @room_1.reservations.length
  #     @room_1.add_reservation(@reservation_1)
  #     expect(@room_1.reservations.length).must_equal previous + 1
  #   end
  # end
end
