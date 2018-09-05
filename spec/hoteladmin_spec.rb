require_relative 'spec_helper'

describe "HotelAdmin" do
  let (:hotel) {
     HotelAdmin.new
  }
  describe "Hotel#Initialize" do
    it "can create a hoteladmin object" do
      expect(hotel).must_be_instance_of HotelAdmin
    end

    it "initializes with readable rooms and reservations array attributes" do
      expect(hotel.rooms).must_be_instance_of Array
      expect(hotel.reservations).must_be_instance_of Array
      expect(hotel.rooms).must_be_empty
      expect(hotel.reservations).must_be_empty
    end

    # it "initializes with readable rooms and reservations array attributes" do
    #
    # end


  end

end
