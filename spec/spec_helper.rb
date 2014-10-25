require "simplecov"

RACK_ENV = "test" unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir[File.expand_path(File.dirname(__FILE__) + "/../api/helpers/**/*.rb")] \
    .each(&method(:require))

require "rr"

RSpec.configure do |conf|
    conf.mock_with :rr
    conf.include Rack::Test::Methods
end

require "vcr"
require "webmock/rspec"

VCR.configure do |c|
    c.cassette_library_dir = "vcr_cassettes"
    c.hook_into :webmock
    c.ignore_hosts "codeclimate.com", "coveralls.io"
    c.ignore_localhost = true
end

WebMock.disable_net_connect!(allow: ["codeclimate.com", "coveralls.io"])

rr_ddc = RR::DoubleDefinitions::DoubleDefinitionCreate.new
client = rr_ddc.mock(Orchestrate::Client, nil)
$db = Orchestrate::Application.new(client)

def app(app = nil, &blk)
    @app ||= block_given? ? app.instance_eval(&blk) : app
    @app ||= Padrino.application
end

def post_json(uri, json)
    post(uri, JSON.generate(json), "CONTENT_TYPE" => "application/json")
end
