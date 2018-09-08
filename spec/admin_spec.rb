require 'pry'
require_relative 'spec_helper'

describe "Admin class" do
  before do
    @admin_1 = Admin.new
  end

  describe "Initializer" do
    it "is an instance of Admin" do
      expect(@admin_1).must_be_kind_of Admin
    end

    it "establishes the base data structures when instantiated" do
      expect(@admin_1.reservations).must_be_kind_of Array
      expect(@admin_1.rooms).must_be_kind_of Array
      expect(@admin_1.rooms.first).must_be_kind_of Room
    end
  end


  describe "make_reservation" do
    before do
      @start_date_1 = Date.new(2018,12,4)
      @end_date_1 = Date.new(2018,12,6)
      @res_1 = @admin_1.make_reservation(2,1,"Mike Murry",@start_date_1, @end_date_1)
      @count_1 = @admin_1.reservations.count
      @start_date_2 = Date.new(2018,12,5)
      @end_date_2 = Date.new(2018,12,7)
      @res_2 = @admin_1.make_reservation(3,2,"Julie Smith",@start_date_2, @end_date_2)
      @count_2 = @admin_1.reservations.count

    end

    it "will add a reservation object to reservation array" do
        expect(@admin_1.reservations).must_include @res_1
        expect(@count_2).must_equal @count_1 + 1
    end

    it "will return a reservation object " do
      expect(@res_1).must_be_kind_of Reservation
      expect(@res_2).must_be_kind_of Reservation
    end

    # it "will add the reserved dates to room.reserve_dates" do
    #   expect(@res_1.room.reserve_dates).must_include @start_date_1
    #   expect(@res_1.room.reserve_dates).must_not_include @end_date_1
    #   expect(@res_2.room.reserve_dates).must_include @start_date_2
    #   expect(@res_2.room.reserve_dates).must_not_include @end_date_2
    # end

    it "raise ArgumentError if start_date is not ealier than end_date" do
      start_date_3 = Date.new(2018,12,5)
      end_date_3 = Date.new(2018,12,3)
      expect{@admin_1.make_reservation(4,3,"Jessie lee",start_date_3,end_date_3)}.must_raise ArgumentError

    end

    it "raise ArgumentError if start_date is ealier than today" do
      start_date_3 = Date.new(2018,8,5)
      end_date_3 = Date.new(2018,12,3)
      expect{@admin_1.make_reservation(4,3,"Jessie lee",start_date_3,end_date_3)}.must_raise ArgumentError


    end

    # it "will return a message when no room is available for trip" do
    #
    #
    #   expect(@dispatcher.request_trip(6)).must_equal "No driver available at this time."
    # end
    #
    # it "will not create a reservation if no room is available" do
    #
    #
    #   expect(@dispatcher.trips.length).must_equal trip_count
    #
    # end

  end

  # # describe "list_reservations on a specific date" do
  #     before do
  #
  #
  #
  #     end
  #
  #     it "returns nil if no result being found" do
  #
  #     end
  #
  #     it "if result being found, must return an array of resrvations " do
  #
  #     end
  #
  #     if "must return the right list of reservations " do
  #
  #     end
  #
  #   end

  describe "find_room method" do

    it "throws an argument error for a bad ID" do
      expect{ @admin_1.find_room(0) }.must_raise ArgumentError
    end

    it "finds a room instance" do
      room_found = @admin_1.find_room(2)
      expect(room_found).must_be_kind_of Room
    end
  end

end
