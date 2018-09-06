require_relative 'spec_helper'

describe 'RoomBlock class' do
  # let (:check_in) {
  #   Date.today
  # }
  # let (:check_out) {
  #   Date.today + 3
  # }
  # let (:block_rooms) {
  #   [*1..5]
  # }
  # let (:discounted_rate) {
  #   150
  # }
  #
  # let (:block) {
  #   Hotel::RoomBlock.new(check_in, check_out, block_rooms, discounted_rate)
  # }


  describe 'RoomBlock Instantiation' do
    expect(Hotel::RoomBlock.new(Date.today, Date.today + 1, [*1..5], 150)).must_be_instance_of Hotel::RoomBlock
  end
end
