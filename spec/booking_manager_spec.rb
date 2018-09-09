require_relative 'spec_helper'

describe "BookingManager class" do
  describe "Initializer" do
    it "creates an instance of BookingManager" do
      manager = Hotel::BookingManager.new(10)
      expect(manager).must_be_kind_of Hotel::BookingManager
    end # of it instance bookingmanager

    it "creates the proper structures for instance variables instantiated" do
      hotel_rooms = Hotel::BookingManager.new(20)

      expect(hotel_rooms.rooms).must_be_kind_of Array
      expect(hotel_rooms.reservations).must_be_kind_of Array
    end

    # it "assigns instance variables to values returned from class methods" do
    #   hotel_rooms = Hotel::BookingManager.new(5)
    #
    #   expect(hotel_rooms.rooms).must_equal hotel_rooms.populate_room_list(5)
    #   expect(hotel_rooms.reservations).must_equal hotel_rooms.make_reservation_list
    # end
  end # of initializer describe


  describe "populate_room_list method" do
    it "creates an array of Room instances" do
      new_rooms = Hotel::BookingManager.new(10)
      expect(new_rooms.populate_room_list(10)).must_be_kind_of Array
      expect(new_rooms.populate_room_list(10).first).must_be_instance_of Hotel::Room
      expect(new_rooms.populate_room_list(10).last).must_be_instance_of Hotel::Room
    end # of array Room instance it

    it "assigns numbers to rooms consecutively as instantiated" do
      x = 15
      hotel_rooms = Hotel::BookingManager.new(x)
      first_room = hotel_rooms.populate_room_list(x).first
      last_room = hotel_rooms.populate_room_list(x).last

      expect(first_room.number).must_equal 1
      expect(last_room.number).must_equal x
    end

    it "returns array of rooms with length equal to parameter passed into constructor" do
      x = 12
      hotel_rooms = Hotel::BookingManager.new(x)
      expect(hotel_rooms.populate_room_list(x).length).must_equal x
    end
  end # of room load methods


  describe "make_reservation_list method" do
    it "returns a value equal to @reservations at instantiation" do
      hotel_rooms = Hotel::BookingManager.new(10)
      expect(hotel_rooms.reservations).must_equal hotel_rooms.make_reservation_list
    end

    it "returns an empty array as the list of reservations" do
      hotel_rooms = Hotel::BookingManager.new(5)
      expect(hotel_rooms.make_reservation_list).must_be_empty
    end
  end # of reservation list test do

  describe "list_reservations method" do
    it "returns an array" do
      hotel_rooms = Hotel::BookingManager.new(7)
      expect(hotel_rooms.list_reservations).must_be_kind_of Array
    end
  end

  describe "list_rooms method" do
    it "returns an array of Room instances" do
      hotel_rooms = Hotel::BookingManager.new(5)
      expect(hotel_rooms.list_rooms).must_be_kind_of Array
      expect(hotel_rooms.list_rooms.first).must_be_instance_of Hotel::Room
    end

    it "returns an array with the given number of rooms" do
      x = 5
      hotel_rooms = Hotel::BookingManager.new(x)
      expect(hotel_rooms.list_rooms.length).must_equal x
    end
  end

  describe "add_reservation method" do
    before do
      @hotel_rooms = Hotel::BookingManager.new(5)
    end

    it "increases the length of the reservations array by one" do
      old_number = @hotel_rooms.reservations.length
      new_booking = "new reservation"

      @hotel_rooms.add_reservation(new_booking)
      expect(@hotel_rooms.reservations.length).must_equal old_number + 1
    end

    it "adds new instance of Reservation to reservations array" do
      room = Hotel::Room.new(1)
      another_booking = Hotel::Reservation.new(room, guest_name: "Polly Pocket", start_date: "May 10, 2018", end_date: "May 12, 2018")
      @hotel_rooms.add_reservation(another_booking)

      expect(@hotel_rooms.reservations.last).must_be_instance_of Hotel::Reservation
      expect(@hotel_rooms.reservations.last.guest_name).must_equal "Polly Pocket"
    end

  end # of add_reservation method

  describe "add_reservation_to_calendar method" do
    it "creates a hash with room number as key and dates as hash" do
      hotel = Hotel::BookingManager.new(3)
      room = Hotel::Room.new(3)
      another_booking = Hotel::Reservation.new(room, guest_name: "Kim Possible", start_date: "June 11, 2018", end_date: "June 14, 2018")
      expect(hotel.add_reservation_to_calendar(another_booking)).must_be_kind_of Hash
      expect(hotel.room_calendar[3]).must_include Date.parse("June 11, 2018")
      expect(hotel.room_calendar[3].length).must_equal another_booking.number_nights
    end # end of add reservation to calendar method hash room key it
  end # of add reservation to calendar method

  describe "get_reservation_cost method" do
    it "returns the total cost of the reservation" do
      hotel = Hotel::BookingManager.new(3)
      room = Hotel::Room.new(3)
      booking = Hotel::Reservation.new(room, guest_name: "Tony Tonson", start_date: "June 10, 2018", end_date: "June 12, 2018")

      expect(hotel.get_reservation_cost(booking.cost_per_night, booking.number_nights)).must_be_close_to 400
    end # returns product it
  end # of get_reservation_cost method"

  describe "find_reservations_on_date method" do
    it "returns all reservations on the desired date" do
      hotel = Hotel::BookingManager.new(5)
      room1 = Hotel::Room.new(1)
      room2 = Hotel::Room.new(2)
      room3 = Hotel::Room.new(3)
      booking1 = Hotel::Reservation.new(room1, guest_name: "Tony Blaze", start_date: "June 10, 2018", end_date: "June 12, 2018")
      booking2 = Hotel::Reservation.new(room2, guest_name: "Jessie Jade", start_date: "June 10, 2018", end_date: "June 14, 2018")
      booking3 = Hotel::Reservation.new(room3, guest_name: "Jessie Jade", start_date: "June 14, 2018", end_date: "June 16, 2018")
      hotel.add_reservation_to_calendar(booking1)
      hotel.add_reservation_to_calendar(booking2)
      hotel.add_reservation_to_calendar(booking3)

      expect(hotel.find_reservations_on_date("June 11, 2018", hotel.room_calendar).length).must_equal 2
    end # of returns all reservations on date it
  end # of find_reservations_on_date method

  describe "find_vacancies_on_date method" do
    before do
      @hotel = Hotel::BookingManager.new(5)
      room1 = Hotel::Room.new(1)
      room2 = Hotel::Room.new(2)
      @room3 = Hotel::Room.new(3)
      booking1 = Hotel::Reservation.new(room1, guest_name: "Tony Blaze", start_date: "June 10, 2018", end_date: "June 12, 2018")
      booking2 = Hotel::Reservation.new(room2, guest_name: "Jane James", start_date: "June 10, 2018", end_date: "June 14, 2018")
      booking3 = Hotel::Reservation.new(@room3, guest_name: "Jessie Jade", start_date: "June 14, 2018", end_date: "June 16, 2018")
      @hotel.add_reservation_to_calendar(booking1)
      @hotel.add_reservation_to_calendar(booking2)
      @hotel.add_reservation_to_calendar(booking3)
    end

    it "returns array of rooms without reservations on given date" do
      expect(@hotel.find_vacancies_on_date("June 10, 2018", @hotel.room_calendar).length).must_equal 3
      expect(@hotel.find_vacancies_on_date("June 17, 2018", @hotel.room_calendar).length).must_equal 5
    end # of find vacancies it

    it "returns message of no vacancies when all rooms are reserved" do
      room4 = Hotel::Room.new(4)
      room5 = Hotel::Room.new(5)

      booking4 = Hotel::Reservation.new(@room3, guest_name: "Lady Day", start_date: "June 10, 2018", end_date: "June 11, 2018")
      booking5 = Hotel::Reservation.new(room4, guest_name: "Horis Who", start_date: "June 08, 2018", end_date: "June 14, 2018")
      booking6 = Hotel::Reservation.new(room5, guest_name: "Dorian Damian", start_date: "June 06, 2018", end_date: "June 11, 2018")

      @hotel.add_reservation_to_calendar(booking4)
      @hotel.add_reservation_to_calendar(booking5)
      @hotel.add_reservation_to_calendar(booking6)

      expect(@hotel.find_vacancies_on_date("June 10, 2018", @hotel.room_calendar)).must_be_kind_of String 
    end # no find_vacancies no vacancy it
  end # of find vacancies on date method

end # end of describe BookingManager class
