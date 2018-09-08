require_relative 'spec_helper'


#     #date structure enter: day, month, year for Date.Parse format

describe 'Reservation Class' do
  before do
    @hotel = Hotel::Hotel.new
    @start_date = Date.parse("5/9/2018")
    @end_date = Date.parse("10/9/2018")
  end

  it "raises an argument error for invalid dates" do
    #proc catches the error when .assigns_a_reservation is invoked
    proc {
      @hotel.assigns_a_reservation(@end_date, @start_date)
    }.must_raise ArgumentError
  end

  it "returns reservation list of all the current reservations" do

    @start_date = Date.parse("1/9/2018")
    @end_date = Date.parse("5/9/2018")


    @start_date1 = Date.parse("4/9/2018")
    @end_date1 = Date.parse("6/9/2018")


    reservation = @hotel.assigns_a_reservation(@start_date, @end_date)

    reservation1 = @hotel.assigns_a_reservation(@start_date1, @end_date1)
    expect(@hotel.reservations).must_be_kind_of Array

  end


  it "return a reservation for a specific date" do

    match_res = @hotel.assigns_a_reservation(@start_date, @end_date)

    @start_date1 = Date.parse("4/9/2018")
    @end_date1 = Date.parse("6/9/2018")

    nomatch_res = @hotel.assigns_a_reservation(@start_date1, @end_date1)

    reservations_fordate = @hotel.reservations_for_date(@start_date)

    expect(reservations_fordate).must_be_kind_of Array
    expect(reservations_fordate.length).must_equal 1
    expect(reservations_fordate.first).must_equal match_res

  end
  
  it "calculates the total cost per reservation" do

    reservation = @hotel.assigns_a_reservation(@start_date, @end_date)

    expect(reservation.reservation_cost).must_equal 800

  end

end




# describe 'Reservation Class' do
#   it 'returns an instance of reservation' do
#     reservation = Reservation.new("10/10/2010", "10/15/2010", 2)
#     expect(reservation).must_be_kind_of Reservation
#   end
# end
#
# describe 'Reservation' do
#   it 'must give me the right cost' do
#     reservation = Reservation.new("10/10/2010", "10/15/2010", 2)
#     reserve_cost =
#     #date structure enter: day, month, year for Date.Parse format
#     reservation.cost("10/10/2010", "15/10/2010")
#     expect(reserve_cost).must_equal 800
#   end

# end
