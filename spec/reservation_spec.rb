require_relative 'spec_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
# Require_relative your lib files here!

describe "Reservation" do
  it "returns an instance of Reservation" do
    new_room = Reservation.new
    expect(new_room).must_be_kind_of Reservation
  end

end
