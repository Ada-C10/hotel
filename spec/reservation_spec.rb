require_relative 'spec_helper.rb'

describe "#initialize" do
  # Test to make sure it takes correct parameters
  it 'Takes in a room number and availability status' do
    room = Room.new(5)
    start_date = Date.new(2001, 1, 1)
    end_date = Date.new(2001, 1, 7)

    test_res = Reservation.new(room, start_date, end_date)


    expect(test_res).must_respond_to :room
    expect(test_res.room).must_equal room

    expect(test_res).must_respond_to :start_date
    expect(test_res.start_date).must_equal start_date

    expect(test_res).must_respond_to :end_date
    expect(test_res.end_date).must_equal end_date
  end
end

 
