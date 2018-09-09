require_relative 'spec_helper'
require 'date'

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
  end

  describe "Initializer" do
    it 'Creates an array of room numbers' do
      expect(@reservation.room).must_be_kind_of Array
      expect(@reservation.room.length).must_equal 20
    end

    it 'Creates an array of reservation instances' do
      expect(@reservation.reservations.length).must_equal 10
      all_rervations = @reservation.reservations
      all_rervations.each do |r|
        expect(r).must_be_kind_of Hotel::Reservation
      end
    end
  end

  describe "list_rooms method" do
    it 'Returns an array of room numbers' do
      expect(@reservation.list_rooms).must_be_kind_of Array
      expect(@reservation.room.length).must_equal 20
    end
  end

  describe 'make_reservation method' do
    it 'Assigns the correct first available room to the reservation' do
    end

    it '' do
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

  describe 'find_available_rooms method' do
    before do
      @reservation_2 = Hotel::BookingSystem.new()
    end

    it 'Returns 1 if the reservations are empty' do
      expect(@reservation_2.find_available_rooms(@date_range_2).first).must_equal 1
    end

    # it 'Returns the first available room' do
    # end


  end





end
