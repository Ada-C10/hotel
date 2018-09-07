require_relative 'spec_helper'

describe "Calendar" do
  let (:check_in) {
    "2018-12-01"
  }
  let (:check_out) {
    "2019-01-15"
  }
  let (:my_hotel) {
    Hotel::HotelManager.new
  }
  let (:list) {
    Hotel::Calendar.available_rooms(my_hotel.rooms, check_in, check_out)
  }

  describe "available_rooms" do
    it "Returns the correct number of rooms as an array" do
      expect(list.length).must_equal 16
      expect(list).must_be_kind_of Array
    end

    it "Returns nil if no rooms can be found" do
      my_hotel.rooms.length.times do |i|
        Hotel::Room.change_status_of_room(my_hotel.rooms, i+1, check_in, check_out)
      end

      new_list = Hotel::Calendar.available_rooms(my_hotel.rooms, check_in, check_out)
      expect(list).must_be_nil
    end
  end
end
