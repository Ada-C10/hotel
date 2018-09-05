require_relative 'spec_helper'
require 'pry'

describe "Reservation class" do
  before do
    start_date = Date.today
    end_date = Date.today + 5

    @reservation_data = {
      id: 8,
      room: Hotel::Room.new(
        room_number: 1
      ),
      start_date: start_date,
      end_date: end_date
    }

    @reservation = Hotel::Reservation.new(@reservation_data)
  end

  describe "initialize" do
    it "is an instance of Reservation" do
      expect(@reservation).must_be_kind_of Hotel::Reservation
    end

    it "stores an instance of room" do
      expect(@reservation.room).must_be_kind_of Hotel::Room
    end

    it "raises an error if end date precedes start date" do
      start_date = Date.today
      end_date = start_date - 5

      reservation_data = {
        id: 8,
        room: Hotel::Room.new(
          room_number: 1
        ),
        start_date: start_date,
        end_date: end_date
      }

      expect {
        reservation = Hotel::Reservation.new(reservation_data)
      }.must_raise ArgumentError
    end
  end
end
