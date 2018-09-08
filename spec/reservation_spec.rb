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

end
