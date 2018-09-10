require 'pry'
require_relative 'spec_helper'

describe "Admin class" do
  before do
    list = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @admin_1 = Admin.new(list, Date.today, (Date.today + 365))
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
      expect(@admin_1.room_blocks).must_equal []
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

    it "will raise ArgumentError when no room is available for trip" do

      expect{@admin_1.make_reservation(23,"Jessica lee",Date.new(2018,9,25),Date.new(2018,9,26))}.must_raise ArgumentError
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
      expect(@admin_1.find_room_available(Date.new(2018,12,4),Date.new(2018,12,5)).length).must_equal 19
      expect(@admin_1.find_room_available(Date.new(2018,12,4),Date.new(2018,12,5))).must_include room_book

    end

    it " will not include a room already booked on that day" do
      room_first = @admin_1.find_room(1)
      room_selected = @admin_1.find_room_available(Date.new(2018,12,4), Date.new(2018,12,5))

      expect(room_selected.include? room_first).must_equal false
    end
  end

  describe "create_room_block" do
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

      @name_of_block = "tech_forum"
      @list_3 = [10,11,12,13,14]
      @list_6 = [10,11,12,13,14,15]
      @start_3 = Date.new(2018,12,1)
      @end_3 = Date.new(2018,12,11)
      @discount = 0.1
    end

    it "returns a new object of BlockAdmin " do
      expect(@admin_1.create_room_block("block1",@list_3, @start_3, @end_3, @discount)).must_be_kind_of Block
    end

    it "increase the length of room_blocks array be 1" do
      @admin_1.create_room_block("block1",@list_3, @start_3, @end_3, @discount)
      expect(@admin_1.room_blocks.length).must_equal 1
    end

    it "remove the related rooms from the room_unbooked_dates array in the specified date " do
      @admin_1.create_room_block("block1",@list_3, @start_3, @end_3, @discount)
      expect(@admin_1.room_unbooked_dates.length).must_equal 7206
    end

    it "raise ArgumentError if room_id_list has more than 5 elements" do
      expect{@admin_1.create_room_block("block1",@list_6, @start_3, @end_3, @discount)}.must_raise ArgumentError
    end

    it "raise ArgumentError if room specified was not available in that period" do
      expect{@admin_1.create_room_block("block1",[1,2], Date.new(2018,9,25), Date.new(2018,9,27),@discount)}.must_raise ArgumentError
    end

    it "raise ArgumentError if the period requested for set up room block is outside of the current working period )" do
      expect{@admin_1.create_room_block("block1",[1,2], Date.new(2019,10,25), Date.new(2019,10,27),0.1)}.must_raise ArgumentError
    end

    it "raise ArgumentError if the discount_rate is < 0 or > 1" do
      expect{@admin_1.create_room_block("block1",[1,2], Date.new(2018,11,2), Date.new(2018,11,5),1.1)}.must_raise ArgumentError
    end
  end
end
