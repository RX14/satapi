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
end
