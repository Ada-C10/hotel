require_relative 'spec_helper'

describe 'Concierge class' do
  #reset CSV data
  before(:each) do
    CSV.open('all hotel rooms.csv', 'w', headers: true) do |csv|
      csv << ['room_number','cost','status']
    end
  end

  let(:concierge){
    Lodging::Concierge.new(10)
  }

  it 'can view data in all hotel rooms csv file' do

    expect(concierge.all_rooms).must_be_instance_of CSV::Table
    expect(concierge.all_rooms.length).must_equal 10

  end

end
