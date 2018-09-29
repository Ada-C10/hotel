require_relative 'spec_helper'

require 'date'

describe 'ReservationManager class' do

  describe "ReservationManager instantiation" do
    before do
      @room = Hotel::Room.new( {room_number: 1, price: 200} )

      @res_1 = Hotel::Reservation.new( { room: @room, check_in: "01/10/1988", check_out: "01/17/1988"} )

      @front_desk = Hotel::ReservationManager.new()
    end

    it "is an instance of ReservationManager" do
      expect(@front_desk).must_be_kind_of Hotel::ReservationManager
    end

    it "is set up for specific attributes and data types" do
      [:rooms, :reservations].each do |prop|
        expect(@front_desk).must_respond_to prop
      end

      expect(@front_desk.rooms).must_be_kind_of Array
      expect(@front_desk.reservations).must_be_kind_of Array
    end
  end

  describe "build_room_list" do
    before do
      @front_desk = Hotel::ReservationManager.new()
      @room_list = @front_desk.build_room_list
    end

    it "returns an array length of 20" do
      expect(@room_list.length).must_equal 20
    end
  end

  describe "find_room" do
    before do
      @front_desk = Hotel::ReservationManager.new()
      @room_list = @front_desk.build_room_list
      @front_desk.find_room("01/03/2018", "01/10/2018")
    end

    it "returns a room that's available" do
      res_1 = @front_desk.create_reservation("01/03/2018", "01/10/2018")
      expect(res_1.room.room_number).must_equal 1
    end

    it "returns next available room" do
      @res_1 = @front_desk.create_reservation("01/03/2018", "01/10/2018")
      @res_2 = @front_desk.create_reservation("01/03/2018", "01/07/2018")
      expect(@res_2.room.room_number).must_equal 2
    end

    it "returns length of array when all rooms reserved" do
      20.times do |i|
        @front_desk.create_reservation("01/03/2018", "01/10/2018")
      end
      rez = @front_desk.reservations
      expect(rez.length).must_equal 20
    end

  end

  describe "create_reservation" do
    before do
      @room = Hotel::Room.new( {room_number: 1, price: 200} )
      @front_desk = Hotel::ReservationManager.new()
    end

    it "throws an ArgumentError if check_out is before check_in" do
      expect{@front_desk.create_reservation("01/10/2018", "01/09/2018")}.must_raise ArgumentError
    end

    it "throws an ArgumentError if check_in is after check_out" do
      expect{@front_desk.create_reservation("01/18/1988", "01/17/1988")}.must_raise ArgumentError
    end

    it "throws an ArgumentError if check_in is nil" do
      expect{@front_desk.create_reservation(nil, "01/17/1988")}.must_raise ArgumentError
    end

    it "throws an ArgumentError if check_out is nil" do
      expect{@front_desk.create_reservation("01/18/1988", nil)}.must_raise ArgumentError
    end

    it "throws an ArgumentError if check_in and check_out are both nil" do
      expect{@front_desk.create_reservation(nil, nil)}.must_raise ArgumentError
    end

    it "stores reservation instance to class variable - reservations" do
      @front_desk.create_reservation("01/10/2018", "01/17/2018")
      res = @front_desk.reservations.length
      expect(res).must_equal 1
    end

    it "returns a reservation" do
      expect(@front_desk.create_reservation("01/10/2018", "01/17/2018")).must_be_kind_of Hotel::Reservation
    end
  end

  describe "get_total" do
    before do
      @front_desk = Hotel::ReservationManager.new()
      @front_desk.create_reservation("01/10/1988", "01/17/1988")
    end

    it "calculates total cost of reservation" do
      expect(@front_desk.get_total(1, Date.strptime("01/10/1988", '%m/%d/%Y'), Date.strptime("01/17/1988", '%m/%d/%Y') ) ).must_equal 1400

      @front_desk.create_reservation("01/15/1988", "01/20/1988")

      expect(@front_desk.get_total(2, Date.strptime("01/15/1988", '%m/%d/%Y'), Date.strptime("01/20/1988", '%m/%d/%Y') ) ).must_equal 1000
    end
  end
end
