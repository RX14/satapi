Satapi::Api.controllers :tle do

    get :index do
        schema = {
            tle: "/api/json/tle"
        }
        JSON.pretty_generate(schema) + "\n"
    end

    post :extract do
        TLEstr = normalise_endings(@request_json["TLE"])

        TLEdata = TLEstr.split("\n").first 3

        TLE = uk.me.g4dpz.satellite.TLE.new(TLEdata.to_java :String)

        response = {}
        response[:catnum] = TLE.getCatnum
        response[:name] = TLE.getName
        response[:setnum] = TLE.getSetnum
        response[:year] = TLE.getYear
        response[:refepoch] = TLE.getRefepoch
        response[:inclination] = TLE.getIncl
        response[:raan] = TLE.getRaan
        response[:eccentricity] = TLE.getEccn
        response[:argper] = TLE.getArgper
        response[:mean_anomoly] = TLE.getMeanan
        response[:mean_motion] = TLE.getMeanmo
        response[:drag] = TLE.getDrag
        response[:nddot6] = TLE.getNddot6
        response[:bstar] = TLE.getBstar
        response[:orbitnum] = TLE.getOrbitnum
        response[:epoch] = TLE.getEpoch
        response[:xndt2o] = TLE.getXndt2o
        response[:xincl] = TLE.getXincl
        response[:xnodeo] = TLE.getXnodeo
        response[:eo] = TLE.getEo
        response[:omegao] = TLE.getOmegao
        response[:xmo] = TLE.getXmo
        response[:xno] = TLE.getXno
        response[:deepspace] = TLE.isDeepspace

        JSON.pretty_generate(response) + "\n"
    end

end
