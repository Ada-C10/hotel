require 'pry'
require_relative 'spec_helper'

describe "Block Admin class" do

  before do
    list = [6,7,8,9]
    @admin_b = Block.new("block1",list, Date.new(2018,10,5), Date.new(2018,10,10),0.10)

  end

  describe "Initializer" do
    it "is an instance of BlockAdmin" do
      expect(@admin_b).must_be_kind_of Block
    end

    it "establishes the base data structures when instantiated" do
      expect(@admin_b.discount).must_equal 0.10
    end
  end

  describe "make_reservation" do
    it "will only allow to the period same as the block set up period" do
    @admin_b.make_reservation("Mike lee")
    expect(@admin_b.reservations.first.start_date).must_equal Date.new(2018,10,5)
    expect(@admin_b.reservations.first.end_date).must_equal Date.new(2018,10,10)
    end
  end

  describe "calculate_cost" do

    it "returns a right number" do
      @admin_b.make_reservation("Mike lee")
      res_id = @admin_b.reservations.first.id

      expect(@admin_b.calculate_cost(res_id)).must_equal 900.0
    end
  end
end
