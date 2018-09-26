require_relative 'spec_helper'

describe "BookingManager class" do
  describe "Initializer" do
    it "creates an instance of BookingManager" do
      manager = Hotel::BookingManager.new(10)
      expect(manager).must_be_kind_of Hotel::BookingManager
    end

    it "creates the proper structures for instance variables instantiated" do
      hotel_rooms = Hotel::BookingManager.new(20)

      expect(hotel_rooms.rooms).must_be_kind_of Array
      expect(hotel_rooms.reservations).must_be_kind_of Array
    end
  end


  describe "populate_room_list method" do
    it "creates an array of Room instances" do
      new_rooms = Hotel::BookingManager.new(10)
      expect(new_rooms.populate_room_list(10)).must_be_kind_of Array
      expect(new_rooms.populate_room_list(10).first).must_be_instance_of Hotel::Room
      expect(new_rooms.populate_room_list(10).last).must_be_instance_of Hotel::Room
    end

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
  end


  describe "make_reservation_list method" do
    it "returns a value equal to @reservations at instantiation" do
      hotel_rooms = Hotel::BookingManager.new(10)
      expect(hotel_rooms.reservations).must_equal hotel_rooms.make_reservation_list
    end

    it "returns an empty array as the list of reservations" do
      hotel_rooms = Hotel::BookingManager.new(5)
      expect(hotel_rooms.make_reservation_list).must_be_empty
    end
  end

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

  describe "add_reservation_to_calendar method" do
    before do
      @hotel_rooms = Hotel::BookingManager.new(5)
    end

    it "increases the length of the reservations array by one" do
      old_number = @hotel_rooms.reservations.length
      room = @hotel_rooms.rooms[2]
      new_booking = Hotel::Reservation.new(room, guest_name: "Polly Pocket", start_date: "May 10, 2018", end_date: "May 12, 2018")

      @hotel_rooms.add_reservation_to_calendar(new_booking)
      expect(@hotel_rooms.reservations.length).must_equal old_number + 1
    end

    it "adds new instance of Reservation to reservations array" do
      room = @hotel_rooms.rooms[1]
      another_booking = Hotel::Reservation.new(room, guest_name: "Polly Pocket", start_date: "May 10, 2018", end_date: "May 12, 2018")
      @hotel_rooms.add_reservation_to_calendar(another_booking)

      expect(@hotel_rooms.reservations.last).must_be_instance_of Hotel::Reservation
      expect(@hotel_rooms.reservations.last.guest_name).must_equal "Polly Pocket"
    end

    it "creates a hash with room instance as key and dates as hash" do
      hotel = Hotel::BookingManager.new(3)
      # room = Hotel::Room.new(3)
      room = hotel.rooms.first
      another_booking = Hotel::Reservation.new(room, guest_name: "Kim Possible", start_date: "June 11, 2018", end_date: "June 14, 2018")

      hotel.add_reservation_to_calendar(another_booking)
      expect(hotel.add_reservation_to_calendar(another_booking)).must_be_kind_of Hash
      expect(hotel.room_calendar[room]).must_include (Date.parse("June 11, 2018"))
      expect(hotel.room_calendar[room].length).must_equal another_booking.number_nights
    end
  end

  # describe "get_reservation_cost method" do
  #   it "returns the total cost of the reservation" do
  #     hotel = Hotel::BookingManager.new(3)
  #     room = hotel.rooms[3]
  #     booking = Hotel::Reservation.new(room, guest_name: "Tony Tonson", start_date: "June 10, 2018", end_date: "June 12, 2018")
  #
  #     expect(hotel.get_reservation_cost(booking.cost_per_night, booking.number_nights)).must_be_close_to 400
  #   end
  # end

  describe "find_reservations_on_date method" do
    it "returns all reservations on the desired date" do
      hotel = Hotel::BookingManager.new(5)
      room1 = hotel.rooms[0]
      room2 = hotel.rooms[1]
      room3 = hotel.rooms[2]
      booking1 = Hotel::Reservation.new(room1, guest_name: "Marsha Daze", start_date: "June 10, 2018", end_date: "June 12, 2018")
      booking2 = Hotel::Reservation.new(room2, guest_name: "Jessie Jade", start_date: "June 10, 2018", end_date: "June 14, 2018")
      booking3 = Hotel::Reservation.new(room3, guest_name: "Daria Jade", start_date: "June 14, 2018", end_date: "June 16, 2018")
      hotel.add_reservation_to_calendar(booking1)
      hotel.add_reservation_to_calendar(booking2)
      hotel.add_reservation_to_calendar(booking3)

      expect(hotel.find_reservations_on_date("June 11, 2018", hotel.room_calendar).length).must_equal 2
    end
  end

  describe "find_vacancies_on_date method" do
    before do
      @hotel = Hotel::BookingManager.new(5)
      room1 = @hotel.rooms[0]
      room2 = @hotel.rooms[1]
      @room3 = @hotel.rooms[2]
      booking1 = Hotel::Reservation.new(room1, guest_name: "Tonya Blaze", start_date: "June 10, 2018", end_date: "June 12, 2018")
      booking2 = Hotel::Reservation.new(room2, guest_name: "Jane James", start_date: "June 10, 2018", end_date: "June 14, 2018")
      booking3 = Hotel::Reservation.new(@room3, guest_name: "Jessie Jade", start_date: "June 14, 2018", end_date: "June 16, 2018")
      @hotel.add_reservation_to_calendar(booking1)
      @hotel.add_reservation_to_calendar(booking2)
      @hotel.add_reservation_to_calendar(booking3)
    end

    it "returns array of rooms without reservations on given date" do
      expect(@hotel.find_vacancies_on_date("June 10, 2018", @hotel.room_calendar).length).must_equal 3
      expect(@hotel.find_vacancies_on_date("June 17, 2018", @hotel.room_calendar).length).must_equal 5
    end

    # it "returns message of no vacancies when all rooms are reserved" do
    #   room4 = @hotel.rooms[3]
    #   room5 = @hotel.rooms[4]
    #
    #   booking4 = Hotel::Reservation.new(@room3, guest_name: "Lady Day", start_date: "June 10, 2018", end_date: "June 11, 2018")
    #   booking5 = Hotel::Reservation.new(room4, guest_name: "Horis Who", start_date: "June 08, 2018", end_date: "June 14, 2018")
    #   booking6 = Hotel::Reservation.new(room5, guest_name: "Dorian Damian", start_date: "June 06, 2018", end_date: "June 11, 2018")
    #
    #   @hotel.add_reservation_to_calendar(booking4)
    #   @hotel.add_reservation_to_calendar(booking5)
    #   @hotel.add_reservation_to_calendar(booking6)
    #
    #   expect(@hotel.find_vacancies_on_date("June 10, 2018", @hotel.room_calendar)).must_be_kind_of String
    # end
  end

  describe "reserve_available_room method" do
    before do
      @hotel = Hotel::BookingManager.new(5)
      room4 = @hotel.rooms[3]
      room5 = @hotel.rooms[4]

      booking5 = Hotel::Reservation.new(room4, guest_name: "Horis Who", start_date: "June 08, 2018", end_date: "June 14, 2018")
      booking6 = Hotel::Reservation.new(room5, guest_name: "Dorian Damian", start_date: "June 06, 2018", end_date: "June 11, 2018")

      @hotel.add_reservation_to_calendar(booking5)
      @hotel.add_reservation_to_calendar(booking6)

      @number_prior_reservations = @hotel.reservations.length
      @hotel.reserve_available_room("Donna Foster", "January 02, 2019", "January 08, 2019")
    end

    # it "only allows reservations for rooms/dates not already reserved" do
    #
    # end

    it "reserves available room for given date range" do
      expect(@hotel.reservations.length).must_equal @number_prior_reservations + 1
    end

    it "iterates through rooms to find available room" do
      room2 = @hotel.rooms[1]
      booking2 = Hotel::Reservation.new(room2, guest_name: "Joe Jeans", start_date: "June 08, 2018", end_date: "June 14, 2018")
      @hotel.add_reservation_to_calendar(booking2)
      number_reserved = @hotel.reservations.length

      @hotel.reserve_available_room("Lisel Wallace", "June 08, 2018", "June 13, 2018")
      # expect(@hotel.reservations).must_include "Lisel Wallace"
      expect(@hotel.reservations.length).must_equal number_reserved + 1
    end
  end

  describe "determine_date_range method" do
    before do
      @bookingsystem = Hotel::BookingManager.new(5)
      @range = @bookingsystem.determine_date_range("July 10, 2000", "July 15, 2000")
    end

    it "creates array of Date instances" do
      expect(@range.length).must_equal 6
      expect(@range.first).must_be_instance_of Date
    end

    it "includes the correct dates" do
      expect(@range.first.to_s).must_match /2000-07-10/
      expect(@range.last.to_s).must_match /2000-07-15/
    end
  end

  describe "find_vacancies_in_date_range method" do
    before do
      @bookingsystem = Hotel::BookingManager.new(5)
      room = @bookingsystem.rooms[0]
      booking = Hotel::Reservation.new(room, guest_name: "Mary Poppins", start_date: "June 08, 2018", end_date: "June 14, 2018")
      @bookingsystem.add_reservation_to_calendar(booking)
      @found_vacancies = @bookingsystem.find_vacancies_in_date_range("June 10, 2018", "June 12, 2018")
    end

    it "returns the correct number of vacant rooms" do
      expect(@found_vacancies.length).must_equal 4
    end

    it "returns an array of Room instances" do
      expect(@found_vacancies.first).must_be_instance_of Hotel::Room
      expect(@found_vacancies.last).must_be_instance_of Hotel::Room
    end

  end
end
