require 'simplecov'
require 'minitest'
SimpleCov.start do
  add_filter "/spec/"
end
require 'minitest/autorun'
require 'minitest/reporters'



Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/admin'
require_relative '../lib/reservation'
require_relative '../lib/room'
require_relative '../lib/block_admin'
