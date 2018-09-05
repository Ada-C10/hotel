require 'pry'
require_relative 'spec_helper'

describe "Admin class" do
  before do
    @admin_1 = Admin.new
  end

  describe "Initializer" do
    it "is an instance of Admin" do
      expect(@admin_1).must_be_kind_of Admin
    end

    it "establishes the base data structures when instantiated" do
      # binding.pry
      expect(@admin_1.reservations).must_be_kind_of Array
      expect(@admin_1.rooms).must_be_kind_of Array
    end
  end

  # describe "find_room method" do
  #   before do
  #     @admin = Admin.new(3)
  #   end
  #
  #   it "throws an argument error for a bad ID" do
  #     expect{ @admin.find_room(0) }.must_raise ArgumentError
  #   end
  #
  #   it "finds a room instance" do
  #     room_found = @admin.find_room(2)
  #     expect(passenger).must_be_kind_of Room
  #   end
  # end

end
