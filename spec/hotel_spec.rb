require_relative 'spec_helper'

describe "Hotel class creation" do
  it "returns hotel " do
    result = hotel()
    expect(result).must_equal "hotel"
  end
end
