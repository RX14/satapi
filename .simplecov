require "coveralls"
require "codeclimate-test-reporter"

SimpleCov.start do
    formatter SimpleCov::Formatter::MultiFormatter[
        Coveralls::SimpleCov::Formatter,
        CodeClimate::TestReporter::Formatter
    ]
end
