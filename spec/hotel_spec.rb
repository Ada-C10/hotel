require_relative 'spec_helper'

describe 'Hotel Wave 1' do
  describe 'initalize' do
    it 'creates a hotel with attr name' do
      my_hotel = Lodging::Hotel.new("My Hotel", 20)

      expect(my_hotel).must_respond_to :name
      expect(my_hotel.name).must_equal "My Hotel"

      expect(my_hotel).must_respond_to :room_count
      expect(my_hotel.room_count).must_equal 20

      expect(my_hotel).must_respond_to :rooms
    end
    #
    it 'errors if arg in rooms param is not an integer' do
      expect{
        Lodging::Hotel.new("My Hotel","twenty")
      }.must_raise ArgumentError
    end

    it 'errors if arg for rooms param is 0' do
      expect{
        Lodging::Hotel.new("My Hotel", 0)
      }.must_raise ArgumentError
    end
    #
    # it 'errors if arg in hotel_name param is not a string' do
    #   expect{
    #     Lodging::Hotel.new(hotel49, 20)
    #   }.must_raise ArgumentError
    # end

    it 'creates new Room class instances based on room_count' do
        my_hotel = Lodging::Hotel.new("My Hotel", 20)

        expect(my_hotel.rooms).must_be_kind_of Array
        expect(my_hotel.rooms.all? Lodging::Room).must_equal true
    end

  end
end
