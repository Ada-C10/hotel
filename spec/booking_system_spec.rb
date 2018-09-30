require_relative 'spec_helper'
require 'date'
require 'pry'

describe "BookingSystem Class" do
  before do
    @date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
    @date_range_2 = Hotel::DateRange.new('2018-09-15', '2018-09-20')
    @date_range_3 = Hotel::DateRange.new('2018-08-29', '2018-09-02')
    @reservation = Hotel::BookingSystem.new()


    5.times do
      @reservation.make_reservation(@date_range_1)
    end

    2.times do
      @reservation.make_reservation(@date_range_2)
    end

    3.times do
      @reservation.make_reservation(@date_range_3)
    end

    @reservation.reserve_block_rooms(@date_range_1)
  end

  describe "Initializer" do
    it 'Creates an array of room numbers' do
      expect(@reservation.rooms).must_be_kind_of Array
      expect(@reservation.rooms.length).must_equal 20
    end

    it 'Creates an array of reservation instances' do
      expect(@reservation.reservations.length).must_equal 10
      all_rervations = @reservation.reservations
      all_rervations.each do |r|
        expect(r).must_be_kind_of Hotel::Reservation
      end
    end

    it 'Creates an array of block room instances' do
      expect(@reservation.block_rooms).must_be_kind_of Array
      expect(@reservation.block_rooms.first).must_be_kind_of Hotel::BlockRoom
      expect(@reservation.block_rooms.first.block_rooms).must_equal [*9..13]
    end
  end

  describe "list_rooms method" do
    it 'Returns an array of room numbers' do
      expect(@reservation.rooms).must_be_kind_of Array
      expect(@reservation.rooms.length).must_equal 20
    end
  end

  describe 'list_reservations method' do
    let (:reservations_list_1) {
      @reservation.list_reservations(@date_range_1)
    }

    let (:reservations_list_2) {
      @reservation.list_reservations(@date_range_2)
    }

    let (:reservations_list_3) {
      @reservation.list_reservations(@date_range_3)
    }

    it 'Returns an array of reservation instances' do
      expect(reservations_list_1).must_be_kind_of Array
      reservations_list_1.each do |r|
        expect(r).must_be_kind_of Hotel::Reservation
      end
    end

    it 'Returns the correct length of the array' do
      expect(reservations_list_1.length).must_equal 5
    end

    it 'Correctly returns the reservations for that date range' do
      expect(reservations_list_1).must_equal reservations_list_1
    end

    it 'Correctly returns the first reservation on the list for that date range' do
      first_on_list_1 = reservations_list_1.first
      date_1 = @date_range_1.start_date

      first_on_list_2= reservations_list_2.first
      date_2 = @date_range_2.start_date

      first_on_list_3 = reservations_list_3.first
      date_3 = @date_range_3.start_date

      expect(first_on_list_1.room_number).must_equal 1
      expect(first_on_list_1.date_range.start_date).must_equal date_1

      expect(first_on_list_2.room_number).must_equal 1
      expect(first_on_list_2.date_range.start_date).must_equal date_2

      expect(first_on_list_3.room_number).must_equal 6
      expect(first_on_list_3.date_range.start_date).must_equal date_3
    end

    it 'Correctly returns the last reservation on the list for that date range' do
      last_on_list_1 = reservations_list_1.last
      date_1 = @date_range_1.start_date

      last_on_list_2= reservations_list_2.last
      date_2 = @date_range_2.start_date

      last_on_list_3 = reservations_list_3.last
      date_3 = @date_range_3.start_date

      expect(last_on_list_1.room_number).must_equal 5
      expect(last_on_list_1.date_range.start_date).must_equal date_1

      expect(last_on_list_2.room_number).must_equal 2
      expect(last_on_list_2.date_range.start_date).must_equal date_2

      expect(last_on_list_3.room_number).must_equal 8
      expect(last_on_list_3.date_range.start_date).must_equal date_3
    end
  end

  describe 'list_available_rooms method' do
    let (:reservation_2) { Hotel::BookingSystem.new() }

    it 'Correcly lists the available rooms by date' do
      expect(@reservation.list_available_rooms(@date_range_1)).must_equal [*14..20]
    end

    it 'Returns all the rooms if there are no reservations' do
      expect(reservation_2.list_available_rooms(@date_range_1)).must_equal [*1..20]
    end
  end

  describe 'find_available_rooms method' do
    let (:reservation_3) { Hotel::BookingSystem.new() }

    it 'Returns 1 if there have been no reservations made' do
      expect(reservation_3.reservations).must_be_empty
      expect(reservation_3.find_available_rooms(@date_range_1).first).must_equal 1
    end

    it 'Correctly returns an array of available rooms for the date range' do
      expect(@reservation.find_available_rooms(@date_range_1)).must_equal [*14..20]
    end

    it 'Raises an error if there are no available rooms for the date range' do
        hotel_booked = Hotel::BookingSystem.new()

        20.times do
          hotel_booked.make_reservation(@date_range_1)
        end

        expect{hotel_booked.find_available_rooms(@date_range_1)}.must_raise StandardError
    end
  end

  describe 'make_reservation method' do
    it 'Creates an instance of Reservation' do
      expect(@reservation.make_reservation(@date_range_1)).must_be_kind_of Hotel::Reservation
    end

    it 'Adds the correct available room to the reservation' do
      expect(@reservation.make_reservation(@date_range_1).room_number).must_equal 14
    end

    it 'Adds each instance of reservation into the @reservations instance variable' do
      new_res = @reservation.make_reservation(@date_range_1)

      expect(@reservation.reservations.length).must_equal 11
    end
  end

  describe 'reserve_block_rooms method' do
  end

  describe 'find_block method' do
  end

  describe 'find_room_in_block method' do
  end

  describe 'make_reservation_from_block' do
  end



end
