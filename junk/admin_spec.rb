require_relative 'spec_helper'

describe 'Concierge class' do
  before(:each) do
    Lodging::Room.class_variable_set(:@@room_list, [])
  end

  let(:concierge) {
    Lodging::Concierge.new(10)
  }

  describe 'all_rooms method' do
    it 'shows all rooms in hotel' do
      # Lodging.create_rooms(10)

      room_list = concierge.all_rooms

      expect(room_list.any? Hash).must_equal true
      expect(room_list.length).must_equal 10
    end

  end

  describe 'new reservation method' do
    let(:new_booking) {
      concierge.new_reservation('201876', '201878')
    }

    it 'errors if invalid date is entered' do
      expect{concierge.new_reservation('201876', '201778')}.must_raise ArgumentError
    end

    # it 'creates a check_in and check_out dates for room' do
    #   ap concierge
    #
    # end

  end

  describe 'search reservation' do
    it 'can find a reservation based on date' do 

    end
  end
end
