require_relative 'spec_helper'

describe 'RoomBlock class' do
describe 'initializing a roomblock' do

  it 'returns roomblock object given correct inputs' do

    expect( Hotel::RoomBlock.new([*1..5], Date.new(2018,7,4), Date.new(2018,7,8), 100)
  ).must_be_instance_of(Hotel::RoomBlock)
    expect( Hotel::RoomBlock.new([*1..5], Date.new(2018,6,4), Date.new(2018,7,4))
  ).must_be_instance_of(Hotel::RoomBlock)
  end

  it 'raise argument error given wrong input format' do

    expect{
      Hotel::RoomBlock.new(2, Date.new(2018,7,4), Date.new(2018,7,8), 100)
    }.must_raise(ArgumentError)
    expect{
      Hotel::RoomBlock.new([2], 'stringdate', Date.new(2018,7,8), 100)
    }.must_raise(ArgumentError)
    expect{
      Hotel::RoomBlock.new([2], Date.new(2018,7,4), Date.new(2018,7,8), -3)
    }.must_raise(ArgumentError)
  end
end

end
