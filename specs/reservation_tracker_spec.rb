require_relative 'spec_helper'

ROOM_TEST_FILE   = 'specs/test_data/rooms_test.csv'
BLOCK_TEST_FILE   = 'specs/test_data/blocks_test.csv'

describe "ReservationTracker class" do
  describe "Initializer" do
    before do
      @reservation_tracker = Hotel::ReservationTracker.new(
        ROOM_TEST_FILE,
        BLOCK_TEST_FILE
      )
    end
    it "is an instance of ReservationTracker" do
      expect(@reservation_tracker).must_be_kind_of Hotel::ReservationTracker
    end

    it "establishes the base data structures when instantiated" do
      [:rooms, :reservations].each do |prop|
        expect(@reservation_tracker).must_respond_to prop
      end
      expect(@reservation_tracker.rooms).must_be_kind_of Array
      expect(@reservation_tracker.reservations).must_be_kind_of Array
    end
  end

  describe "Room loader methods" do
    it "accurately loads room information into rooms array" do
      first_room = @reservation_tracker.rooms.first
      last_room = @reservation_tracker.rooms.last
      expect(first_room.room_num).must_equal 1
      expect(last_room.room_num).must_equal 20
    end
  end

  describe "#load_rooms method" do
    it "loads the rooms" do
      expect(@reservation_tracker.rooms).must_be_kind_of Array
      expect(@reservation_tracker.rooms.length).must_equal NUM_OF_ROOMS
      expect(@reservation_tracker.rooms.first).must_be_kind_of Hotel::Room
      expect(@reservation_tracker.rooms.last).must_be_kind_of Hotel::Room
      expect(@reservation_tracker.rooms.first.room_num).must_equal 1
      expect(@reservation_tracker.rooms.last.room_num).must_equal 20
    end
  end

  describe "#list_reservations_by_date method" do
    it "lists the reservations searched for by date" do
      reservations = @reservation_tracker.list_reservations_by_date(Date.today)

      expect(reservations).must_be_kind_of Array
      reservations.each do |reservation|
        expect(reservation.date_range.get_range).must_include Date.today
      end
    end
  end

  before do
    @reservation_tracker = Hotel::ReservationTracker.new
    @start_date = Date.today
    @end_date = @start_date + 5
    @input = {
      start_date: @start_date,
      end_date: @end_date
    }

    @block_input = {
      start_date: @start_date,
      end_date: @end_date,
      party: 5
    }

    @reservation_tracker.reserve_room(@input)
    @requested_dates = Hotel::DateRange.new(@start_date, @end_date)

    @initial_block_length = @reservation_tracker.blocked_rooms.size

  end

  describe "#reservations_overlaps? method" do
    it "checks if the requested dates overlap with all existing reservations" do
      matching_reservations = @reservation_tracker.reservations_overlaps?(@requested_dates)
      expect(matching_reservations).must_be_kind_of Array
      expect(matching_reservations.length).must_equal 1
      expect(matching_reservations.first).must_be_kind_of Hotel::Reservation
    end
  end

  describe "#find_reserved_rooms method" do
    it "finds all the reserved rooms by requested_dates" do
      reserved_rooms = @reservation_tracker.find_reserved_rooms(@requested_dates)
      expect(reserved_rooms).must_be_kind_of Array
      expect(reserved_rooms.length).must_equal 1
      expect(reserved_rooms.first.room_num).must_equal 1
    end

  end

  describe "#find_blocked_rooms method" do
    it "finds all the blocked rooms by requested_dates" do
      block = @reservation_tracker.block_rooms(@block_input)
      blocked_rooms = @reservation_tracker.find_blocked_rooms(@requested_dates)
      expect(blocked_rooms).must_be_kind_of Array
      expect(blocked_rooms.size).must_equal block.party.size + @initial_block_length
    end
  end

  describe "#find_unavailable_rooms method" do
    it "finds all unavailable rooms for requested dates" do
      unavailable_rooms = @reservation_tracker.find_unavailable_rooms(@requested_dates)
      expect(unavailable_rooms).must_be_kind_of Array
      expect(unavailable_rooms.length).must_equal 1 + @initial_block_length
      expect(unavailable_rooms.first).must_be_kind_of Hotel::Room
    end

    it "returns [] if there are no unavailable rooms for requested dates" do
      reservation_tracker = Hotel::ReservationTracker.new
      unavailable_rooms = reservation_tracker.find_unavailable_rooms(@requested_dates)
      unavailable_rooms.clear
      expect(unavailable_rooms).must_equal []
    end
  end

  describe "#find_available_rooms method" do
    it "finds all available rooms for requested dates" do
      available_rooms = @reservation_tracker.find_available_rooms(@requested_dates)
      expect(available_rooms).must_be_kind_of Array
      expect(available_rooms.length).must_equal 19
      expect(available_rooms.first).must_be_kind_of Hotel::Room

    end

    it "raises an error if there are no rooms available for requested dates" do
      reservation_tracker = Hotel::ReservationTracker.new

      20.times do
        reservation_tracker.reserve_room(@input)
      end

      expect{ reservation_tracker.find_available_rooms(@requested_dates) }.must_raise Hotel::ReservationTracker::NoRoomsError
      expect{ reservation_tracker.reserve_room(@input) }.must_raise Hotel::ReservationTracker::NoRoomsError
    end
  end

  describe "#get_first_available_room method for requested dates" do
    it "returns the first available room for requested dates" do
      first_available_room = @reservation_tracker.get_first_available_room(@requested_dates)
      expect(first_available_room).must_be_kind_of Hotel::Room
      expect(first_available_room.room_num).must_equal 2
    end
  end

  describe "#confirm_valid_dates method" do
    it "raises an error if start_date and end_date are both not Date types" do
      start_date = 'Date.today'
      end_date = 'start_date - 5'

      input = {
        start_date: start_date,
        end_date: end_date
      }

      expect { @reservation_tracker.confirm_valid_dates?(input) }.must_raise Hotel::ReservationTracker::InvalidDateError
    end

    it "raises an error if start_date is a Date and but end_date is not" do
      start_date = Date.today
      end_date = "Date.today + 5"

      input = {
        start_date: start_date,
        end_date: end_date
      }

      expect { @reservation_tracker.confirm_valid_dates?(input) }.must_raise Hotel::ReservationTracker::InvalidDateError
    end

    it "raises an error if start_date not a Date and but end_date is" do
      start_date = "Date.today"
      end_date = Date.today + 5

      input = {
        start_date: start_date,
        end_date: end_date
      }

      expect { @reservation_tracker.confirm_valid_dates?(input) }.must_raise Hotel::ReservationTracker::InvalidDateError
    end

    it "raises an error if end date precedes start date" do
      start_date = Date.today
      end_date = start_date - 5

      input = {
        start_date: start_date,
        end_date: end_date
      }

      expect { @reservation_tracker.confirm_valid_dates?(input) }.must_raise Hotel::ReservationTracker::DatesOrderError
    end
  end

  describe "#get_requested_dates method" do
    it "creates an instance of DateRange with the start_date and end_date inputs" do
      date_range = @reservation_tracker.get_requested_dates(@input)
      expect(date_range).must_be_kind_of Hotel::DateRange
    end
  end

  describe "#reserve_room method" do
    it "reserves a room if one is available for requested dates" do
      inital_length = @reservation_tracker.reservations.length

      new_reservation = @reservation_tracker.reserve_room(@input)
      new_length = @reservation_tracker.reservations.length

      expect(new_reservation).must_be_kind_of Hotel::Reservation
      expect(new_length).must_equal inital_length + 1
    end
  end

  describe "#confirm_valid_qty? method" do
    it "checks if the amt entered is not an Integer or <= 0" do
      expect{ @reservation_tracker.confirm_valid_qty?(0) }.must_raise Hotel::ReservationTracker::InvalidAmountRoomsError
      expect{ @reservation_tracker.confirm_valid_qty?(4.5) }.must_raise Hotel::ReservationTracker::InvalidAmountRoomsError
      expect{ @reservation_tracker.confirm_valid_qty?('5') }.must_raise Hotel::ReservationTracker::InvalidAmountRoomsError
    end

    it "checks if the amt requested is less or equal to 5" do
      expect(@reservation_tracker.confirm_valid_qty?(1)).must_equal nil
      expect(@reservation_tracker.confirm_valid_qty?(5)).must_equal nil
      expect{@reservation_tracker.confirm_valid_qty?(6)}.must_raise Hotel::ReservationTracker::TooManyRoomsError
    end
  end

  describe "#get_blocked_rooms method" do
    it "gets blocked rooms if there are available rooms" do
      requested_amt = 5
      block = @reservation_tracker.get_blocked_rooms( requested_amt, @requested_dates)

      expect(block).must_be_kind_of Array
      expect(block.length).must_equal requested_amt
    end

    it "raises a NotEnoughError if there are not enough available rooms to block" do
      reservation_tracker = Hotel::ReservationTracker.new

      16.times do
        reservation_tracker.reserve_room(@input)
      end

      requested_amt = 5
      expect{ reservation_tracker.get_blocked_rooms(requested_amt, @requested_dates) }.must_raise Hotel::ReservationTracker::NotEnoughError
    end
  end

  describe "#block_rooms method" do
    before do
      @reservation_tracker = Hotel::ReservationTracker.new
      @start_date = Date.today
      @end_date = @start_date + 5
      @input = {
        start_date: @start_date,
        end_date: @end_date,
        party: 5
      }
      @reservation_tracker.block_rooms(@input)
      @requested_dates = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "blocks rooms if available" do
      initial_length = @reservation_tracker.blocked_rooms.length

      new_block = @reservation_tracker.block_rooms(@input)
      new_length = @reservation_tracker.blocked_rooms.length

      expect(new_block).must_be_kind_of Hotel::Block
      expect(new_length).must_equal initial_length + 1
    end
  end

  describe "add_reservation from blocked room method" do
    before do
      @reservation_tracker = Hotel::ReservationTracker.new
      @num_of_rooms = 5
      @start_date = Date.today
      @end_date = @start_date + 5
      @block_input = {
        start_date: @start_date,
        end_date: @end_date,
        party: 5
      }
      @res_input = {
        block_id: 1,
        start_date: @start_date,
        end_date: @end_date
      }
      @reservation_tracker.reserve_room(@res_input)
      @requested_dates = Hotel::DateRange.new(@start_date, @end_date)
    end

    it "adds a reservation with a block_id" do
      reserve_room_with_block_id = @reservation_tracker.reserve_room(@res_input)
      reserve_room_with_block_id.must_be_instance_of Hotel::Reservation
    end

    it "adds new block to blocks array" do
      initial_length = @reservation_tracker.blocked_rooms.length
      @reservation_tracker.block_rooms(@block_input)
      new_length = @reservation_tracker.blocked_rooms.length
      new_length.must_equal initial_length + 1
    end

    it "adds a second reservation with a block_id to the next available room in the block" do
      initial_length = @reservation_tracker.reservations.length
      @reservation_tracker.block_rooms(@block_input)
      @reservation_tracker.reserve_room(@res_input)
      @reservation_tracker.reserve_room(@res_input)
      new_length = @reservation_tracker.reservations.length
      expect(new_length).must_equal initial_length + 2
    end
  end
end
