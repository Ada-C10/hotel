require_relative 'spec_helper'


describe "HotelBooker class" do


  describe "HotelBooker initation" do
    let(:booker) {Hotel::HotelBooker.new}

    it "Returns an instance of HotelBooker" do
      expect(booker).must_be_kind_of Hotel::HotelBooker
    end

    it "Establishes the base data structures when instantiated" do
      [:rooms, :reservations, :booked_dates].each do |prop|
        expect(booker).must_respond_to prop
      end

      expect(booker.rooms).must_be_kind_of Array
      expect(booker.reservations).must_be_kind_of Array
      expect(booker.booked_dates).must_be_kind_of Array
    end

    it "Loads 20 Rooms" do
      expect(booker.rooms.length).must_equal 20
      20.times do |i|
        expect(booker.rooms[i]).must_be_kind_of Hotel::Room
      end
    end
  end

  describe "Make a reservation method" do

    before do
      @booker = Hotel::HotelBooker.new
      @booker.make_reservation(1, '2018-09-05', '2018-09-09')
    end

    it "Adds a Reservation to the list of reservations" do

      expect(@booker.reservations.length).must_equal 1
      expect(@booker.reservations[0]).must_be_kind_of Hotel::Reservation
    end

    it "Adds a Reservation which contains an instance of Room" do

      expect(@booker.reservations[0].room).must_be_kind_of Hotel::Room
    end

  end

end
