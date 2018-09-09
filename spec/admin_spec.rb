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
      expect(@admin_1.room_unbooked_dates).must_be_kind_of Array
      expect(@admin_1.rooms.first).must_be_kind_of Room
      expect(@admin_1.room_unbooked_dates.length).must_equal 7300
      expect(@admin_1.room_unbooked_dates.first[:unbooked_date]).must_equal Date.today
    end
  end


  describe "make_reservation" do
    before do
      @start_date_1 = Date.new(2018,12,4)
      @end_date_1 = Date.new(2018,12,6)
      @res_1 = @admin_1.make_reservation(1,"Mike Murry",@start_date_1, @end_date_1)
      @count_1 = @admin_1.reservations.count
      @start_date_2 = Date.new(2018,12,5)
      @end_date_2 = Date.new(2018,12,7)
      @res_2 = @admin_1.make_reservation(2,"Julie Smith",@start_date_2, @end_date_2)
      @count_2 = @admin_1.reservations.count

      20.times do |i|
        @admin_1.make_reservation(@count_2 + i + 1, "Lily Xia", Date.new(2018,9,25), Date.new(2018,9,27))
      end
    end

    it "will add a reservation object to reservation array" do
        expect(@admin_1.reservations).must_include @res_1
        expect(@count_2).must_equal @count_1 + 1
    end

    it "will return a reservation object " do
      expect(@res_1).must_be_kind_of Reservation
      expect(@res_2).must_be_kind_of Reservation
    end

    it "will reduce the room_unbooked_dates array correctly" do
      room_1 = @admin_1.find_room(1)
      # room_2 = @admin_1.find_room(2)
      result = false
      selected = @admin_1.room_unbooked_dates.select {|a, b| a == room_1 && b == @start_date_1}
      if selected == []
        result = true
      end

      result_2 = false
      selected_2 = @admin_1.room_unbooked_dates.select {|a, b| a == room_1 && b == @end_date_1}
      if selected_2 == []
        result = true
      end
      expect(result).must_equal true
      expect(result_2).must_equal false
      expect(@admin_1.room_unbooked_dates.length).must_equal 7256

    end

    it "raise ArgumentError if start_date is not ealier than end_date" do
      start_date_3 = Date.new(2018,12,5)
      end_date_3 = Date.new(2018,12,3)
      expect{@admin_1.make_reservation(23,"Jessica lee", start_date_3,end_date_3)}.must_raise ArgumentError

    end

    it "raise ArgumentError if start_date is ealier than today" do
      start_date_3 = Date.new(2018,8,5)
      end_date_3 = Date.new(2018,12,3)
      expect{@admin_1.make_reservation(23,"Jessca lee",start_date_3,end_date_3)}.must_raise ArgumentError

    end

    it "will return a message when no room is available for trip" do

      expect(@admin_1.make_reservation(23,"Jessica lee",Date.new(2018,9,25),Date.new(2018,9,26))).must_equal "No room available at this time."
    end

    it "will not create a reservation if no room is available" do

      expect(@admin_1.reservations.length).must_equal 22

    end

  end

  describe "list_reservations on a specific date" do
    before do
      @start_date_1 = Date.new(2018,12,4)
      @end_date_1 = Date.new(2018,12,6)
      @res_1 = @admin_1.make_reservation(2,"Mike Murry",@start_date_1, @end_date_1)
      @count_1 = @admin_1.reservations.count
      @start_date_2 = Date.new(2018,12,5)
      @end_date_2 = Date.new(2018,12,7)
      @res_2 = @admin_1.make_reservation(3,"Julie Smith",@start_date_2, @end_date_2)
      @count_2 = @admin_1.reservations.count

    end

    it "returns nil if no result being found" do
       expect(@admin_1.list_reservations(Date.new(2018,12,10))).must_equal []
    end

    it "if result being found, must return an array of resrvations " do
       expect(@admin_1.list_reservations(Date.new(2018,12,5))).must_include @res_1
       expect(@admin_1.list_reservations(Date.new(2018,12,5))).must_include @res_2
    end

    it "must return the right list of reservations " do
       expect(@admin_1.list_reservations(Date.new(2018,12,5)).length).must_equal 2
    end
  end

  describe "find_room method" do

    it "throws an argument error for a bad ID" do
      expect{ @admin_1.find_room(0) }.must_raise ArgumentError
    end

    it "finds a room instance" do
      room_found = @admin_1.find_room(2)
      expect(room_found).must_be_kind_of Room
    end
  end

  describe "find_reservation method" do
    before do
      @start_date_1 = Date.new(2018,12,4)
      @end_date_1 = Date.new(2018,12,6)
      @res_1 = @admin_1.make_reservation(2,"Mike Murry",@start_date_1, @end_date_1)
      @count_1 = @admin_1.reservations.count
      @start_date_2 = Date.new(2018,12,5)
      @end_date_2 = Date.new(2018,12,7)
      @res_2 = @admin_1.make_reservation(3,"Julie Smith",@start_date_2, @end_date_2)
      @count_2 = @admin_1.reservations.count

    end

    it "throws an argument error for a bad ID" do
      expect{ @admin_1.find_reservation(0) }.must_raise ArgumentError

    end

    it "finds a reservation instance" do
      reserve_found = @admin_1.find_reservation(2)
      # binding.pry
      expect(reserve_found).must_be_kind_of Reservation
      expect(reserve_found).must_equal @res_1
    end
  end

  describe "calculate_cost" do
    before do
      @start_date_1 = Date.new(2018,12,4)
      @end_date_1 = Date.new(2018,12,6)
      @res_1 = @admin_1.make_reservation(2,"Mike Murry",@start_date_1, @end_date_1)
      @count_1 = @admin_1.reservations.count
      @start_date_2 = Date.new(2018,12,5)
      @end_date_2 = Date.new(2018,12,7)
      @res_2 = @admin_1.make_reservation(3,"Julie Smith",@start_date_2, @end_date_2)
      @count_2 = @admin_1.reservations.count

    end

    it "returns the right number" do
      cost = @admin_1.calculate_cost(2)
      expect(cost).must_equal 400
    end
  end

  describe "find room availabe " do
    before do
      @start_date_1 = Date.new(2018,12,4)
      @end_date_1 = Date.new(2018,12,6)
      @res_1 = @admin_1.make_reservation(2,"Mike Murry",@start_date_1, @end_date_1)

      @start_date_2 = Date.new(2018,12,5)
      @end_date_2 = Date.new(2018,12,7)
      @res_2 = @admin_1.make_reservation(3,"Julie Smith",@start_date_2, @end_date_2)

    end

    it "returns an array of rooms" do
      room_list_1 = @admin_1.find_room_available(Date.new(2018,12,4),Date.new(2018,12,5))

      expect(room_list_1).must_be_kind_of Array
      expect(room_list_1.first).must_be_kind_of Room
    end

    it "returns the right number of rooms " do
      room_book = @admin_1.find_room(3)
      expect(@admin_1.find_room_available(Date.new(2018,12,4),Date.new(2018,12,5)).length).must_equal 18
      expect(@admin_1.find_room_available(Date.new(2018,12,4),Date.new(2018,12,5))).must_include room_book

    end

    it " will not include a room already booked on that day" do
      room_first = @admin_1.find_room(1)
      room_selected = @admin_1.find_room_available(Date.new(2018,12,4), Date.new(2018,12,5))

      expect(room_selected.include? room_first).must_equal false
    end


  end
end
