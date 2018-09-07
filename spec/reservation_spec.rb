require_relative 'spec_helper'

describe "Reservation Class" do
  describe "initializer" do
    before do
      # input_dates = { start_date: "2018-03-09", end_date: "2018-03-15"}
      @reserv_data = {id: 1011,
          room: Hotel::Room.new(),
          start_date: "2018-03-09",
          end_date: "2018-03-15",
          # date_range: Hotel::DateRange.new(input_dates),
          total_cost: 600.0
      }
      @reservation = Hotel::Reservation.new(@reserv_data)
      end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "is set up for specified data types" do
      expect(@reservation.id).must_be_kind_of Integer
      expect(@reservation.room).must_be_kind_of Hotel::Room
      expect(@reservation.date_range).must_be_kind_of Hotel::DateRange
      expect(@reservation.total_cost).must_be_kind_of Float
    end

    it "accurately calculates the total cost of the stay" do
      start_date = "2018-09-10"
      end_date = "2018-09-12"
      reserve_range = Hotel::DateRange.new(start_date, end_date)


      @reserv_data[:date_range] = reserve_range
      reserve = Hotel::Reservation.new(@reserv_data)

      cost = reserve.cost_calculator

      expect(cost).must_equal 400
    end

  end
end
