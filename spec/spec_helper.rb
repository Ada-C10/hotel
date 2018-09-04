require 'minitest'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require 'block'
require 'front_desk'
require 'reservation'
require 'room'
