require_relative 'spec_helper'

describe "Reservation in Wave 1" do
  before do
    @id = 2
    @customer_name = "Mike Bogdon"
    @start_date = Date.new(2018,10,2)

  end
  describe "#initialize" do
    it "Takes a reservation id, start_date, end_date " do
      end_date = Date.new(2018,10,5)
      rsv_1 = Reservation.new(@id, @customer_name, @start_date, end_date)
      expect(rsv_1).must_respond_to :id
      expect(rsv_1).must_respond_to :start_date
      expect(rsv_1).must_respond_to :end_date
      expect(rsv_1).must_respond_to :customer_name
      expect(rsv_1.id).must_equal @id
      expect(rsv_1.start_date).must_equal @start_date
      expect(rsv_1.end_date).must_equal end_date
      expect(rsv_1.customer_name).must_equal @customer_name
    end

    it "Raises an ArgumentError for invalid date input, end_date is not later than start_date" do
      end_date = Date.new(2018,10,2)
      expect {
          Reservation.new(@id, @customer_name, @start_date, end_date)
        }.must_raise ArgumentError
    end

    it "Raises an ArgumentError for invalid date input, start_date is a day earlier than today" do
      start_date_2= Date.new(2018,8,2)
      end_date_2 = Date.new(2018,10,2)
      expect {
          Reservation.new(@id, @customer_name, start_date_2, end_date_2)
        }.must_raise ArgumentError
    end
  end
end
