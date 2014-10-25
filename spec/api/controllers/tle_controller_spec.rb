require "spec_helper"
require "json"

RSpec.describe "/api/tle" do
    describe "index" do
        before do
            get "/api/tle"
        end

        it "returns valid json" do
            parsed = begin
                JSON.parse(last_response.body)
                true
            rescue => error
                puts error.inspect
                puts error.backtrace
                false
            end
            expect(parsed).to be true
        end
    end
end
