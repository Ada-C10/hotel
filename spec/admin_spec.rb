require_relative 'spec_helper'

describe "Wave 1" do

  describe "#initialize" do
    it "Initializes a class variable that stores an empty string" do
      test = Admin.new

      expect(test).must_respond_to :blocked_start_date
      expect(test.blocked_start_date).must_be_nil

      expect(test).must_respond_to :blocked_end_date
      expect(test.blocked_start_date).must_be_nil
    end
  end

  describe "block rooms" do
    it "Returns an array of blocked rooms" do
        test = Admin.new
        check = test.block_rooms(3, "2018-10-01", "2018-10-15")

        expect(check.length).must_equal 3
    end
  end
end
