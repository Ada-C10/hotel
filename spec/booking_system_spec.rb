require_relative 'spec_helper'

describe "BookingSystem class" do
  before do
    @booking = Hotel::BookingSystem.new(180904)
  end

  it "initialize method" do
    expect(@booking).must_be_kind_of Hotel::BookingSystem
  end

  it "returns array of all room numbers in hotel" do
    expect(@booking.rooms_in_hotel).must_be_kind_of Array
    expect(@booking.rooms_in_hotel).must_equal [*1..20]
  end
end
