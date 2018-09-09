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
  end

  describe 'list_reservations_by_date method' do
    let (:reservations_list) { @reservation.list_reservations_by_date(@date_range_2)
    }

    it 'Returns an array of reservation instances' do
      res_by_date = @reservation.list_reservations_by_date(@date_range_1)
      expect(res_by_date).must_be_kind_of Array
    end

    it 'Returns the correct length of the array' do
      expect(@reservation.list_reservations_by_date(@date_range_1).length).must_equal 5
    end

    it 'Correctly returns the reservations for that date range' do
      expect(reservations_list).must_equal reservations_list
    end

    it 'Correctly returns the first reservation for that date range' do
      first = reservations_list.first
      date = Date.parse('2018-09-15')

      binding.pry
      expect(first.room_number).must_equal 6
      expect(first.date_range.start_date).must_equal date
    end

    it 'Correctly returns the last reservation for that date range' do
    end


  end

  describe 'find_available_room method' do
    before do
      @reservation_2 = Hotel::BookingSystem.new()
    end

    it 'Returns 1 if the reservations are empty' do
      expect(@reservation_2.find_available_room(@date_range_2)).must_equal 1
    end

    # it 'Returns the first available room' do
    # end


  end





end
