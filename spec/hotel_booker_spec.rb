require 'pry'
require_relative 'spec_helper'

describe "hotel initation" do

  it "fails this test" do
    expect(Hotel::HotelBooker.new).must_be_instance_of Hotel::HotelBooker
  end

end
