require_relative 'spec_helper'

describe "booking manager" do
  before do
    @manager = Booking.new
    @test_reservation = Reservation.new(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))
  end

  describe "Initialize" do
    it "can create an instance of booking manager" do
      booking_manager = Booking.new
    end

    it "has a rooms array" do
      expect(@manager.rooms).kind_of? Array
    end

    it "has 20 rooms" do
      expect(@manager.rooms.length).must_equal 20
    end
  end

  describe 'Reservations' do
    it "Returns the correct room" do
      expect(@manager.find_room(1)).must_equal @manager.rooms.first
    end

    it "Creates a reservation instance" do
      expect(@manager.create_reservation(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))).kind_of? Reservation
    end

    it "Adds a reservation to the room" do
      @manager.add_reservation(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))
      # Creates an instance of reservation (own method)
      # Accesses self.rooms/ Finds associated room via room_number (own method)
      # Pushing reservation into room's array(end result of add_reservation)
      expect(@manager.rooms.first.reservations.length).must_equal 1
    end

    it "Can access list of reservations for a given date" do
      # Add a reservation for a date
      @manager.add_reservation(1, Date.new(2018, 9, 1), Date.new(2018, 9, 2))
      @manager.add_reservation(2, Date.new(2018, 9, 1), Date.new(2018, 9, 2))

      # Test to see if list returns both reservations for 9-1-18
      
    end

    it "Has an error if attempting to book a reserved room" do
      # When attempting to add a reservation,
        # Check to see if given date range is already booked
          # Do not include checkout day of prior reservations
      skip
    end


  end

  # Test methods here
  describe "Lists" do
    # Access list of rooms
    it "Shows a list of all the rooms" do
      expect(@manager.list_all_rooms.length).must_equal 20
    end

    # Access list of reserved rooms by date

    # Access list of rooms not reserved for date range


    # List of block rooms

  end
end
