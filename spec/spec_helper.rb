# hotel/specs/spec_helper.rb
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require "minitest/pride"
require "pry"
require "awesome_print"

# Add lib files here (require_relative "../")

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
