require_relative 'spec_helper'

require 'date'

describe 'Reservation_mngr class' do

  describe "Reservation_mngr instantiation" do
    before do
      @room = Hotel::Room.new( {room_number: 1, price: 200} )

      @res_1 = Hotel::Reservation.new( { reservation_id: 1, room: @room, check_in: "01/10/1988", check_out: "01/17/1988", cost: 1400 } )

      @front_desk = Hotel::Reservation_mngr.new()
    end

    it "is an instance of Reservation_mngr" do
      expect(@front_desk).must_be_kind_of Hotel::Reservation_mngr
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
      @front_desk = Hotel::Reservation_mngr.new()
      @room_list = @front_desk.build_room_list
    end

    it "returns an array length of 20" do
      expect(@room_list.length).must_equal 20
    end
  end

  describe "find_room" do
    before do
      @front_desk = Hotel::Reservation_mngr.new()
      @room_list = @front_desk.build_room_list
      @front_desk.find_room("01/03/2018", "01/10/2018")
      @rez = []
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
      @front_desk = Hotel::Reservation_mngr.new()
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

    it "increases reservation_id by 1" do
      expect(@front_desk.current_res_id).must_equal 1
      @front_desk.create_reservation("01/10/2018", "01/17/2018")
      expect(@front_desk.current_res_id).must_equal 2
    end

    it "returns an error if number of reservations exceeds 20" do
      20.times do
        @front_desk.create_reservation("01/03/2018", "01/10/2018")
      end
      expect{@front_desk.create_reservation("01/03/2018", "01/10/2018")}.must_raise ArgumentError
    end

    it "returns a reservation" do
      expect(@front_desk.create_reservation("01/10/2018", "01/17/2018")).must_be_kind_of Hotel::Reservation
    end
  end

  describe "get_total" do
    before do
      @front_desk = Hotel::Reservation_mngr.new()

      @front_desk.create_reservation("01/10/2018", "01/17/2018")
    end

    it "throws an ArgumentError if reservation id invalid" do

      expect{@front_desk.get_total("A")}.must_raise ArgumentError
    end

    it "returns reservation if id matches" do
      expect(@front_desk.get_total(1)).must_equal 1400
    end

  end

end
