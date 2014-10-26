require "spec_helper"

RSpec.describe "Satapi::StringHelper" do
    let(:helpers) { Class.new }
    before { helpers.extend Satapi::StringHelper }
    subject { helpers }

    describe "#normalise_endings" do
        it "should normalise \\n" do
            expect(subject.normalise_endings("1\n2")).to eq("1\n2")
        end

        it "should normalise \\r\\n" do
            expect(subject.normalise_endings("1\r\n2")).to eq("1\n2")
        end

        it "should normalise \\r" do
            expect(subject.normalise_endings("1\r2")).to eq("1\n2")
        end
    end

    describe "#extract_body" do
        it "should extract a String" do
            mock = Rack::Request.new("rack.input" => "string")

            expect(subject.extract_request_body mock).to eq("string")
        end

        it "should extract a StringIO" do
            mock = Rack::Request.new("rack.input" => StringIO.new("string"))

            expect(subject.extract_request_body mock).to eq("string")
        end

        it "should extract a forwarded StringIO" do
            string_io = StringIO.new("string")
            mock = Rack::Request.new("rack.input" => string_io)

            expect(subject.extract_request_body mock).to eq("string")
        end
    end

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
end
