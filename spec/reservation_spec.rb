require_relative 'spec_helper'


#date structure enter: day, month, year for Date.Parse format

describe 'Reservation Class' do
  before do
    @hotel = Hotel::Hotel.new
    @start_date = Date.parse("5/9/2018")
    @end_date = Date.parse("10/9/2018")


  end

  it "calculates the total cost per reservation" do
    reservation = @hotel.assigns_a_reservation(@start_date, @end_date)
    expect(reservation.reservation_cost).must_equal 800
  end


  #moved to this spec as the method contains? is in reservations 
  it "return a reservation for a specific date" do

    match_res = @hotel.assigns_a_reservation(@start_date, @end_date)

    @start_date1 = Date.parse("4/9/2018")
    @end_date1 = Date.parse("6/9/2018")

    reservation2 = @hotel.assigns_a_reservation(@start_date1, @end_date1)

    reservations_fordate = match_res.contains?(@start_date)

    expect(reservations_fordate).must_be_kind_of Array
    expect(reservations_fordate.length).must_equal 1
    expect(reservations_fordate.first).must_equal match_res

  end





  it "calculates block room cost" do
    @hotel.block_rooms(@start_date, @end_date, 4, "Hopper")
    reservations = @hotel.reserve_block_room(1, "Hopper")

    expect(reservations[0].block_room_cost).must_equal 600.00

  end

end
