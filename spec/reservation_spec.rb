require_relative 'spec_helper'




describe 'Reservation Class' do
  before do
    @hotel = Hotel::Hotel.new
    @start_date = Date.parse("5/9/2018")
    @end_date = Date.parse("1/9/2018")
  end

  it "raises an argument error for invalid dates" do
    # reservation = @hotel.assigns_a_reservation(@start_date, @end_date)
    proc {@hotel.assigns_a_reservation(@start_date, @end_date)}.must_raise ArgumentError

    
    # expect().must_raise ArgumentError
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
