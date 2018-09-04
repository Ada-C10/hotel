require 'simplecov'


require 'minitest'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

 require_relative '../lib/hotel'
 require_relative '../lib/reservation'
 require_relative '../lib/room'
