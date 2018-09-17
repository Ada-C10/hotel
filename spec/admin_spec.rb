require_relative 'spec_helper'

describe "#initialize" do
  it "Initializes a class variable that stores an empty string" do
    test = Admin.new

    expect(test).must_respond_to :blocked_start_date
    expect(test.blocked_start_date).must_be_nil

    expect(test).must_respond_to :blocked_end_date
    expect(test.blocked_start_date).must_be_nil
  end
 end

describe "block rooms" do

  it "Returns an array of blocked rooms" do
    test = Admin.new
    check = test.block_rooms(3, "2018-10-01", "2018-10-15")

      expect(check.length).must_equal 3
  end
end

describe "Checks if blocked room is booked" do
  it "Confirms a room from blocked rooms is booked" do
    test = Admin.new
    check = test.block_rooms(3, "2018-10-01", "2018-10-15")
    new = test.book_blocked_room

    expect(new.length).must_equal 2
  end
end

describe "Checks rooms array " do
  it "Checks length of array containing rooms" do
    test = Admin.new
    list = test.view_all_rooms

    expect(list.length).must_equal 20
  end
end

describe "Prints cost per reservation" do
  it "Checks the total cost for a reservation" do
    person = Admin.new
    person.reserve(3, "2018-11-01", "2018-11-15")
    pay = person.print_total_cost_per_reservation

    expect(pay).must_equal 2600
  end
end

describe "Checks availability of room according to dates" do
  it "Checks room availability" do
    guy = Admin.new
    answer = guy.check_availability("2018-09-01", "2018-09-11")

    expect(answer.length).must_be :>, 19
  end
end

describe "Checks rooms reserved for a certain date" do
  it "Checks if a room is reserved" do
    new_guy = Admin.new
    new_guy.reserve(3,"2018-12-03","2018-12-13")
    answer = new_guy.rooms_reserved_by_date("2018-12-04")

    expect(answer.length).must_equal 1
  end
end

describe "Checks to make sure an error is raised if invalid date range is given" do
  it "raises Error while booking invalid dates" do
    sleepy_guy = Admin.new

    expect{sleepy_guy.reserve(9,"2018-12-25","2018-12-15")}.must_raise StandardError
  end
end

describe "Checks availability for a single date" do
  it "Lets admin know available rooms for a particular date" do
    curious_guy = Admin.new
    ans = curious_guy.check_availability ("2018-06-01")

    expect(ans.length).must_be :>, 19
  end
end
