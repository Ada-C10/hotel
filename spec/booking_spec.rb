require_relative 'spec_helper'

describe "BookingSystem Class" do
  before do
    room_num = 1
    room = Hotel::Room.new(room_num)
    info = {id: rand(1..300),
      room: room,
      start_date: "2018-09-07",
      end_date: "2018-09-14"
    }

    reservation = Hotel::Reservation.new(info)
    @booking = Hotel::BookingSystem.new
  end

  describe "Initializer" do
    it "is an instance of BookingSystem" do
      expect(@booking).must_be_kind_of Hotel::BookingSystem
      expect(@booking.rooms.length).must_equal 20
    end

    it "must keep track of rooms" do
      expect(@booking).must_respond_to :rooms
      expect(@booking.rooms).must_be_kind_of Array
      @booking.rooms.each do |room|
        expect(room).must_be_kind_of Hotel::Room
      end
    end

    it "must keep track of reservations" do
      expect(@booking).must_respond_to :reservations
      expect(@booking.reservations).must_be_kind_of Array
      expect(@booking.reservations).must_be :empty?

      @booking.reservations.each do |reservation|
        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end
  end


  describe "list_reservations" do
    before do
      room_num = 2
      room2 = Hotel::Room.new(room_num)
      info = {id: 1445,
        room: room2,
        start_date: "2018-09-07",
        end_date: "2018-09-14"
      }

      reservation2 = Hotel::Reservation.new(info)
      @booking = Hotel::BookingSystem.new
    end
    it "should return all reservations matching the date" do
      date = "2018-09-11"
      expect(@booking.list_reservations(date)).must_be_kind_of Array
      @booking.reservations.each do |reservation|
        expect(reservation.date_range.check_include(date)).wont_be_nil
      end
    end

    it "should not return any reservations that don't match the date" do
      date = "2018-09-20"
      expect(@booking.list_reservations(date)).must_be_kind_of Array
      @booking.reservations.each do |reservation|
        expect(reservation.date_range.check_include(date)).must_be_nil
      end
    end

    it "should return an empty array if no reservations match" do
      date = "2018-09-20"
      expect(@booking.list_reservations(date)).must_be_kind_of Array
      @booking.reservations.each do |reservation|
        expect(reservation.date_range.check_include(date)).must_be :empty?
      end
    end
  end

  describe "find available rooms" do
    it "must find and return an array with available rooms for a given date range" do
      start_date = "2018-10-07"
      end_date = "2018-10-14"

      available_rooms = @booking.find_rooms_available(start_date, end_date)

      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.first).must_be_kind_of Hotel::Room
    end

    it "must return all rooms if all are available" do
      start_date = "2018-10-07"
      end_date = "2018-10-14"

      available_rooms = @booking.find_rooms_available(start_date, end_date)
      expect(available_rooms.length).must_equal 20
    end

    it "must return an empty array if all rooms are unavailable" do
      start_date = "2018-10-07"
      end_date = "2018-10-14"

      20.times do
        @booking.make_reservation(start_date, end_date)
      end

      available_rooms = @booking.find_rooms_available(start_date, end_date)
      expect(available_rooms).must_be :empty?
    end
  end


  describe "make reservation" do
    before do
      start_date = "2018-10-07"
      end_date = "2018-10-14"

      @new_booking = Hotel::BookingSystem.new
      @reservation = @new_booking.make_reservation(start_date, end_date)
    end
    it "is reservation created properly?" do
      expect(@new_booking.rooms.first).must_be_instance_of Hotel::Room
      expect(@reservation).must_be_instance_of Hotel::Reservation

    end

    it "should raise an exception if there is no rooms to reserve" do
      start_date = "2018-10-07"
      end_date = "2018-10-14"

      20.times do
        @booking.make_reservation(start_date, end_date)
      end

      expect{ @booking.make_reservation(start_date, end_date) }.must_raise StandardError
    end

    it "was the reservation listed for the room?" do

      result = @new_booking.rooms.first.room_reservations.find { |reserve| reserve.id == @reservation.id}

      expect(result).must_be_kind_of Hotel::Reservation
      expect(result.room.room_num).must_equal @reservation.room.room_num

    end



  end
end
