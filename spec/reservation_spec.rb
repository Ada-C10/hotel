require_relative 'spec_helper'
require_relative '../lib/reservation'


describe 'Reservation class' do

  describe "#initialize" do
    before do
      @reservation = Reservation.new(
        {room_num: 1,
         checkin_time: Date.new(2018,8,1),
         checkout_time: Date.new(2018,9,1),
         price: 200.0,
         })

    end

    it 'is an instance of Reservation' do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "is set up for specific attributes and data types" do
      [:room_num, :checkin_time, :checkout_time, :price].each do |attribute|
        expect(@reservation).must_respond_to attribute
      end

      expect(@reservation.room_num).must_be_kind_of Integer
      expect(@reservation.checkin_time).must_be_kind_of Date
      expect(@reservation.checkout_time).must_be_kind_of Date
      expect(@reservation.price).must_be_kind_of Float
    end
    # 
    # it "checkin_time must be before checkout_time" do
    # end


  end


end
