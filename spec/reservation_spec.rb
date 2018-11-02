require_relative 'spec_helper'

require 'date'

describe 'Reservation class' do

  describe "Reservation instantiation" do
    before do
      @honeymoon_suite = Hotel::Room.new({room_number: 1, price: 200})
      @res_1 = Hotel::Reservation.new({room: @honeymoon_suite, check_in: "01/10/1988", check_out: "01/17/1988"})
    end

    it "is an instance of Reservation" do
      expect(@res_1).must_be_kind_of Hotel::Reservation
    end

    it "is set up for specific attributes and data types" do
      [:room, :check_in, :check_out].each do |prop|
        expect(@res_1).must_respond_to prop
      end

      expect(@res_1.room).must_be_kind_of Hotel::Room
      expect(@res_1.check_in).must_be_kind_of Date
      expect(@res_1.check_out).must_be_kind_of Date
    end
  end

  describe 'room_reserved' do
    before do
      @honeymoon_suite = Hotel::Room.new({room_number: 1, price: 200})
      @res_2 = Hotel::Reservation.new({room: @honeymoon_suite, check_in: "01/10/1988", check_out: "01/17/1988"})
    end

    it "returns the room instance associated with this reservation" do
      expect(@res_2).must_be_kind_of Hotel::Reservation
      expect(@res_2.room_reserved).must_equal @honeymoon_suite
    end
  end

end
