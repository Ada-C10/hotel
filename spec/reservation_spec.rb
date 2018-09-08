require_relative 'spec_helper'
require_relative '../lib/reservation'


describe 'Reservation class' do

  describe "#initialize" do
    before do
      attributes = {room_num: 1 ,start_time: Date.new(2018,8,1),end_time: Date.new(2018,9,1),price: 200.0}
      @reservation = Reservation.new(attributes)
    end

    it 'is an instance of Reservation' do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "is set up for specific attributes and data types" do
      [:room_num, :start_time, :end_time, :price].each do |attribute|
        expect(@reservation).must_respond_to attribute
      end

      expect(@reservation.room_num).must_be_kind_of Integer
      expect(@reservation.start_time).must_be_kind_of Date
      expect(@reservation.end_time).must_be_kind_of Date
      expect(@reservation.price).must_be_kind_of Float
    end
  end

  describe "#total_cost" do
    before do
      attributes = {room_num: 1 ,start_time: Date.new(2018,8,1),end_time: Date.new(2018,8,2),price: 200.23111111}
      @reservation = Reservation.new(attributes)
    end

    it "returns an instance of Float" do
      expect(@reservation.total_cost).must_be_kind_of Float
    end

    it "rounds the return value to 2 decimals" do
      expect(@reservation.total_cost).must_equal 200.23
    end
  end

  # def total_cost
  #   total_cost = 0
  #   return total_cost = ((end_time - start_time) * price).round(2)
  # end
  #
  #
  # it "checkin_time must be before checkout_time" do
  # end





end
