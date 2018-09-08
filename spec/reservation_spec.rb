require_relative 'spec_helper'

describe "Reservation Class" do
  describe "Initializer in  Reservation" do
    before do
      @reservation_info = {
        room_number: 1,
        start_date: ('2018-02-03'),
        end_date: ('2018-02-05'),
      }

      @reservation = Reservation.new(@reservation_info)

    end

    it "is an instance of  Reservation Class" do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "has a room number assisnged to the reservation" do
      expect(@reservation.room_number).must_equal 1

    end

    it "totals the cost based on each night stay" do
      expect(@reservation.total_cost).must_equal 400
    end




#given, when, then

  end
end








    # describe "total calculated" do
    #
    # before do
    #   start_date = Date.parse("2018-05-25")
    #   end_date = Date.parse("2018-05-25")
    # end
    #
    # it "will correctly calculate total revenue" do
    #
    #   expect(@driver.total_revenue).must_equal ((101.65-1.65)*2)*0.8
    # end
