require_relative 'spec_helper'

describe 'Concierge class' do
  before(:each) do
    Lodging::Room.class_variable_set(:@@room_list, [])
  end

  describe 'all_rooms method' do
    it 'shows all rooms in hotel' do
      Lodging.create_rooms(10)

      room_list = Lodging::Concierge.all_rooms

      expect(room_list.any? Hash).must_equal true
      # expect(room_list.length).must_equal 10
    end
  end
end
