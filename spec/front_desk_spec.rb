require_relative 'spec_helper'
require 'pry'
require 'date'

describe "FrontDesk class" do

  describe "create all rooms" do
    before do
      @front_desk = FrontDesk.new
      @rooms = @front_desk.load_rooms
    end
    it "creates an array of 20 rooms " do
      expect(@rooms.length).must_equal 20
    end
    it "the ID of the first room is 1" do
      expect(@rooms.first.room_number).must_equal 1
    end
    it "the ID of the last room is 20" do
      expect(@rooms.last.room_number).must_equal 20
    end
  end


  describe "list of all rooms method" do
    before do
      @front_desk = FrontDesk.new
    end
    it "Returns a list of all rooms in hotel" do
      expect(@front_desk.list_all_rooms.length).must_equal 20
      (@front_desk.list_all_rooms).each do |room|
        expect(room).must_be_kind_of Room
      end
    end
  end


describe "create reservation" do
  before do
    @my_front_desk = FrontDesk.new
    @my_front_desk.create_reservation(9,"2013-10-10","2013-10-13")
  end
  it "returns an instance of reservation and adds to reservation list" do
    expect(@my_front_desk.reservations[0]).must_be_instance_of Reservation
    expect(@my_front_desk.reservations.length).must_equal 1
  end
end

describe 'find reservations by date' do
  before do
    @front_desk = FrontDesk.new
    @front_desk.create_reservation(3, "2012-4-12", "2012-4-22")
    @front_desk.create_reservation(4, "2012-4-12", "2012-4-22")
    @front_desk.create_reservation(5, "2012-4-23", "2012-4-29")
    @front_desk.create_reservation(6, "2012-4-25", "2012-4-28")
  end
  it "returns reservations for a specific date date" do
    expect(@front_desk.find_by_date("2012-4-12").length).must_equal 2
end
end




end
