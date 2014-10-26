require "spec_helper"

RSpec.describe "Satapi::JSONHelper" do
    let(:helpers) { Class.new }
    before { helpers.extend Satapi::JSONHelper }
    subject { helpers }

    describe "#request_body_empty?" do
        it "should pass when given a good request" do
            mock = Rack::Request.new("rack.input" => "body")

            expect(subject.request_body_empty? mock).to be false
        end

        it "should detect a nil request" do
            expect(subject.request_body_empty? nil).to be true
        end

        it "should detect a nil body" do
            mock = Rack::Request.new("rack.input" => nil)

            expect(subject.request_body_empty? mock).to be true
        end

        it "should detect a Puma::NullIO body" do
            mock = Rack::Request.new("rack.input" => Puma::NullIO.new)

            expect(subject.request_body_empty? mock).to be true
        end

        it "should detect a body size of 0" do
            mock = Rack::Request.new("rack.input" => "")

            expect(subject.request_body_empty? mock).to be true
        end
    end

    describe "#extract_body" do
        it "should extract a String" do
            mock = Rack::Request.new("rack.input" => "string")

            expect(subject.extract_body mock).to eq("string")
        end

        it "should extract a StringIO" do
            mock = Rack::Request.new("rack.input" => StringIO.new("string"))

            expect(subject.extract_body mock).to eq("string")
        end

        it "should extract a forwarded StringIO" do
            string_io = StringIO.new("string")
            mock = Rack::Request.new("rack.input" => string_io)

            expect(subject.extract_body mock).to eq("string")
        end
    end

    describe "#parse_json" do
        json_string = '{ "key": "value" }'

        it "should pass when given a JSON string" do
            mock = Rack::Request.new("rack.input" => json_string)

            expect(subject.parse_json mock).to eq("key" => "value")
        end

        it "should pass when given a JSON StringIO" do
            mock = Rack::Request.new("rack.input" => StringIO.new(json_string))

            expect(subject.parse_json mock).to eq("key" => "value")
        end

        it "should return false when given invalid JSON" do
            mock = Rack::Request.new("rack.input" => '{ key: "value }')

            expect(subject.parse_json mock).to eq(nil)
        end
    end
end
