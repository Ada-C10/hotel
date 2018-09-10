require_relative 'spec_helper'
require 'date'


describe 'Reservation' do
  # before do
  #   rs1 = Hotel::Reservation.new(102, "Sam Pull", [2], "January 1, 2019", "January 10, 2019", 1800.00 )
  #   rs2 = Hotel::Reservation.new(103, "Bulldog Betty", [19], "October 22, 2019", "October 25, 2019", 600.00 )
  #   rs3 = Hotel::Reservation.new(104, "Dolly Raj", [4, 7, 8], "May 12, 2019", "May 13, 2019", 600.00 )
  # end

  it 'instantiates a reservation' do
    new_res = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                     included_rooms: [1, 3, 4],
                                     rsv_start: "March 3, 2019",
                                     rsv_end: "March 5, 2019")
    expect(new_res).must_be_kind_of Hotel::Reservation
    expect(new_res.id).must_be_kind_of Integer
    expect(new_res.rsv_start).must_be_kind_of Date
    expect(new_res.rsv_end).must_be_kind_of Date
    expect(new_res.status).must_be_kind_of Symbol
    expect(new_res.total_cost).must_be_kind_of Float
    expect(new_res.total_cost).must_be :>, 0
  end

  it 'correctly tallies up the total cost' do
    new_res = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                     included_rooms: [1, 3, 4],
                                     rsv_start: "March 3, 2019",
                                     rsv_end: "March 5, 2019")
    # total cost = 3 rooms x 2 nights x $200.00
    expect(new_res.total_cost).must_be_close_to (3 * 2 * 200)
  end

  it 'raises an error if end date is before start date' do
    expect {
      rs1 = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                   included_rooms: [1, 3, 4],
                                   rsv_start: "March 3, 2019",
                                   rsv_end: "March 1, 2019")
    }.must_raise ArgumentError
  end

  it 'raises an error if start or end data are not provided' do
    expect {
      rs2 = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                   included_rooms: [1, 3, 4],
                                   rsv_start: '',
                                   rsv_end: "March 5, 2019")
    }.must_raise ArgumentError

    expect {
      rs2 = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                   included_rooms: [1, 3, 4],
                                   rsv_start: "March 5, 2019",
                                   rsv_end: '')
    }.must_raise ArgumentError
  end

  it 'raises an error if start or end data are not dates' do
    expect {
      rs3 = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                   included_rooms: [1, 3, 4],
                                   rsv_start: "bad data",
                                   rsv_end: "March 5, 2019")
    }.must_raise ArgumentError

    expect {
      rs3 = Hotel::Reservation.new(id: 110, guest_name: "Coco deVille",
                                   included_rooms: [1, 3, 4],
                                   rsv_start: "March 5, 2019",
                                   rsv_end: "bad data")
    }.must_raise ArgumentError
  end

  it 'raises an error if no rooms are included in the booking' do
    expect {
      rs4 = Hotel::Reservation.new(id: 104, guest_name: "Dolly Raj",
                                   included_rooms: [],
                                   rsv_start: "May 12, 2019",
                                   rsv_end: "May 14, 2019")
    }.must_raise ArgumentError
  end

  it 'raises an error if no guest name is included in the booking' do
    expect {
      rs5 = Hotel::Reservation.new(id: 104, guest_name: "",
                                   included_rooms: [],
                                   rsv_start: "May 12, 2019",
                                   rsv_end: "May 14, 2019")
    }.must_raise ArgumentError
    expect {
      rs6 = Hotel::Reservation.new(id: 104, guest_name: nil,
                                   included_rooms: [],
                                   rsv_start: "May 12, 2019",
                                   rsv_end: "May 14, 2019")
    }.must_raise ArgumentError
  end
end


