require_relative 'spec_helper'

describe "BookingSystem Class" do
  describe "initializer" do
    it "is an instance of BookingSystem" do
      frontdesk = Hotel::BookingSystem.new()
      expect(frontdesk).must_be_kind_of Hotel::BookingSystem
    end
  end
end
