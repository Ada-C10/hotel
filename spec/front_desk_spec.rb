require_relative 'spec_helper'

describe "Front Desk Class" do
  describe "Initializer" do


    it "loads 20 rooms" do
      admin = Front_Desk.new
      rooms = admin.load_rooms
      expect(rooms).must_be_kind_of Array
      expect(rooms.length).must_equal 20
    end

    it "returns an array that has instances of room" do
      admin = Front_Desk.new
      rooms = admin.load_rooms
      rooms.each do |room|
        expect(room).must_be_kind_of Room
      end
    end


    before do
      @admin = Front_Desk.new
      @new_reservation = @admin.reserve_room(5,('2018-02-03'),('2018-02-06'))

    end

    it "has a room number assisnged to the reservation" do
      expect(@new_reservation.room_number).must_equal 5
    end

    it "totals the cost based on each night stay" do
      expect(@new_reservation.total_cost).must_equal 600
    end

    it "return a instance of reservation" do
      expect(@new_reservation).must_be_kind_of Reservation
    end

    it "adds a new reservation to the reservations array" do
      expect(@admin.reservations).must_include(@new_reservation)
    end

    it "returns all reservation within that date" do
      @admin.block_hold(('2018-02-03'),('2018-02-06'),2, "Nelson")
      @admin.reserve_room(5,('2018-02-01'),('2018-02-03'))
      expect(@admin.search_reserved_by_date('2018-02-05').length).must_equal 3
    end

    it "returns zero for day of" do
      @admin.block_hold(('2018-02-03'),('2018-02-06'),2, "Martinez")
      expect(@admin.search_reserved_by_date('2018-02-06').length).must_equal 0
    end

    it "room is not-available" do
      @admin.reserve_room(6,('2018-02-05'),('2018-02-10'))
      expect {@admin.reserve_room(6,('2018-02-05'),('2018-02-10'))}.must_raise StandardError
    end

    it "allows a reservation to start on the same day another reservation ends" do
      expect(@admin.reserve_room(5,('2018-02-06'),('2018-02-10'))).must_be_kind_of Reservation
    end

    it "allows a reservation to end on the same day another reservation starts" do
      expect(@admin.reserve_room(5,('2018-02-01'),('2018-02-03'))).must_be_kind_of Reservation
    end

    # it "raises an error if start date after the end date" do
    #   room = @admin.reserve_room(6,('2018-02-05'),('2018-02-03'))
    #   expect{room}.must_raise StandardError
    # end




######## addd describe block to this methods so it stops using the room to test from top #####

    it "makes a block reservation for 1 to 5 rooms" do
      expect(@admin.block_hold(('2018-02-01'),('2018-02-03'),2, "Smith").length).must_equal 2
    end

    it "raises error if standard reservation conflicts with block reservation" do
    @admin.block_hold(('2018-02-01'),('2018-02-11'),2, "Martinez")
    expect {@admin.reserve_room(1,('2018-02-01'),('2018-02-10'))}.must_raise StandardError
    end

    it "raises error if block reservation exceeds maximum(5) block reservation" do
    expect {@admin.block_hold(('2018-02-01'),('2018-02-11'),6,"Jacobs")}.must_raise StandardError
    end

    it "raises error if block reservations conflict" do
      @admin.block_hold(('2018-02-01'),('2018-02-11'),5, "Smith")
      @admin.block_hold(('2018-02-01'),('2018-02-11'),5, "Nelson")
      @admin.block_hold(('2018-02-01'),('2018-02-11'),5, "Johnson")
      @admin.block_hold(('2018-02-01'),('2018-02-11'),4, "Jacobs")
      expect {@admin.block_hold(('2018-02-01'),('2018-02-10'),2, "Martinez")}.must_raise StandardError
    end

  end
end
#reserve_room creates an instance of reservation
#reservation is an array
#at index 0 cost
