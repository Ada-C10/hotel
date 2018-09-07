require_relative 'spec_helper'

describe "HotelAdmin" do
  let (:hotel) {
     HotelAdmin.new
  }
  describe "HotelAdmin#Initialize" do
    it "can create a hoteladmin object" do
      expect(hotel).must_be_instance_of HotelAdmin
    end

    it "initializes with readable rooms and reservations array attributes" do
      expect(hotel.rooms).must_be_instance_of Array
      expect(hotel.rooms.length).must_equal 20
      expect(hotel.rooms.first).must_be_instance_of Room
      expect(hotel.reservations).must_be_instance_of Array
      expect(hotel.reservations).must_be_empty
    end
  end

  describe "HotelAdmin#build_rooms" do
    it "creates our room objects numbered 1-20" do
      expect(hotel.build_rooms.length).must_equal 20
      expect(hotel.build_rooms.first).must_be_instance_of Room
      expect(hotel.build_rooms).must_be_instance_of Array
    end
  end

  describe "HotelAdmin#list_rooms" do
    it "will return the array room objects" do
          # 20.times do |index|
          #   hotel.rooms << Room.new(index+1)
          # end
          expect(hotel.list_rooms[0]).must_be_instance_of Room
          expect(hotel.list_rooms).must_be_instance_of Array
          expect(hotel.list_rooms.length).must_equal 20
    end
  end

  describe "HotelAdmin#retrieve_by_date" do
    before do
      hotel.reservations << Reservation.new({guest_id: "SoccerMom2010@gmail.com", room: 1, date_range: (Date.new(2018,10,20)...Date.new(2018,10,22))})
      hotel.reservations << Reservation.new({guest_id: "Guccifer2.0@ada.com", room: 1, date_range: (Date.new(2018,12,02)...Date.new(2018,12,07))})
      hotel.reservations << Reservation.new({guest_id: "Jfahmy07@gmail.com", room: 2, date_range: (Date.new(2018,12,03)...Date.new(2018,12,06))})
    end

    it "raises an argument error if invalid date object is provided" do
      expect{ (hotel.retrieve_by_date("I am a string")) }.must_raise ArgumentError
    end

    it "returns an array of the reservations relevant to given date" do
      reservations_for_date = hotel.retrieve_by_date(Date.new(2018,12,04))

      expect(reservations_for_date).must_be_instance_of Array
      expect(reservations_for_date.first).must_be_instance_of Reservation
      expect(reservations_for_date.length).must_equal 2
    end
  end

  describe "HotelAdmin#reserve_room" do
    before do
      @reservation = hotel.build_reservation_hash("FishandChipsgrl@gmail.com", 4, Date.new(2019,01,20), Date.new(2019,01,22))
    end

    it "returns the new reservation object" do
      expect(@reservation.guest_id).must_equal "FishandChipsgrl@gmail.com"
      expect(@reservation.room).must_be_instance_of Integer
      expect(@reservation.status).must_equal :complete
      expect(@reservation.date_range).must_equal (Date.new(2019,01,20)...Date.new(2019,01,22))
      expect(@reservation.stay_cost).must_equal 400.00
    end

    it "adds new reservation to the hoteladmin object's reservations array" do
      expect(hotel.reservations.first).must_be_instance_of Reservation
      expect(hotel.reservations.length).must_equal 1
    end

    it "will raise an exception if a conflicting reservation is added to a room" do

      expect{
        hotel.build_reservation_hash("Mamacita09@gmail.com", 4, Date.new(2019,01,21), Date.new(2019,01,22))
      }.must_raise ArgumentError

    end
  end

  describe "HotelAdmin#reservation_charge" do
    let (:reservation){
      Reservation.new({guest_id: "Guccifer2.0@ada.com", room: 1, date_range: (Date.new(2018,12,02)...Date.new(2018,12,07))})
    }

    it "returns the cost associated with a given reservation" do
      expect(hotel.reservation_charge(reservation)).must_equal 1000.00
    end

  end

  describe "HotelAdmin#retrieve_room" do
    let (:room_instance) {
      hotel.retrieve_room(8)
    }

    it "locates room object using a given room number" do
      expect(room_instance).must_be_instance_of Room
      expect(room_instance.id).must_equal 8
    end
  end

  describe "HotelAdmin#available_rooms" do
    before do
      hotel.build_reservation_hash("SoccerMom2010@gmail.com", 1, Date.new(2018,10,20), Date.new(2018,10,22))
      hotel.build_reservation_hash("Guccifer2.0@ada.com", 1, Date.new(2018,12,02), Date.new(2018,12,07))
      hotel.build_reservation_hash("Jfahmy07@gmail.com", 2, Date.new(2018,12,03), Date.new(2018,12,06))
    end
    it "provides a list of available room NUMBERS for a given date range" do
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
  end

  describe "HotelAdmin#locate_block" do
    before do
      hotel.build_reservation_hash("SoccerMom2010@gmail.com", 1, Date.new(2018,10,20), Date.new(2018,10,22))
      hotel.build_reservation_hash("Guccifer2.0@ada.com", 1, Date.new(2018,12,02), Date.new(2018,12,07))
      hotel.build_reservation_hash("Jfahmy07@gmail.com", 2, Date.new(2018,12,03), Date.new(2018,12,06))
    end

    it "finds 5 available rooms for a given date range" do
      available = hotel.locate_block(Date.new(2018,12,02), Date.new(2018,12,07))
      room_ids = []
      available.each do |room|
        room_ids << room.id
      end

      expect(available).must_be_instance_of Array
      expect(available.first).must_be_instance_of Room
      expect(available.length).must_equal 5
      expect(room_ids).wont_include 1
      expect(room_ids).wont_include 2
    end

    # need much more test data to conquer this part
    # it "returns nil if no rooms available for given date range" do
    #
    # end

  end

  describe "HotelAdmin#reserve_block" do
    it "creates block reservations with :block_reserved status and custom price" do
      previous_reservations = hotel.reservations.length
      new_reservations = hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)

      expect(hotel.reservations.length).must_equal (previous_reservations + 4)
      expect(hotel.reservations.last.status).must_equal :block_reserved
      expect(hotel.reservations.last.rate).must_equal 145.00
      expect(hotel.reservations.last.date_range).must_equal (Date.new(2018,12,02)...Date.new(2018,12,07))
      expect(new_reservations.length).must_equal 4
      expect(new_reservations.first).must_be_instance_of Reservation
      expect(new_reservations.last).must_equal (hotel.reservations.last)

    end

    it "adds block reservations to appropriate rooms" do
      hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      room7 = hotel.retrieve_room(7)
      room8 = hotel.retrieve_room(8)
      room9 = hotel.retrieve_room(9)
      room10 = hotel.retrieve_room(10)

      expect(room7.bookings.count).must_equal 1
      expect(room7.bookings.first).must_be_instance_of Reservation
      expect(room8.bookings.count).must_equal 1
      expect(room8.bookings.first).must_be_instance_of Reservation
      expect(room9.bookings.count).must_equal 1
      expect(room9.bookings.first).must_be_instance_of Reservation
      expect(room10.bookings.count).must_equal 1
      expect(room10.bookings.first).must_be_instance_of Reservation

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
  end

  describe "HotelAdmin#available_rooms_in_block" do
    it "takes a block party name and returns an array of available blocked reservations" do
      hotel.reserve_block("Smith Wedding Party", [7,8,9,10], Date.new(2018,12,02), Date.new(2018,12,07), 145.00)
      room8 = hotel.retrieve_room(8)
      hotel.reserve_room_in_block("Smith Wedding Party", 8)
      room9 = hotel.retrieve_room(9)
      hotel.reserve_room_in_block("Smith Wedding Party", 9)
      room10 = hotel.retrieve_room(10)
#
      available = hotel.available_rooms_in_block("Smith Wedding Party")

      expect(available).must_be_instance_of Array
      expect(available).wont_include 8
      expect(available).wont_include 9
      expect(available).must_include 10
    end
  end

end
