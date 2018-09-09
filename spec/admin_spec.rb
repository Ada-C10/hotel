require_relative 'spec_helper'

# describe "Wave 1 + 2 + 3" do
#   before do
#     test = Admin.new
#   end

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

  describe "Checks if blocked room is booked" do
    it "Confirms a room from blocked rooms is booked" do
      test = Admin.new
      check = test.block_rooms(3, "2018-10-01", "2018-10-15")
      new = test.book_blocked_room

      expect(new.length).must_equal 2
    end
  end

#end



# describe "Checks that array of rooms contains all rooms" do
#   describe "Checks rooms array " do
#     it "Checks length of array containing rooms" do
#       admin1 = Admin.new
#       list = admin1.view_all_rooms
#
#       expect(list.length).must_equal 20
#     end
#   end
# end
