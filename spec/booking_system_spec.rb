require_relative 'spec_helper'

describe "BookingSystem Class" do
  before do
    @date_range_1 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
    @reservation_1 = Hotel::BookingSystem.new()
    @reservation_1.make_reservation(@date_range_1)
  end

  describe "Initializer" do
    it 'Creates an array of room numbers' do
      expect(@reservation_1.room).must_be_kind_of Array
    end

    it 'Creates an array of reservation instances' do
      expect(@reservation_1.reservations[0]).must_be_kind_of Hotel::Reservation
    end
  end

  describe 'make_reservation method' do
  end

  describe "list_rooms method" do
    it 'Returns an array of room numbers' do
      expect(@reservation_1.list_rooms).must_be_kind_of Array
    end
  end

  describe 'list_reservations_by_date method' do
    before do
      9.times do
        @reservation_1.make_reservation(@date_range_1)
      end
    end

    it 'Returns an array of reservation instances' do
      expect(@reservation.list_reservations_by_date(@date_range_1)).must_be_kind_of Array
    end

    it 'Returns the correct length of the array' do
      expect(@reservation.list_reservations_by_date(@date_range_1).length).must_equal 10
    end

    it 'Correctly returns the first reservation for that date range' do
    end

    it 'Correctly returns the last reservation for that date range' do
    end


  end

  describe 'find_available_room method' do
    before do
      @date_range_2 = Hotel::DateRange.new('2018-09-01', '2018-09-05')
      @reservation_2 = Hotel::BookingSystem.new()
    end

    it 'Returns 1 if the reservations are empty' do
      expect(@reservation_2.find_available_room(@date_range_2)).must_equal 1
    end

    # it 'Returns the first available room' do
    # end


  end





end
