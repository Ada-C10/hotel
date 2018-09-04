# Jacquelyn Cheng - Nodes

# Tests for admin.rb

require_relative 'spec_helper.rb'

describe "Admin" do
  before do
    @admin = Hotel::Admin.new
  end

  describe "Admin#initialize" do
    it "instantiates a hotel admin" do
      expect(@admin).must_be_instance_of Hotel::Admin
    end

    it "has a list of 20 Room objects" do
      expect(@admin.rooms.length).must_equal 20
      expect(@admin.rooms.first).must_be_instance_of Hotel::Room
      expect(@admin.rooms.last).must_be_instance_of Hotel::Room
    end

  end

  describe "Admin#list_reservations" do
    before do
      @admin.make_reservation("2019-01-01", "2019-01-04")
      @admin.make_reservation("2019-01-01", "2019-01-02")
    end
    it "returns a list of reservations for a given date" do
      expect(@admin.list_reservations("2019-01-01").length).must_equal 2
      expect(@admin.list_reservations("2019-01-03").length).must_equal 1
    end
  end
end
