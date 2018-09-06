####
require 'simplecov' #for autotesting w. guard
SimpleCov.start
####
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
# require_relative '../lib/block'
require_relative '../lib/admin'
require_relative '../lib/reservation'
require_relative '../lib/room'
