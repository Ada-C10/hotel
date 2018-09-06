require_relative 'spec_helper'

require 'date'

describe 'Reservation class' do

  describe "Reservation instantiation" do
    before do
      @room = Hotel::Room.new({room_number: 1, price: 200})
      @res_1 = Hotel::Reservation.new({room: @room, check_in: "01/10/1988", check_out: "01/17/1988", cost: 1000})
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
    it "returns the room instance associated with this reservation" do
    end

  end
    #
    # describe "calculate_cost" do
    #   it "returns total cost of room per night" do
    #
    #     room_data = {
    #       room_number: 2,
    #       price: 200
    #     }
    #
    #     hyatt = Hotel::Room.new(room_data)
    #
    #     expect(hyatt.calculate_cost(5)).must_equal 1000
    #   end
    # end

  # describe "calculate_cost" do
  #   it "returns total cost of room per night" do
  #
  #     room_data = {
  #       room_number: 2,
  #       price: 200
  #     }
  #
  #     hyatt = Hotel::Room.new(room_data)
  #
  #     reservation_data = {
  #       rooms: hyatt,
  #       check_in: (2018, 01, 10),
  #       check_out: (2018, 01, 17),
  #       cost: hyatt.Room.price
  #     }
  #
  #     reservation_2 = Hotel::Reservation()
  # #
  #     expect(hyatt.calculate_cost('1/10/2018', '01/12/2018')).must_equal 400
  #   end



end
