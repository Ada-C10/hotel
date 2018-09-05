require_relative 'spec_helper'

describe Calendar do
  describe "#initalize" do
    it "can be instantiated" do
      calendar = Calendar.new
      expect(calendar).must_be_kind_of Calendar
    end
  end
end
