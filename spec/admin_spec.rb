require_relative 'spec_helper'

describe 'Concierge class' do
  before(:each) { Lodging::Room.class_variable_set :@@room_list, [] }

  describe 'all_rooms method' do
    it 'shows all rooms in hotel' do
      Lodging.create_rooms(10)

      Lodging::Concierge.all_rooms
    end
  end
end
