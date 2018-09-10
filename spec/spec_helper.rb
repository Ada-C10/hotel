require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/rooms'
require_relative '../lib/reservations'
require_relative '../lib/front_desk'
