require_relative 'spec_helper'

describe "Reservation class tests" do
  before do
    room_num = 1
    room = Hotel::Room.new(room_num)
    @reserv_data = {
      id: 1011,
      room: room,
      start_date: "2018-03-09",
      end_date: "2018-03-15",
    }
    @reservation = Hotel::Reservation.new(@reserv_data)
  end
  describe "initializer" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "is set up for specified data types" do
      expect(@reservation.id).must_be_kind_of Integer
      expect(@reservation.room).must_be_kind_of Hotel::Room
      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
    end
  end

  describe "accurately caluclates total cost for a reservation" do
    it "accurately calculates the total cost of the stay" do
      @reserv_data[:start_date] = "2018-09-10"
      @reserv_data[:end_date] = "2018-09-12"

      reserve = Hotel::Reservation.new(@reserv_data)

      cost = reserve.total_cost

      expect(cost).must_equal 400.00
      # expect(cost).must_be_kind_of Float
    end
  end
end
