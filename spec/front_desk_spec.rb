require_relative 'spec_helper'
require 'date'

describe "FrontDesk class" do

  describe "create all rooms" do
    before do
      @front_desk = FrontDesk.new
      @rooms = @front_desk.load_rooms
    end
    it "creates an array of 20 rooms " do
      expect(@rooms.length).must_equal 20
    end
    it "the ID of the first room is 1" do
      expect(@rooms.first.room_number).must_equal 1
    end
    it "the ID of the last room is 20" do
      expect(@rooms.last.room_number).must_equal 20
    end
  end


  describe "list of all rooms method" do
    before do
      @front_desk = FrontDesk.new
    end
    it "Returns a list of all rooms in hotel" do
      expect(@front_desk.list_all_rooms.length).must_equal 20
      (@front_desk.list_all_rooms).each do |room|
        expect(room).must_be_kind_of Room
      end
    end
  end


  describe "create reservation" do
    before do
      @my_front_desk = FrontDesk.new
      @my_front_desk.create_reservation(9,"2013-10-10","2013-10-13",200)
    end
    it "returns an instance of reservation and adds to reservation list" do
      expect(@my_front_desk.reservations[0]).must_be_instance_of Reservation
      expect(@my_front_desk.reservations.length).must_equal 1
    end
    it "raises an error if a room is not availbe to book" do
      expect{@my_front_desk.create_reservation(9,"2013-10-11","2013-10-12",200)}.must_raise StandardError
      expect{@my_front_desk.create_reservation(9, "2013-10-8", "2013-10-11",200)}.must_raise StandardError
    end
    it "will allow a reservation on the the last day of the previous reservation" do
      @my_front_desk.create_reservation(9,"2013-10-13","2013-10-15",200)
      expect(@my_front_desk.reservations.length).must_equal 2
    end
    it "raises an error if hotel is totaly booked on a given day" do
      expect{i = 1
        20.times do @my_front_desk.create_reservation(i,"2013-10-10","2013-10-13",200)
          i += 1
        end}.must_raise StandardError
      end
    end

    describe 'find reservations by date' do
      before do
        @front_desk = FrontDesk.new
        @front_desk.create_reservation(3, "2012-4-12", "2012-4-22",200)
        @front_desk.create_reservation(4, "2012-4-12", "2012-4-22",200)
        @front_desk.create_reservation(5, "2012-4-23", "2012-4-29",200)
        @front_desk.create_reservation(6, "2012-4-25", "2012-4-28",200)
      end
      it "returns reservations for a specific date date" do
        expect(@front_desk.find_by_date("2012-4-12").length).must_equal 2
      end
    end

    describe "Find a list of all available rooms" do
      before do
        @front_desk = FrontDesk.new
        @front_desk.create_reservation(3, "2012-4-12", "2012-4-14",200)
        @front_desk.create_reservation(4, "2012-4-12", "2012-4-14",200)
        @front_desk.create_reservation(5, "2012-4-12", "2012-4-16",200)
        @front_desk.create_reservation(6, "2012-4-12", "2012-4-16",200)
      end
      it "correctly lists all available_rooms" do
        expect(@front_desk.find_available_rooms(Date.new(2012, 4, 12), Date.new(2012, 4, 14)).length).must_equal (20-4)
      end
    end

    describe "correctly creates a block" do

      it "creates an instance of block" do
        @my_front_desk = FrontDesk.new
        @block = @my_front_desk.create_block("2012-4-16", "2012-4-20", 150, [3,4,5])
        expect(@block).must_be_instance_of Block
      end

      it "raises an error if unavailable rooms are requested in block" do
        @my_front_desk = FrontDesk.new
        @my_front_desk.create_reservation(3, "2012-4-16", "2012-4-20",200)
        expect{@my_front_desk.create_block("2012-4-16", "2012-4-20", 150, [3,4,5])}.must_raise StandardError
      end

      it "makes a blocked room unavailable after block is created, but before actual block reservaion" do
        @my_front_desk = FrontDesk.new
        @block = @my_front_desk.create_block("2012-4-16", "2012-4-20", 150, [3,4,5])
        expect{@front_desk.create_reservation(3, "2012-4-16", "2012-4-18",200)}.must_raise StandardError
      end
    end

    describe "find block info by block ID" do

      it "an instance of block can be found by block by ID method" do

        @my_front_desk = FrontDesk.new
        @block = @my_front_desk.create_block("2012-4-16", "2012-4-20", 150, [3,4,5])
        id = @block.block_ID
        expect(@my_front_desk.find_block_by_id(id)).must_be_instance_of Block
      end
    end

  end
