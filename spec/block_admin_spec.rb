require 'pry'
require_relative 'spec_helper'

describe "Block Admin class" do

  before do
    list = [6,7,8,9,10]
    @admin_b = BlockAdmin.new(list, Date.new(2018,10,5), Date.new(2018,10,12),0.80)
  end

  describe "Initializer" do
    it "is an instance of BlockAdmin" do
      expect(@admin_b).must_be_kind_of BlockAdmin
    end

    it "establishes the base data structures when instantiated" do
      expect(@admin_b.discount).must_equal 0.80
    end

  end
end
