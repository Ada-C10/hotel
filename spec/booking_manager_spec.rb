require_relative 'spec_helper'

describe BookingManager do
  before do
  end
  describe "#initialize" do
    it "can be instantiated" do
      expect(BookingManager.new).must_be_kind_of BookingManager
    end
  end
end
