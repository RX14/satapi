source "https://rubygems.org"

gem "rake", "10.3.2"

gem "padrino", "0.12.4"

gem "jruby-openssl", "0.9.4"

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
    gem "mocha", "1.1.0", require: false
    gem "rspec", "3.1.0"
    gem "fuubar", "2.0.0"
    gem "rack-test", "0.6.2", require: "rack/test"

    gem "ruby-lint", "2.0.2"
    gem "rubocop", github: "bbatsov/rubocop", ref: "cf0a3"
end
