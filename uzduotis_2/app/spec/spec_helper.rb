require 'simplecov'
SimpleCov.start

require 'rack/test'
require 'rspec'

require File.expand_path '../../lib/app.rb', __FILE__


ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def run() App end
end

RSpec.configure { |c| c.include RSpecMixin }