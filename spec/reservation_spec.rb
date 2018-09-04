require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require_relative '../lib/Reservation'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "Reservation" do
  it "can create a new instance of hotel" do
    name = "Hotel California"
    hotel = Hotel.new(name)

    expect(hotel.name).must_equal name
  end
end
