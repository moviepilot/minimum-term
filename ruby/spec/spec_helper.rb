require 'rubygems'
require 'bundler'
require 'simplecov'

Bundler.require

$:.unshift File.expand_path("../lib", __FILE__)

Dir[File.join(File.dirname(__FILE__), "/support/**/*.rb")].each{ |f| require f }

SimpleCov.start
require "minimum_term"

RSpec.configure do |config|
  config.after(:suite) do
    example_group = RSpec.describe('Code coverage')
    example = example_group.example('must be above 100%'){
      expect( SimpleCov.result.covered_percent ).to eq 100
    }
    example_group.run

    passed = example.execution_result.status == :passed

    RSpec.configuration.reporter.example_failed example unless passed
  end
  config.order = :random
end
