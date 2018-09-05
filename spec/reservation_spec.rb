require_relative 'spec_helper'

describe "Reservation class" do
  before do
    @start_date = Date.today
    @end_date = Date.today + 5

    @reservation_data = {
      id: 8,
      room: Hotel::Room.new(
        room_number: 1
      ),
      start_date: Date.today,
      end_date: Date.today + 5
    }

    @reservation = Hotel::Reservation.new(@reservation_data)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "stores an instance of room" do
      expect(@reservation.room).must_be_kind_of Hotel::Room
    end
  end
end
