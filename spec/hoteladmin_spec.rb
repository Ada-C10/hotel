require_relative 'spec_helper'
require 'pry'

describe "HotelAdmin" do
  let (:hotel) {
     Hotel::HotelAdmin.new
  }
  describe "HotelAdmin#Initialize" do
    it "can create a hoteladmin object" do
      expect(hotel).must_be_instance_of Hotel::HotelAdmin
    end

    it "initializes with readable rooms array attribute" do
      expect(hotel.rooms).must_be_instance_of Array
      expect(hotel.rooms.length).must_equal 20
      expect(hotel.rooms.first).must_be_instance_of Hotel::Room
    end
  end

  describe "HotelAdmin#build_rooms" do
    it "creates our room objects numbered 1-20" do
      expect(hotel.build_rooms.length).must_equal 20
      expect(hotel.build_rooms.first).must_be_instance_of Hotel::Room
      expect(hotel.build_rooms).must_be_instance_of Array
    end
  end

  describe "HotelAdmin#list_rooms" do
    it "will return the array room objects" do
          # 20.times do |index|
          #   hotel.rooms << Room.new(index+1)
          # end
          expect(hotel.list_rooms[0]).must_be_instance_of Hotel::Room
          expect(hotel.list_rooms).must_be_instance_of Array
          expect(hotel.list_rooms.length).must_equal 20
    end
  end

  describe "HotelAdmin#retrieve_by_date" do
    before do
      @room1 = hotel.retrieve_room(1)
      @room1.add_booking(Hotel::Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: @room1, date_range: (Date.new(2018,10,20)...Date.new(2018,10,22))}))
      @room1.add_booking(Hotel::Reservation.new({guest_id: "Guccifer2.0@ada.com", room: @room1, date_range: (Date.new(2018,12,02)...Date.new(2018,12,07))}))
      @room2 = hotel.retrieve_room(2)
      @room2.add_booking(Hotel::Reservation.new({guest_id: "Jfahmy07@gmail.com", room: @room2, date_range: (Date.new(2018,12,03)...Date.new(2018,12,06))}))
    end

    it "raises an argument error if invalid date object is provided" do
      expect{ (hotel.retrieve_by_date("I am a string")) }.must_raise ArgumentError
    end

    it "returns an array of the reservations relevant to given date" do
      reservations_for_date = hotel.retrieve_by_date(Date.new(2018,12,04))

      expect(reservations_for_date).must_be_instance_of Array
      expect(reservations_for_date.first).must_be_instance_of Hotel::Reservation
      expect(reservations_for_date.length).must_equal 2
    end
  end

  describe "HotelAdmin#build_reservation" do
    it "Raises an ArgumentError if items from the Date class are not provided" do
      expect {
        hotel.build_reservation("FishandChipsgrl@gmail.com", 4, "2019-01-20", "2019-01-22")
      }.must_raise ArgumentError
    end
  end

  describe "HotelAdmin#build_reservation" do
    before do
      @reservation = hotel.build_reservation("FishandChipsgrl@gmail.com", 4, Date.new(2019,01,20), Date.new(2019,01,22))
    end

    it "returns the new reservation object" do
      expect(@reservation.guest_id).must_equal "FishandChipsgrl@gmail.com"
      expect(@reservation.room).must_be_instance_of Integer
      expect(@reservation.status).must_equal :complete
      expect(@reservation.date_range).must_equal (Date.new(2019,01,20)...Date.new(2019,01,22))
      expect(@reservation.stay_cost).must_equal 400.00
    end

    it "adds new reservation to a room" do
      expect(hotel.rooms[3].bookings.first).must_be_instance_of Hotel::Reservation
      expect(hotel.rooms[3].bookings.length).must_equal 1
    end

    it "will raise an exception if there is an attempt to add a conflicting reservation" do
      expect{
        hotel.build_reservation("Mamacita09@gmail.com", 4, Date.new(2019,01,21), Date.new(2019,01,22))
      }.must_raise ArgumentError
    end
  end

  describe "HotelAdmin#retrieve_room" do
    let (:room_instance) {
      hotel.retrieve_room(8)
    }

    it "locates room object using a given room number" do
      expect(room_instance).must_be_instance_of Hotel::Room
      expect(room_instance.id).must_equal 8
    end
  end

  describe "HotelAdmin#available_rooms" do
    before do
      hotel.build_reservation("SoccerMom2010@gmail.com", 1, Date.new(2018,10,20), Date.new(2018,10,22))
      hotel.build_reservation("Guccifer2.0@ada.com", 1, Date.new(2018,12,02), Date.new(2018,12,07))
      hotel.build_reservation("Jfahmy07@gmail.com", 2, Date.new(2018,12,03), Date.new(2018,12,06))
    end

    it "provides a list of available rooms for a given date range" do
      available = hotel.available_rooms(Date.new(2018,12,04), Date.new(2018,12,05))
      room_ids = []
      available.each do |room|
        room_ids << room.id
      end

      expect(available).must_be_instance_of Array
      expect(available.length).must_equal 18
      expect(room_ids).wont_include 1
      expect(room_ids).wont_include 2
    end

    it "returns empty array if no rooms are available for a given date range" do
      20.times do |num|
        hotel.build_reservation("testyMcTester@pluto.com", num+1, Date.new(2018,12,10), Date.new(2018,12,16))
      end

      expect(hotel.available_rooms(Date.new(2018,12,10), Date.new(2018,12,16))).must_be_empty
    end
  end

  describe "HotelAdmin#locate_block" do
    before do
      hotel.build_reservation("SoccerMom2010@gmail.com", 1, Date.new(2018,10,20), Date.new(2018,10,22))
      hotel.build_reservation("Guccifer2.0@ada.com", 1, Date.new(2018,12,02), Date.new(2018,12,07))
      hotel.build_reservation("Jfahmy07@gmail.com", 2, Date.new(2018,12,03), Date.new(2018,12,06))
    end

    it "finds 5 available rooms for a given date range" do
      available = hotel.locate_block(Date.new(2018,12,02), Date.new(2018,12,07))
      room_ids = []
      available.each do |room|
        room_ids << room.id
      end

      expect(available).must_be_instance_of Array
      expect(available.first).must_be_instance_of Hotel::Room
      expect(available.length).must_equal 5
      expect(room_ids).wont_include 1
      expect(room_ids).wont_include 2
    end

    it "returns empty array if no rooms available in block" do
      hotel.reserve_block("Ada Lovelace Celebration", [16,17,18], Date.new(2019,01,03), Date.new(2019,01,06), 145.00)
      [16,17,18].each do |room|
        hotel.reserve_room_in_block("Ada Lovelace Celebration", room)
      end

      expect(hotel.available_rooms_in_block("Ada Lovelace Celebration")).must_be_empty
    end

  end

  describe "HotelAdmin#reserve_block" do
    it "creates block reservations with :block_reserved status and custom price" do
      test_room = hotel.retrieve_room(7)
      previous_reservations = test_room.bookings.length
      new_reservations = hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)

      expect(test_room.bookings.length).must_equal (previous_reservations + 1)
      #binding.pry
      expect(test_room.bookings.last.status).must_equal :block_reserved
      expect(test_room.bookings.last.rate).must_equal 145.00
      expect(test_room.bookings.last.date_range).must_equal (Date.new(2018,12,02)...Date.new(2018,12,07))
      expect(new_reservations.length).must_equal 4
      expect(new_reservations.first).must_be_instance_of Hotel::Reservation
      expect(new_reservations.first).must_equal (test_room.bookings.last)
    end

    it "raises an argument error if more than 5 rooms are provided" do
      expect {
        hotel.reserve_block("Smith Wedding Party", [1,2,3,4,5,6,7], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      }.must_raise ArgumentError
    end

    it "adds block reservations to appropriate rooms" do
      hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      room7 = hotel.retrieve_room(7)
      room8 = hotel.retrieve_room(8)
      room9 = hotel.retrieve_room(9)
      room10 = hotel.retrieve_room(10)

      expect(room7.bookings.count).must_equal 1
      expect(room7.bookings.first).must_be_instance_of Hotel::Reservation
      expect(room8.bookings.count).must_equal 1
      expect(room8.bookings.first).must_be_instance_of Hotel::Reservation
      expect(room9.bookings.count).must_equal 1
      expect(room9.bookings.first).must_be_instance_of Hotel::Reservation
      expect(room10.bookings.count).must_equal 1
      expect(room10.bookings.first).must_be_instance_of Hotel::Reservation
    end

    it "raise ArgumentError if a room being placed in the block has previous reservation for date range" do
      hotel.build_reservation("SoccerMom2010@gmail.com", 5, Date.new(2019,01,02), Date.new(2019,01,04))

      expect {
        (hotel.reserve_block("Jameson's Birthday Bash", [4,5,6], Date.new(2019,01,03), Date.new(2019,01,06), 145.00))
      }.must_raise ArgumentError
    end
  end

  describe "HotelAdmin#reserve_room_in_block" do
    it "takes a room and guest_id and completes room reservation" do
      hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      room9 = hotel.retrieve_room(9)
      hotel.reserve_room_in_block("Smith Wedding Party", 9)

      expect(room9.bookings.first.status).must_equal :complete
      expect(room9.bookings.first.guest_id).must_equal "Smith Wedding Party"
    end

    it "returns an argument error if the given room is not available" do
      hotel.reserve_block("Monique's Wedding", [13,14,15], Date.new(2019,01,03), Date.new(2019,01,06), 145.00)
      [13,14,15].each do |room|
        hotel.reserve_room_in_block("Monique's Wedding", room)
      end

      expect {
        hotel.reserve_room_in_block("Monique's Wedding", 14)
      }.must_raise ArgumentError

    end
  end

  describe "HotelAdmin#available_rooms_in_block" do
    it "takes a block party name and returns an array of available blocked reservations" do
      hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      room8 = hotel.retrieve_room(8)
      hotel.reserve_room_in_block("Smith Wedding Party", 8)
      room9 = hotel.retrieve_room(9)
      hotel.reserve_room_in_block("Smith Wedding Party", 9)
      room10 = hotel.retrieve_room(10)

      available = hotel.available_rooms_in_block("Smith Wedding Party")

      expect(available).must_be_instance_of Array
      expect(available.length).must_equal 2
      expect(room10.bookings.last.status).must_equal :block_reserved
    end

    it "will return an empty array if no rooms are available in block" do
      hotel.reserve_block("Jameson's Birthday Bash", [4,5,6], Date.new(2019,01,03), Date.new(2019,01,06), 145.00)
      [4,5,6].each do |room|
        hotel.reserve_room_in_block("Jameson's Birthday Bash", room)
      end

      expect(hotel.available_rooms_in_block("Jameson's Birthday Bash")).must_be_empty
    end
  end

end
