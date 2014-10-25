source "https://rubygems.org"

gem "rake", "10.3.2"

gem "padrino", "0.12.4"

gem "jruby-openssl", "0.9.5"

gem "orchestrate", "0.9.1"

group :development, :production do
    gem "puma", "2.9.1"
end

group :development do
    gem "dotenv", "1.0.2"

    gem "better_errors", "2.0.0"
    # gem "binding_of_caller", "0.7.3.pre1"
end

group :test do
    gem "rr", "1.1.2", require: false

    gem "rspec", "3.1.0"

    gem "rack-test", "0.6.2", require: "rack/test"

    gem "vcr", "2.9.3"
    gem "webmock", "1.20.0"

    gem "ruby-lint", "2.0.2"
    gem "rubocop", github: "bbatsov/rubocop", ref: "cf0a3"

    gem "simplecov", "0.9.1", require: false
    gem "coveralls", "0.7.1", require: false
    gem "codeclimate-test-reporter", "0.4.1", require: false
    gem "simplecov-summary", require: false, github: "RX14/simplecov-summary"
end
