require_relative 'spec_helper'

describe "Room Class" do
  before do
    room_num = 1
    @room = Hotel::Room.new(room_num)
  end
  describe "Initializer" do
    it "is an instance of Room" do
      expect(@room).must_be_kind_of Hotel::Room
      expect(@room.room_reservations).must_be :empty?
    end

    it "must keep track of room number" do
      expect(@room).must_respond_to :room_num
      expect(@room.room_num).must_be_kind_of Integer
    end

    it "must keep track of reservations" do
      expect(@room).must_respond_to :room_reservations
      expect(@room.room_reservations).must_be_kind_of Array
      expect(@room.room_reservations).must_be :empty?


      @room.room_reservations.each do |room_reservation|
        expect(room_reservation).must_be_kind_of Hotel::Reservation
      end
    end
  end

  describe "Add reservations to rooms" do
    it "checks that reservations are added to list" do
      info = {
        id: rand(1..300),
        room: @room,
        start_date: "2018-09-07",
        end_date: "2018-09-14"
      }
      reservation = Hotel::Reservation.new(info)
      @room.add_booking(reservation)
      expect(@room.room_reservations.first).must_be_kind_of Hotel::Reservation
      expect(@room.room_reservations.length).must_equal 1
    end


    it "throws an argument error if added bookings are not reservation" do
      info = {
        id: rand(1..300),
        room: @room,
        start_date: "2018-09-07",
        end_date: "2018-09-14"
      }
      expect { @room.add_booking(info) }.must_raise ArgumentError
    end
  end
end
