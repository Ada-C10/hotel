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




#reserve_room creates an instance of reservation
#reservation is an array
#at index 0 cost

  end
end
