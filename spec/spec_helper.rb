require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require "minitest/pride"
require "pry"
require "awesome_print"

# Add lib files here (require_relative "../")
require_relative "../book.rb"
require_relative "../cost.rb"
require_relative "../hotel.rb"
require_relative "../loader.rb"
require_relative "../reservation.rb"


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
