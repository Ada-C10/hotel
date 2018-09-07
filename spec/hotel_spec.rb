require_relative 'spec_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'

describe "Hotel" do
  it "returns an instance of Hotel" do
    new_room = Room.new
    expect(new_room).must_be_kind_of Hotel
  end

end
