RACK_ENV = "test" unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")] \
    .each(&method(:require))

RSpec.configure do |conf|
    conf.mock_with :mocha
    conf.include Rack::Test::Methods
end

require "vcr"
require "webmock/rspec"

VCR.configure do |c|
    c.cassette_library_dir = "vcr_cassettes"
    c.hook_into :webmock
end

def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
end
