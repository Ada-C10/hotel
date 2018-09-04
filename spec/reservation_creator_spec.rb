require_relative 'spec_helper'

describe "BookingSystem class" do
  before do
    list = Hotel::Reservation.new
  end

  it "rooms in hotel method" do
    expect(list.rooms_in_hotel).must_be_kind_of Array
    expect(list.rooms_in_hotel).must_equal [*"Room 1".."Room 20"]
  end
end
