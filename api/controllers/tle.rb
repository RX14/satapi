Satapi::Api.controllers :tle do

    get :index do
        schema = {
            extract: "/api/tle/extract"
        }
        JSON.pretty_generate(schema) + "\n"
    end

    post :process do
        request_json = parse_json(request)

        tle_str = normalise_endings(request_json["TLE"])

        tle_lines = tle_str.split("\n").first 3

        tle = uk.me.g4dpz.satellite.TLE.new(tle_lines.to_java(:String))

        response = {}
        # rubocop:disable Style/SpaceInsideBrackets
        response[:catnum      ] = tle.getCatnum
        response[:name        ] = tle.getName
        response[:setnum      ] = tle.getSetnum
        response[:year        ] = tle.getYear
        response[:refepoch    ] = tle.getRefepoch
        response[:inclination ] = tle.getIncl
        response[:raan        ] = tle.getRaan
        response[:eccentricity] = tle.getEccn
        response[:argper      ] = tle.getArgper
        response[:mean_anomoly] = tle.getMeanan
        response[:mean_motion ] = tle.getMeanmo
        response[:drag        ] = tle.getDrag
        response[:nddot6      ] = tle.getNddot6
        response[:bstar       ] = tle.getBstar
        response[:orbitnum    ] = tle.getOrbitnum
        response[:epoch       ] = tle.getEpoch
        response[:xndt2o      ] = tle.getXndt2o
        response[:xincl       ] = tle.getXincl
        response[:xnodeo      ] = tle.getXnodeo
        response[:eo          ] = tle.getEo
        response[:omegao      ] = tle.getOmegao
        response[:xmo         ] = tle.getXmo
        response[:xno         ] = tle.getXno
        response[:deepspace   ] = tle.isDeepspace
        # rubocop:enable Style/SpaceInsideBrackets

        JSON.pretty_generate(response) + "\n"
    end

end
