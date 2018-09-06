require_relative 'spec_helper'

require 'date'

describe 'Reservation class' do

  describe "Reservation instantiation" do
    before do
      @honeymoon_suite = Hotel::Room.new({room_number: 1, price: 200})
      @res_1 = Hotel::Reservation.new({room: @honeymoon_suite, check_in: "01/10/1988", check_out: "01/17/1988", cost: 1000})
    end

    it "it is an instance of Reservation" do
      expect(@res_1).must_be_kind_of Hotel::Reservation
    end

    it "is set up for specific attributes and data types" do
      [:room, :check_in, :check_out, :cost].each do |prop|
        expect(@res_1).must_respond_to prop
      end

      expect(@res_1.room).must_be_kind_of Hotel::Room
      expect(@res_1.check_in).must_be_kind_of Date
      expect(@res_1.check_out).must_be_kind_of Date
      expect(@res_1.cost).must_be_kind_of Integer
    end
  end

  describe 'room_reserved' do
    before do
      @honeymoon_suite = Hotel::Room.new({room_number: 1, price: 200})
      @res_2 = Hotel::Reservation.new({room: @honeymoon_suite, check_in: "01/10/1988", check_out: "01/17/1988", cost: 1000})
    end

    it "returns the room instance associated with this reservation" do
      expect(@res_2.room_reserved).must_equal @honeymoon_suite
      expect(@res_2).must_be_kind_of Hotel::Reservation
    end
  end

  describe 'calculate_cost' do
    before do
      @honeymoon_suite = Hotel::Room.new({room_number: 1, price: 200})
      @res_3 = Hotel::Reservation.new({room: @honeymoon_suite, check_in: "01/10/1988", check_out: "01/17/1988", cost: nil})
    end

    it "returns cost of room based on days reserved" do
      expect(@res_3.check_in).must_be_kind_of Date
      expect(@res_3.check_out).must_be_kind_of Date
      expect(@res_3.calculate_cost).must_equal 1400
    end
  end

end
