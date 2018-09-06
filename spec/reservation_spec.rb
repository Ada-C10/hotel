require_relative 'spec_helper'
require 'date'


describe 'Reservation' do
  # before do
  #   rs1 = Hotel::Reservation.new(102, "Sam Pull", [2], "January 1, 2019", "January 10, 2019", 1800.00 )
  #   rs2 = Hotel::Reservation.new(103, "Bulldog Betty", [19], "October 22, 2019", "October 25, 2019", 600.00 )
  #   rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 13, 2019", 600.00 )
  # end

  it 'instantiates a reservation' do
    new_res = Hotel::Reservation.new(110, "Coco deVille", [1, 3, 4], "March 3, 2019", "March 5, 2019")
    expect(new_res).must_be_kind_of Hotel::Reservation
    expect(new_res.id).must_be_kind_of Integer
    expect(new_res.booked_dates).must_be_kind_of Array
    expect(new_res.booked_dates).wont_be_empty
    expect(new_res.status).must_be_kind_of Symbol
    expect(new_res.total_cost).must_be_kind_of Float
    expect(new_res.total_cost).must_be :>, 0
  end

  it 'correctly populates booked_dates array with range of dates' do
    new_res = Hotel::Reservation.new(110, "Coco deVille", [1, 3, 4], "March 3, 2019", "March 8, 2019")
    expect(new_res.booked_dates.length).must_equal 5
    expect(new_res.booked_dates.first).must_equal "2019-03-03"
    expect(new_res.booked_dates.last).must_equal "2019-03-07"
  end

  it 'correctly tallies up the total cost' do
    new_res = Hotel::Reservation.new(110, "Coco deVille", [1, 3, 4], "March 3, 2019", "March 5, 2019")
    # total cost = 3 rooms x 2 nights x $200.00
    expect(new_res.total_cost).must_be_close_to (3 * 2 * 200)
  end

  it 'raises an error if end date is before start date' do
    expect {
      rs1 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 10, 2019")
    }.must_raise ArgumentError
  end

  it 'raises an error if start or end data are nil' do
    expect {
      rs2 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], nil, "May 10, 2019")
    }.must_raise ArgumentError
  end

  it 'raises an error if start or end data are not dates' do
    expect {
      rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "keyboard", "test")
    }.must_raise ArgumentError
  end

  it 'raises an error if no rooms are included in the booking' do
    expect {
      rs4 = Hotel::Reservation.new(104, "Dolly Raj", [], "May 12, 2019", "May 14, 2019")
    }.must_raise ArgumentError
  end

  it 'raises an error if no guest name is included in the booking' do
    expect {
      rs5 = Hotel::Reservation.new(104, "", [8], "May 12, 2019", "May 14, 2019")
    }.must_raise ArgumentError
    expect {
      rs6 = Hotel::Reservation.new(104, nil, [8], "May 12, 2019", "May 14, 2019")
    }.must_raise ArgumentError
  end
end


describe 'it can load csv data' do
  it 'can return all current reservation instances as an array' do
    expect(Hotel::Reservation.load_reservations).must_be_kind_of Array
  end
  it 'can parse data from csv correctly' do
    expect(Hotel::Reservation.load_reservations[0].id).must_be_kind_of Integer
    expect(Hotel::Reservation.load_reservations[0].guest_name).must_be_kind_of String
    expect(Hotel::Reservation.load_reservations[0].included_rooms).must_be_kind_of Array
    expect(Hotel::Reservation.load_reservations[0].included_rooms[0]).must_be_kind_of Integer
  end
end

describe 'it can find reservation data' do
  let(:finder) do
    find_date = "October 22 2019"
    Hotel::Reservation.find_reservations_by_date(find_date)
  end
  it 'given a date, can find a reservation' do
    expect((finder).length).must_equal 2
  end
  it 'returns an array of reservations on that date' do
    expect(finder).must_be_kind_of Array
  end
  it 'returns an array of reservation instances' do
    expect(finder[0]).must_be_kind_of Hotel::Reservation
  end
  it 'returns 0 if no reservations found on that day' do
    expect(Hotel::Reservation.find_reservations_by_date("May 4 2020")).must_equal 0
  end
  it 'can find a reservation given an id' do
    id = 1
    expect(Hotel::Reservation.find_a_reservation(id)).must_be_kind_of Hotel::Reservation
  end
  it 'raises an argument error if no reservation are found w/ that id' do
    id = 9999
    expect{ Hotel::Reservation.find_a_reservation(id) }.must_raise ArgumentError
  end
  it 'can get total cost given a reservation id' do
    id = 2 # 1 room, 1 night, baserate 200.00
    expect(Hotel::Reservation.get_reservation_total(id)).must_equal 1 * 1 * 200.00
    expect(Hotel::Reservation.get_reservation_total(id)).must_be_kind_of Float
  end
  it 'can find available rooms given a date' do
    find_date = "October 25 2019"
    expect(Hotel::Reservation.find_available_rooms(find_date)).be_kind_of Array
    expect((Hotel::Reservation.find_available_rooms(find_date)).length).must_equal 17
  end


end
