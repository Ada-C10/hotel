require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do

  describe "Reservation initialization" do

    it "is an instance of Reservation" do
      @reservation = Hotel::Reservation.new(2015, 03, 01, 2015, 03, 05)
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "must throw an argument error if the end date is before the start date" do
      expect {Hotel::Reservation.new(2015, 03, 05, 2015, 03, 01)}.must_raise ArgumentError
    end
  end

  describe "Generate date" do
    it "is a kind of date" do
      date = Date.new(2018,1,3)
      expect(date).must_be_kind_of Date
    end
  end

  describe "reservation cost" do
    it "returns the total amount of the new reservation" do

      @reservation = Hotel::Reservation.new(2015, 03, 01, 2015, 03, 05)

      start_date = @reservation.start_date
      end_date = @reservation.end_date

      expect(@reservation.reservation_cost(start_date, end_date)).must_equal 800



    end


  end

end

# it "Returns the total from the collection of products" do
#   products = { "banana" => 1.99, "cracker" => 3.00 }
#   order = Order.new(1337, products, customer)
#
#   expected_total = 5.36
#
#   expect(order.total).must_equal expected_total
# end

#As an administrator, I can access the list of all of the rooms in the hotel
#As an administrator, I can reserve a room for a given date range
#As an administrator, I can access the list of reservations for a specific date
#def - find reservations (find all?) (date)
#return array of reservations

#As an administrator, I can get the total cost for a given reservation
