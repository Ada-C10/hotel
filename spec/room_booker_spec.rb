require_relative 'spec_helper'

describe "RoomBooker Class" do
  let (:booking_system) { Hotel::RoomBooker.new() }

  describe "initialize" do
    it 'Creates an array of room numbers' do
      expect(booking_system.rooms).must_be_kind_of Array
    end

    it 'Creates an array of reservation instances' do
      expect(booking_system).must_be_kind_of Hotel::Reservation
    end
  end

  describe "list_rooms method" do
    it 'Returns an array of room numbers' do
      expect(booking_system.list_rooms).must_be_kind_of Array
    end
  end

  describe "check_valid_dates method" do
    it 'Raises an ArgumentError for invalid date ranges' do

      expect{
        booking_system.check_valid_dates('2018-09-05', '2018-09-01')
      }.must_raise ArgumentError

      expect{
        booking_system.check_valid_dates('', '2018-09-01')
      }.must_raise ArgumentError

      expect{
        booking_system.check_valid_dates('2018-09-01', '')
      }.must_raise ArgumentError

      expect{
        booking_system.check_valid_dates('', '')
      }.must_raise ArgumentError

    end
  end



end
