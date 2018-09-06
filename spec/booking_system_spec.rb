require_relative 'spec_helper'

describe "BookingSystem class" do
  it "initialize method" do
    booking = Hotel::BookingSystem.new(180904)

    expect(booking).must_be_kind_of Hotel::BookingSystem
  end
end
