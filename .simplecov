require "coveralls"
require "codeclimate-test-reporter"
require "simplecov-summary"

SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
        Coveralls::SimpleCov::Formatter,
        CodeClimate::TestReporter::Formatter,
        SimpleCov::Formatter::SummaryFormatter
    ]

    add_filter "/config/"
    add_filter "/spec/"

    add_group "api:controllers", "api/controllers"
    add_group "api:helpers", "api/helpers"
    add_group "api:app", "api/app.rb"
end
