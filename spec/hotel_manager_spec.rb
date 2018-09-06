require_relative 'spec_helper'

describe "HotelManager" do
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:check_in) {
    "2018-10-07"
  }
  let (:check_out) {
    "2018-10-16"
  }
  let (:id) {
    8
  }

  describe "#initialize" do
    it "Creates an instance of Hotel Manager" do
      expect(my_hotel).must_be_kind_of Hotel::HotelManager
    end

    it "establishes the base data structures when instantiated" do
      [:rooms, :reservations].each do |prop|
        expect(my_hotel).must_respond_to prop
      end

      expect(my_hotel.rooms).must_be_kind_of Array
      expect(my_hotel.reservations).must_be_kind_of Array
    end

    it "Keeps track of rooms" do
      my_hotel.rooms.each_with_index do |room, i|
        expect(room.id).must_equal (i + 1)
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "Keeps track of reservations" do
      my_hotel.reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end
  end

  describe "#reserve" do
    it "Updates all reservations by creating a Reservation" do
      my_hotel.reserve(id, check_in, check_out)

      expect(my_hotel.reservations.last.check_in).must_equal Date.parse(check_in)
      expect(my_hotel.reservations.last.check_out).must_equal Date.parse(check_out)
    end

    it "Updates Room status to Unavailable for selected dates" do
      my_room = my_hotel.rooms.find {|r| r.id == id}
      my_hotel.reserve(id, check_in, check_out)

      (Date.parse(check_in)...Date.parse(check_out)).each do |date|
        expect(my_room.status_by_date[date]).must_equal :UNAVAILABLE
      end
    end

    it "Creates and stores a reservation when there are no reservations yet" do
      my_reservations = my_hotel.reservations.clear

      my_hotel.reserve(id, check_in, check_out)

      expect(my_reservations.length).must_equal 1
      expect(my_reservations.first.room_number).must_equal id
      expect(my_reservations.first.check_in).must_equal Date.parse(check_in)
      expect(my_reservations.first.check_out).must_equal Date.parse(check_out)
    end

    it "Raises an error if room is not available" do
      room_number = 1337
      room = Hotel::Room.new(room_number)
      my_hotel.rooms << room
      Hotel::Room.change_status_of_room(my_hotel.rooms, room_number, check_in, check_out)

      expect {
        my_hotel.reserve(room_number, check_in, check_out)
      }.must_raise StandardError
    end
  end

  describe "#find_reservations" do
    before do
      @date = "2018-12-05"
    end

    it "Returns an array" do
      reservations = my_hotel.find_reservations(@date)

      expect(reservations).must_be_kind_of Array
    end

    it "Returns an accurate count of Reservations" do
      reservations = my_hotel.find_reservations(@date)

      expect(reservations.length).must_equal 2
    end
  end

  describe "#load_rooms and #load_reservations" do
    it "accurately loads room information into rooms array" do
      first_room = my_hotel.rooms.first
      last_room = my_hotel.rooms.last

      expect(first_room.id).must_equal 1
      expect(last_room.id).must_equal 20
      expect(first_room.status_by_date).must_be_kind_of Hash
    end

    it "accurately loads reservation information into reservation array" do
      first_rv = my_hotel.reservations.first
      last_rv = my_hotel.reservations.last

      expect(first_rv.room_number).must_equal 1
      expect(last_rv.room_number).must_equal 18
    end

    it "accurately updates Rooms when Reservations are added" do
      my_reservation = my_hotel.reservations.first
      my_room = my_hotel.rooms.find {|r| r.id == my_reservation.room_number}

      (my_reservation.check_in...my_reservation.check_out).each do |date|
        expect(my_room.status_by_date[date]).must_equal :UNAVAILABLE
      end
    end
  end
end
