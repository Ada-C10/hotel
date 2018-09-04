# Jacquelyn Cheng - Nodes

# Tests for admin.rb

require_relative 'spec_helper.rb'

describe "Admin" do
  it "test" do
    assert(Hotel::Admin.test).must_equal 0
  end
end
