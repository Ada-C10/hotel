require_relative 'spec_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel.rb'


describe "Reservation Class" do
  describe "initializer" do
    before do
      room = Room.new(2)
      @reservation = Reservation.new(2018923, 2018926, room)
    end

    it "returns an instance of Reservation" do
      expect(@reservation).must_be_kind_of Reservation
    end

    it "raises error when given invalid dates" do
      room = Room.new(2)
      expect {(Reservation.new(2018926, 2018923, room))}.must_raise ArgumentError
    end

    it "calculates the reservation cost correctly" do
      expect(@reservation.cost).must_equal 600
    end

  end
  # TODO: Test for nights and during? methods

end
