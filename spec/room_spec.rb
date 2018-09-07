require_relative 'spec_helper'

describe "Room" do
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:check_in) {
    "2018-10-07"
  }
  let (:check_out) {
    "2018-10-16"
  }
  let(:id) {
    1337
  }

  describe "#initialize" do
    it "Creates an instance of room" do
      room = Hotel::Room.new(id)

      expect(room).must_be_kind_of Hotel::Room
    end

    it "Keeps track of ID" do
      room = Hotel::Room.new(id)

      expect(room).must_respond_to :id
      expect(room.id).must_equal id
    end

    it "Keeps track of Availability Status by Date in a hash" do
      room = Hotel::Room.new(id)

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
      room = Hotel::Room.new(id)
      my_hotel.rooms << room
      Hotel::Room.change_status_of_room(my_hotel.rooms, id, check_in, check_out)

      expect(room.status_by_date[Date.parse(check_in) - 1]).must_equal :AVAILABLE
      expect(room.status_by_date[Date.parse(check_in)]).must_equal :UNAVAILABLE
      expect(room.status_by_date[Date.parse(check_out) - 1]).must_equal :UNAVAILABLE
      expect(room.status_by_date[Date.parse(check_out)]).must_equal :AVAILABLE
    end
  end

  describe "is_available?" do
    before do
      @room = Hotel::Room.new(id)
      my_hotel.rooms << @room
    end

    it "Returns true if room is available" do
      availability = Hotel::Room.is_available?(my_hotel.rooms, id, check_in, check_out)
      expect(availability).must_equal true
    end

    it "Returns false if room is unavailable" do
      Hotel::Room.change_status_of_room(my_hotel.rooms, id, check_in, check_out)
      availability = Hotel::Room.is_available?(my_hotel.rooms, id, check_in, check_out)

      expect(availability).must_equal false
    end
  end
end
