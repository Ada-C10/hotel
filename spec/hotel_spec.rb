require_relative 'spec_helper'
require 'pry'

describe "if the puts my name method works" do

  it "say_my_name will say Carly" do
    name = 'Carly'
    name = Name.new("Carly")
    expect(name.say_my_name).must_equal "Carly"
  end

end
