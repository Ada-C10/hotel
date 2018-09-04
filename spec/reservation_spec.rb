# Jacquelyn Cheng - Nodes

# Tests for reservation.rb

require_relative 'spec_helper.rb'

describe "Reservation" do
  it "test" do
    assert(Hotel::Reservation.test).must_equal 0
  end
end
