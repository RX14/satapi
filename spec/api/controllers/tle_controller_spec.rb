require "spec_helper"
require "json"

RSpec.describe "/api/tle" do
    describe "index" do
        before do
            get "/api/tle"
        end
        include_examples "JSON"
    end

    describe "/extract" do

        TLE = "AO-51 [+]
1 28375U 04025K   09105.66391970  .00000003  00000-0  13761-4 0  3643
2 28375 098.0551 118.9086 0084159 315.8041 043.6444 14.40638450251959"

        before do
            post_json "/api/tle/extract", TLE: TLE
        end

        include_examples "JSON"

        it "should return the correct data" do
            result = JSON.parse(last_response.body, symbolize_names: true)

            expect(result[:name]).to eq("AO-51 [+]")
            expect(result[:catnum]).to eq("28375")
            expect(result[:setnum]).to eq("364")
            expect(result[:year]).to eq("9")
            expect(result[:refepoch]).to eq("105.6639197")
            expect(result[:inclination]).to eq("98.0551000")
            expect(result[:raan]).to eq("118.9086000")
            expect(result[:eccentricity]).to eq("0.0084159")
            expect(result[:argper]).to eq("315.8041000")
            expect(result[:mean_anomoly]).to eq("43.6444000")
            expect(result[:mean_motion]).to eq("14.4063845")
            expect(result[:drag]).to eq("0.0000")
            expect(result[:nddot6]).to eq("0.0000")
            expect(result[:bstar]).to eq("0.0000138")
            expect(result[:orbitnum]).to eq("25195")
            expect(result[:epoch]).to eq("9105.6639197")
            expect(result[:xndt2o]).to eq("0.0000000")
            expect(result[:xincl]).to eq("1.7113843")
            expect(result[:xnodeo]).to eq("2.0753466")
            expect(result[:eo]).to eq("0.0084159")
            expect(result[:omegao]).to eq("5.5118213")
            expect(result[:xmo]).to eq("0.7617385")
            expect(result[:xno]).to eq("0.062860")
            expect(result[:deepspace]).to be_false

        end
    end
end
