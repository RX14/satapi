RSpec.shared_examples "JSON" do
    it "returns valid json" do
        parsed = begin
            JSON.parse(last_response.body)
            true
        rescue => error
            puts error.inspect
            puts error.backtrace
            puts "BODY"
            puts "===="
            puts last_response.body
            false
        end
        expect(parsed).to be true
    end
end
