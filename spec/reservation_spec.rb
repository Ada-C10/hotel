require_relative 'spec_helper'


#date structure enter: day, month, year for Date.Parse format

describe 'Reservation Class' do
  before do
    @start_date = Date.parse("5/9/2018")
    @end_date = Date.parse("10/9/2018")
    @reservation = Hotel::Reservation.new(@start_date, @end_date, 20)


  end

  it "calculates the total cost per reservation" do
    # reservation = @hotel.assigns_a_reservation(@start_date, @end_date)
    expect(@reservation.cost).must_equal 800
  end



  it "returns an error for invaild date range" do
    @end_date = Date.parse("5/9/2018")
    @start_date = Date.parse("10/9/2018")

    proc {
      Hotel::Reservation.new(@start_date, @end_date, 18)
    }.must_raise ArgumentError

  end





  it "calculates block room cost" do
    @hotel = Hotel::Hotel.new

    @hotel.block_rooms(@start_date, @end_date, 4, "Hopper")
    reservations = @hotel.reserve_block_room(1, "Hopper")

    expect(reservations[0].block_room_cost).must_equal 600.00

  end

end
