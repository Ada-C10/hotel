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
end
