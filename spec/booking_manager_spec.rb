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
  end


end # end of describe BookingManager class
