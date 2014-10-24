# Defines our constants
RACK_ENV = ENV["RACK_ENV"] ||= "development"  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path("../..", __FILE__) unless defined?(PADRINO_ROOT)

#Load env
if RACK_ENV == "development"
    require "dotenv"
    Dotenv.load
end

# Load our dependencies
require "rubygems" unless defined?(Gem)
require "bundler/setup"
Bundler.require(:default, RACK_ENV)

require "java"
require "#{PADRINO_ROOT}/lib/commons-lang-2.6.jar"
require "#{PADRINO_ROOT}/lib/commons-logging-1.1.1.jar"
require "#{PADRINO_ROOT}/lib/predict4java-1.1.jar"

# rubocop:disable Style/GlobalVars
$db = Orchestrate::Application.new ENV["ORCHESTRATE_KEY"]
# rubocop:enable Style/GlobalVars

Padrino.load!
