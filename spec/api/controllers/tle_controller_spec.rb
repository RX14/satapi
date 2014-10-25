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

            # rubocop:disable Style/SpaceInsideBrackets
            expect(result[:name        ]).to eq("AO-51 [+]")
            expect(result[:catnum      ]).to eq(28_375)
            expect(result[:setnum      ]).to eq(364)
            expect(result[:year        ]).to eq(9)
            expect(result[:refepoch    ].round(7)).to eq(105.6639197)
            expect(result[:inclination ].round(7)).to eq(98.0551)
            expect(result[:raan        ].round(7)).to eq(118.9086)
            expect(result[:eccentricity].round(7)).to eq(0.0084159)
            expect(result[:argper      ].round(7)).to eq(315.8041)
            expect(result[:mean_anomoly].round(7)).to eq(43.6444)
            expect(result[:mean_motion ].round(7)).to eq(14.4063845)
            expect(result[:drag        ].round(4)).to eq(0)
            expect(result[:nddot6      ].round(4)).to eq(0)
            expect(result[:bstar       ].round(7)).to eq(0.0000138)
            expect(result[:orbitnum    ]).to eq(25_195)
            expect(result[:epoch       ].round(7)).to eq(9105.6639197)
            expect(result[:xndt2o      ].round(7)).to eq(0)
            expect(result[:xincl       ].round(7)).to eq(1.7113843)
            expect(result[:xnodeo      ].round(7)).to eq(2.0753466)
            expect(result[:eo          ].round(7)).to eq(0.0084159)
            expect(result[:omegao      ].round(7)).to eq(5.5118213)
            expect(result[:xmo         ].round(7)).to eq(0.7617385)
            expect(result[:xno         ].round(6)).to eq(0.06286)
            expect(result[:deepspace   ]).to be false
            # rubocop:enable Style/SpaceInsideBrackets

        end
    end
end
