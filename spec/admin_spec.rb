# Jacquelyn Cheng - Nodes

# Tests for admin.rb

require_relative 'spec_helper.rb'

describe "Admin" do
  before do
    @admin = Hotel::Admin.new
    @res1 = @admin.make_reservation("2019-01-01", "2019-01-04")
    @res2 = @admin.make_reservation("2019-01-01", "2019-01-02")
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

  describe "Admin#make_reservation" do
    it "returns a Reservation" do
      expect(@admin.make_reservation("2019-01-01")).must_be_instance_of Hotel::Reservation
    end

    it "assigns a room to the Reservation" do
      expect(@res1.room).must_be_instance_of Hotel::Room
    end

    it "updates the assigned room's availability" do
      expect(@admin.rooms[2].is_available?("2019-01-01")).must_equal true

      res3 = @admin.make_reservation("2019-01-01", "2019-01-03")
      expect(@admin.rooms[2].is_available?("2019-01-01")).must_equal false
    end
  end

  describe "Admin#list_reservations" do
    it "returns a list of reservations for a given date" do
      expect(@admin.list_reservations("2019-01-01").length).must_equal 2
      expect(@admin.list_reservations("2019-01-03").length).must_equal 1
    end
  end
end
