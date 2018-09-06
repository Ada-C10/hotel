require_relative 'spec_helper'

describe 'room class' do
  #clears the class variable back to empty array before each test
  before(:each) { Lodging::Room.class_variable_set :@@room_list, [] }

  describe 'initialize' do
    it 'creates a new instance of room' do
      new_rooms = Lodging::Room.new(20)

      expect(new_rooms).must_be_instance_of Lodging::Room
    end
  end

  describe 'show list' do
    it 'prints all instances of room' do
      Lodging.create_rooms(10)

      list = Lodging::Room.show_list
      first = list.first
      last = list.last

      expect(list.length).must_equal 10
      expect(list.any? Lodging::Room).must_equal true

      expect(first.room_number).must_equal 1
      expect(last.room_number).must_equal 10
    end
  end

end
