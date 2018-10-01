require_relative 'spec_helper'
require 'pry'

describe "Reservation in Wave 1" do
  before do

    @customer_name = "Mike Bogdon"
    @start_date = Date.new(2018,10,2)
    @room = Room.new(1)
  end
  describe "#initialize" do
    it "Takes a reservation start_date, end_date " do
      end_date = Date.new(2018,10,5)
      rsv_1 = Reservation.new(@customer_name, @room, @start_date, end_date)
      expect(rsv_1).must_respond_to :id
      expect(rsv_1).must_respond_to :start_date
      expect(rsv_1).must_respond_to :end_date
      expect(rsv_1).must_respond_to :customer_name
      expect(rsv_1).must_respond_to :room

      expect(rsv_1.start_date).must_equal @start_date
      expect(rsv_1.end_date).must_equal end_date
      expect(rsv_1.customer_name).must_equal @customer_name
      expect(rsv_1.room).must_equal @room
    end

    it "Raises an ArgumentError for invalid date input, end_date is not later than start_date" do
      end_date = Date.new(2018,10,2)
      expect {
          Reservation.new(@customer_name, @room, @start_date, end_date)
        }.must_raise ArgumentError
    end

    it "Raises an ArgumentError for invalid date input, start_date is a day earlier than today" do
      start_date_2= Date.new(2018,8,2)
      end_date_2 = Date.new(2018,10,2)
      expect {
          Reservation.new(@customer_name,@room, start_date_2, end_date_2)
        }.must_raise ArgumentError
    end
  end

  describe "#dates_booked" do
    before do
      @end_date = Date.new(2018,10,6)
      @rsv_2 = Reservation.new(@customer_name,@room, @start_date, @end_date)
    end
    it "returns an array" do
      expect(@rsv_2.dates_booked).must_be_kind_of Array
    end
    it "returns an array of date" do
      expect(@rsv_2.dates_booked.first).must_be_kind_of Date
      expect(@rsv_2.dates_booked.first).must_equal @start_date
    end

    it "end_date should not be included into the array" do
      expect(@rsv_2.dates_booked.include?@end_date).must_equal false
    end
  end

  describe "#reserve_cost" do
    before do
      @end_date = Date.new(2018,10,6)
      @rsv_3 = Reservation.new(@customer_name,@room, @start_date, @end_date)
    end
    it "returns a number" do
      expect(@rsv_3.reserve_cost).must_be_kind_of Numeric
    end
    it "do the calculation correctly" do
      expect(@rsv_3.reserve_cost).must_equal 800
    end

    it "calculation correctly for a one day stay" do
      id = 5
      customer_name = "Jezz Bogdon"
      start_date = Date.new(2018,10,5)
      end_date = Date.new(2018,10,6)
      room = Room.new(4)
      rsv_4 = Reservation.new(customer_name,room,start_date,end_date)
      expect(rsv_4.reserve_cost).must_equal 200
    end
  end

end
