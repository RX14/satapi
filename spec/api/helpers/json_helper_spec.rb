require "spec_helper"

RSpec.describe "Satapi::JSONHelper" do
    let(:helpers) { Class.new }
    before { helpers.extend Satapi::JSONHelper }
    subject { helpers }

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
