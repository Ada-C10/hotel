require_relative 'spec_helper'
require_relative '../lib/room'

describe 'Room class' do

  describe "#initialize" do
    before do
      @room = Room.new(
        {room_num: 1, price: 200.0, availability: :RESERVED })
      end

      it 'is an instance of Room' do
        expect(@room).must_be_kind_of Room
      end

      it "is set up for specific attributes and data types" do
        [:room_num, :price, :availability].each do |attribute|
          expect(@room).must_respond_to attribute
        end

        expect(@room.room_num).must_be_kind_of Integer
        expect(@room.price).must_be_kind_of Float
        expect(@room.availability).must_be_kind_of Symbol
      end
    end


end #the Room class block
