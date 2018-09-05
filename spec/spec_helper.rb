
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/admin'
require_relative '../lib/reservation'
require_relative '../lib/room'
