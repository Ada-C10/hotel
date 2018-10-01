require_relative 'spec_helper'

describe "Room" do
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:start_date) {
    "2018-10-07"
  }
  let (:end_date) {
    "2018-10-16"
  }
  let(:id) {
    1337
  }
  let(:room) {
    Hotel::Room.new(id)
  }

  describe "#initialize" do
    it "Creates an instance of room" do
      expect(room).must_be_kind_of Hotel::Room
    end

    it "Keeps track of ID" do
      expect(room).must_respond_to :id
      expect(room.id).must_equal id
    end

    it "Keeps track of Availability Status by Date in a hash" do
      expect(room).must_respond_to :status_by_date
      expect(room.status_by_date).must_be_kind_of Hash

      room.status_by_date.each do |date, status|
        expect(date).must_be_kind_of Date
        expect(status).must_be_kind_of Symbol
      end
    end
  end

  describe "change_status_of_room" do
    it "Changes the status of a room from available to unavailable" do
      my_hotel.rooms << room

      room.change_status_of_room(my_hotel.rooms, id, start_date: start_date, end_date: end_date)

      expect(room.status_by_date[Date.parse(start_date) - 1]).must_equal :AVAILABLE
      expect(room.status_by_date[Date.parse(start_date)]).must_equal :UNAVAILABLE
      expect(room.status_by_date[Date.parse(end_date) - 1]).must_equal :UNAVAILABLE
      expect(room.status_by_date[Date.parse(end_date)]).must_equal :AVAILABLE
    end
  end

  describe "all_available_rooms" do
    before do
      @start_date = "2018-12-01"
      @end_date = "2019-01-15"
      @list = Hotel::Room.all_available_rooms(my_hotel.rooms, start_date: @start_date, end_date: @end_date)
    end

    it "Returns the correct number of rooms as an array" do
      expect(@list.length).must_equal 13
      expect(@list).must_be_kind_of Array
    end

    it "Returns nil if no rooms can be found" do
      my_hotel.rooms.length.times do |i|
        room = Hotel::Room.find_room(my_hotel.rooms, i+1)
        room.change_status_of_room(my_hotel.rooms, i+1, start_date: @start_date, end_date: @end_date)
      end

      expect{
        Hotel::Room.all_available_rooms(my_hotel.rooms, start_date: @start_date, end_date: @end_date)
      }.must_raise ArgumentError
    end
  end
end
