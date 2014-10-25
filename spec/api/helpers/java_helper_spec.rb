require "spec_helper"

RSpec.describe "Satapi::JavaHelper" do
    let(:helpers) { Class.new }
    before { helpers.extend Satapi::JavaHelper }
    subject { helpers }

    describe "#uk" do
        it "should make the uk namespace accessible" do
            expect(subject.uk).to equal(Java::Uk)
        end
    end
end
