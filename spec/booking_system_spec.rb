require_relative 'spec_helper'

describe 'BookingSystem' do
  before do
    rs1 = Hotel::Reservation.new(102, "Sam Pull", [2], "January 1, 2019", "January 10, 2019")
    rs2 = Hotel::Reservation.new(103, "Bulldog Betty", [19], "October 22, 2019", "October 25, 2019")
    rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 13, 2019")
  end

  it 'can load existing reservations' do
    # expect(Hotel::BookingSystem.load_reservations).must_be_kind_of Array
  end
  it 'can show available rooms' do


  end
  it 'can make a reservation' do
    # expect(Hotel::BookingSystem.new_reservation).must_be_kind_of Hotel::Reservation
  end
end