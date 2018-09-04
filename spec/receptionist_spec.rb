require_relative 'spec_helper'

describe 'Receptionist' do
  before do
    @receptionist = Receptionist.new()
  end
  it 'will initialize a receptionist' do
    expect(@receptionist).must_be_instance_of Receptionist
  end
end
