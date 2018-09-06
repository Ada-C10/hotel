require_relative 'spec_helper'

describe "Reservation Class" do
  describe "initializer" do
    before do
      @reserv_data = {id: 1011,
          room: Room.new(),
          date_range: DateRange.new("2018-03-09", "2018-05-09"),
          total_cost: 600.0
      }
      @reservation = Reservation.new(@reserv_data)
      end

    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end
    
    it "is set up for specified data types" do
      expect(@reservation.id).must_be_kind_of Integer
      expect(@reservation.room).must_be_kind_of Room
      expect(@reservation.date_range).must_be_kind_of DateRange
      expect(@reservation.total_cost).must_be_kind_of Float
    end
    # move this to the dateRange class test
    # it "raises an error if start date is after end date" do
    #
    #   test_end_date = Date.parse('2018-03-09')
    #   test_start_date = test_end_date + 5
    #
    #   expect {
    #     @reserv_data[:start_date] = test_start_date
    #     @reserv_data[:end_date] = test_end_date
    #     Reservation.new(@reserv_data)
    #   }.must_raise ArgumentError
    # end

    it "accurately calculates the total cost of the stay" do
      start_date = "2018-09-10"
      end_date = "2018-09-12"
      reserve_range = DateRange.new(start_date, end_date)


      @reserv_data[:date_range] = reserve_range
      reserve = Reservation.new(@reserv_data)

      cost = reserve.cost_calculator

      expect(cost).must_equal 400
    end

  end
end
