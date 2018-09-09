 require_relative 'spec_helper'
 require 'pry'

describe "Room" do
  before do
    @room = Room.new(1,[] )
    @room_with_reservation = Room.new(1, [Reservation.new(1, Date.new(2018,9,1), Date.new(2018,9,3))])
  end
  describe "Initialize" do
    it "Can create an instance of Room" do
      expect(@room).kind_of? Room
    end

    it "Has an room_number" do
      expect(@room).must_respond_to :room_number
      expect(@room.room_number).must_equal 1
    end

    it "Has reservations" do
      expect(@room).must_respond_to :reservations
      expect(@room.reservations).must_equal []
    end

    it "Can find a reservation" do
      expect(@room_with_reservation.find_reservation(1, Date.new(2018, 9, 1), Date.new(2018, 9, 3))).must_equal Reservation.new(1, Date.new(2018,9,1), Date.new(2018,9,3))
      expect(@room_with_reservation).respond_to? :find_reservation
    end

    it "Returns false if it can't find a reservation" do
      not_reserved_start_date = Date.new(2020,1,1)
      not_reserved_end_date = Date.new(2020,1,2)
      expect(@room.find_reservation(1, not_reserved_start_date, not_reserved_end_date)).must_equal FALSE
    end

    it "ArgumentError if id is not between 1 and 20" do
      expect{Room.new(9999, [])}.must_raise ArgumentError
    end

    it "Has an array of reservations" do
      expect(@room.reservations).kind_of? Array
    end

    it "Returns true if room is available" do
      expect(@room.is_available?(Date.new(2018, 9, 4))).must_equal TRUE
    end

    it "Returns false if room is not available" do
      @room3 = Room.new(1,[
        Reservation.new(1, Date.new(2018, 9, 01), Date.new(2018, 9, 02))
        ])
      expect(@room3.is_available?(Date.new(2018, 9, 1))).must_equal FALSE
    end
  end

  describe "BlockRoom" do
    it "Is able to be added to a BlockRoom if available for date range given" do
      #
    end

    it "Raises an error if attempting to be reserved for a BlockRoom when not available for the given date range" do

    end 

  it "Raises an error if reserved for a BlockRoom and someone is attempting a regular reservation" do

  end

  it "Is able to be reserved for block date range" do

  end

end
