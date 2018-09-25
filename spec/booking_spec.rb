require_relative 'spec_helper'
require 'date'

describe "booking manager" do
  before do
    @manager = Booking.new
    @test_reservation = Reservation.new(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))
  end

  describe "Initialize" do
    it "can create an instance of booking manager" do
      booking_manager = Booking.new
      expect(booking_manager).kind_of? Booking
    end

    it "has a rooms array" do
      expect(@manager.rooms).kind_of? Array
      expect(@manager).respond_to? :rooms
    end

    it "has 20 rooms" do
      expect(@manager.rooms.length).must_equal 20
    end
  end

  describe 'Reservations' do
    it "Returns the correct room" do
      expect(@manager.find_room(1)).must_equal @manager.rooms.first
      expect(@manager).respond_to? :find_room
      expect(@manager.find_room(1)).kind_of? Room
    end

    it "Creates a reservation instance" do
      expect(@manager.create_reservation(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))).kind_of? Reservation
    end

    it "Adds a reservation to the room" do
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 1)
      # Creates an instance of reservation (own method)
      # Accesses self.rooms/ Finds associated room via room_number (own method)
      # Pushing reservation into room's array(end result of add_reservation)
      expect(@manager.rooms.first.reservations.length).must_equal 1
    end

    it "Can reserve an available room for a given date range" do
      # Given date range (list_rooms_available_for_date_range)
      # Only reserve room if room is available
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 2)
      expect(@manager.rooms[1].reservations.length).must_equal 1
      expect(@manager.rooms.first.reservations.first).kind_of? Reservation
    end

    it "Raises a RoomUnavailableError if attempting to reserve an unavailable room" do
      # Adding a reservation so room will be unavailable
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 2)

      expect{
        @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 2)
      }.must_raise RoomUnavailableError
    end

    it "Adds a room to the first available room is a room number is not provided" do
      # Adding a reservation to room one, should add test reservation to room two
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 1)
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2))
      expect(@manager.rooms[1].reservations.length).must_equal 1
    end

    it "Is able to get the total cost for a given reservation" do
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 1)
      expect(@manager.total_cost_for_reservation(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))).must_equal @manager.rooms.first.reservations.first.total
    end

    it "Raises a NoReservationExistsError if the reservation cannot be found" do
      expect{
        @manager.total_cost_for_reservation(1, Date.new(2018, 1, 1), Date.new(2018, 1, 2))
      }.must_raise NoReservationExistsError
    end
  end

  describe "Lists" do
    # Access list of rooms
    it "Shows a list of all the rooms" do
      expect(@manager).respond_to? :list_all_rooms
      expect(@manager.list_all_rooms.length).must_equal 20
      expect(@manager).kind_of? Array
    end

    # Access list of reserved rooms by date
    it "Is able to list reservations for a date" do
      # Adding a reservation to @manager
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 1)
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2), 2)
      # Checking length of returned array
      expect(@manager.list_reservations_for_date(Date.new(2018, 9, 1)).length).must_equal 2
    end

    describe "Date range overlap" do
      it "Returns true if two date ranges have the same dates" do
        start_date = Date.new(2018,9,1)
        end_date = Date.new(2018,9, 2)
        reservation_start_date = Date.new(2018,9,1)
        reservation_end_date = Date.new(2018,9,2)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal TRUE
      end

      it "Returns true if two date ranges overlap in the front" do
        start_date = Date.new(2018,9,1)
        end_date = Date.new(2018,9, 5)
        reservation_start_date = Date.new(2018,8,30)
        reservation_end_date = Date.new(2018,9,2)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal TRUE
      end

      it "Returns true if two date ranges overlap in the back" do
        start_date = Date.new(2018,9,1)
        end_date = Date.new(2018,9, 5)
        reservation_start_date = Date.new(2018,9,4)
        reservation_end_date = Date.new(2018,9,7)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal TRUE
      end

      it "Returns true if one of the date ranges is completly contained" do
        start_date = Date.new(2018,9,1)
        end_date = Date.new(2018,9, 5)
        reservation_start_date = Date.new(2018,9,2)
        reservation_end_date = Date.new(2018,9,3)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal TRUE
      end

      it "Returns false if one of the date ranges is completely before" do
        start_date = Date.new(2018,9,1)
        end_date = Date.new(2018,9, 5)
        reservation_start_date = Date.new(2018,8,28)
        reservation_end_date = Date.new(2018,8,30)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal FALSE
      end

      it "Returns false if one of the date ranges ends on the checkin date" do
        start_date = Date.new(2018,9,1)
        end_date = Date.new(2018,9, 5)
        reservation_start_date = Date.new(2018,9,5)
        reservation_end_date = Date.new(2018,9,7)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal FALSE
      end

      it "Returns false if one of the date ranges starts on the checkout date" do
        start_date = Date.new(2018,9,7)
        end_date = Date.new(2018,9, 10)
        reservation_start_date = Date.new(2018,9,5)
        reservation_end_date = Date.new(2018,9,7)
        expect(@manager.date_range_overlap?(start_date, end_date, reservation_start_date, reservation_end_date)).must_equal FALSE
      end
    end

    # Access list of rooms not reserved for date range
    it "Is able to access list of rooms not reserved for a date range" do
      # Adding reservations for test
      @manager.add_reservation(Date.new(2018, 9, 1), Date.new(2018, 9, 2),1)
      @manager.add_reservation(Date.new(2018, 9, 2), Date.new(2018, 9, 3), 2)
      expect(@manager.list_rooms_available_for_date_range(Date.new(2018, 9, 1), Date.new(2018, 9, 4))).kind_of? Array
      expect(@manager.list_rooms_available_for_date_range(Date.new(2018, 9, 1), Date.new(2018, 9, 4)).length).must_equal 18
      expect(@manager.list_rooms_available_for_date_range(Date.new(2018, 9, 1), Date.new(2018, 9, 4)).first).kind_of? Room
    end

    it "Returns a NoRoomsAvailableError if no rooms are available" do
      # Adding a reservation to all rooms for 9/2/18 - 9/3/18
      i = 1
      @manager.rooms.each do |room|
        @manager.add_reservation(Date.new(2018, 9, 2), Date.new(2018, 9, 3), i)
        i += 1
      end
      expect{
        @manager.list_rooms_available_for_date_range(Date.new(2018, 9, 2), Date.new(2018, 9, 3))
        }.must_raise NoRoomsAvailableError
    end

    # List of block rooms

  end
end
