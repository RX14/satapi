require "bundler/setup"

require "sinatra"
require "json"
require "orchestrate"

require "java"
require_relative "./lib/commons-lang-2.6.jar"
require_relative "./lib/commons-logging-1.1.1.jar"
require_relative "./lib/predict4java-1.1.jar"

configure :production do
    require "rack/cache"

    use Rack::Cache,
        metastore:   "file:/tmp/cache/rack/meta",
        entitystore: "file:/tmp/cache/rack/body",
        verbose:     true
end

configure :development do
    require "better_errors"

    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
end

db = Orchestrate::Application.new ENV["ORCHESTRATE_KEY"]
TLEstore = db[:TLEs]

################################################################################

helpers do

    def uk
        Java::Uk
    end

    def normalise_endings(str)
        str.encode(str.encoding, universal_newline: true)
    end

end

before "/api/json/*" do
    pass if request.body.class == Puma::NullIO
    pass if request.body.size <= 0

    request.body.rewind
    @request_json = JSON.parse(request.body.read)
end

get "/api/json/" do
    schema = {
        TLE: ""
    }
end

post "/api/json/tle/extract" do
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
