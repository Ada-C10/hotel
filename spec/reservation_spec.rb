require_relative 'spec_helper'
require 'date'


describe 'Reservation' do
  # before do
  #   rs1 = Hotel::Reservation.new(102, "Sam Pull", [2], "January 1, 2019", "January 10, 2019", 1800.00 )
  #   rs2 = Hotel::Reservation.new(103, "Bulldog Betty", [19], "October 22, 2019", "October 25, 2019", 600.00 )
  #   rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 13, 2019", 600.00 )
  # end

  it 'instantiates a reservation' do
    new_res = Hotel::Reservation.new(110, "Coco deVille", [1, 3, 4], "March 3, 2019", "March 5, 2019", 400.00)
    expect(new_res).must_be_kind_of Hotel::Reservation
  end

  it 'raises an error if end date is before start date' do
    expect {
      rs1 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 10, 2019", 600.00 )
    }.must_raise ArgumentError
  end

  it 'raises an error if start or end data are nil' do
    expect {
      rs2 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], nil, "May 10, 2019", 600.00 )
    }.must_raise ArgumentError
  end

  it 'raises an error if start or end data are not dates' do
    expect {
      rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "keyboard", "test", 600.00 )
    }.must_raise ArgumentError
  end

  it 'raises an error if no rooms are included in the booking' do
    expect {
      rs4 = Hotel::Reservation.new(104, "Dolly Raj", [], "May 12, 2019", "May 14, 2019", 600.00 )
    }.must_raise ArgumentError
  end

  it 'raises an error if no guest name is included in the booking' do
    expect {
      rs5 = Hotel::Reservation.new(104, "", [8], "May 12, 2019", "May 14, 2019", 600.00 )
    }.must_raise ArgumentError
    expect {
      rs6 = Hotel::Reservation.new(104, nil, [8], "May 12, 2019", "May 14, 2019", 600.00 )
    }.must_raise ArgumentError
  end
end


describe 'it can load csv data' do
  it 'can return all current reservation instances as an array' do
    expect(Hotel::Reservation.all_reservations).must_be_kind_of Array
  end
  it 'can parse data from csv correctly' do
    expect(Hotel::Reservation.all_reservations[0].id).must_be_kind_of String
    expect(Hotel::Reservation.all_reservations[0].guest_name).must_be_kind_of String
    expect(Hotel::Reservation.all_reservations[0].included_rooms).must_be_kind_of Array
    expect(Hotel::Reservation.all_reservations[0].included_rooms[0]).must_be_kind_of Integer
  end
end