require_relative 'spec_helper'

describe "Reservation class" do
  describe "initialize method" do
    before do
      @manager = Hotel::BookingManager.new(1)
      @room = @manager.rooms.first
      @new_booking = Hotel::Reservation.new(@room, guest_name: "Tina Fey", start_date: "June 4", end_date: "June 7")
    end

    it "creates a new instance of Reservation" do
      expect(@new_booking).must_be_instance_of Hotel::Reservation
    end # of new reservation is new instance it

  end # of initialize method



end # of class Reservation
