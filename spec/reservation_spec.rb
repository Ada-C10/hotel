require_relative 'spec_helper'
require_relative '../lib/reservation'


describe 'Reservation class' do

  describe "#initialize" do
    before do
      attributes = {rooms:[],start_time: Date.new(2018,8,1),end_time: Date.new(2018,9,1),price: 200.0}
      @reservation = Reservation.new(attributes)

    end

    it 'is an instance of Reservation' do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "is set up for specific attributes and data types" do
      [:rooms, :start_time, :end_time, :price].each do |attribute|
        expect(@reservation).must_respond_to attribute
      end

      expect(@reservation.rooms).must_be_kind_of Array
      expect(@reservation.start_time).must_be_kind_of Date
      expect(@reservation.end_time).must_be_kind_of Date
      expect(@reservation.price).must_be_kind_of Float
    end
    #
    # it "checkin_time must be before checkout_time" do
    # end


  end


end
