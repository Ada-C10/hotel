require_relative 'spec_helper'

describe "new class" do
  it "sum method" do
    num1 = 1
    num2 = 1

    sum = Sum.new(num1, num2).sum

    expect(sum).must_equal 2
  end
end
