require "sinatra"
require "json"
require "slim"

require "java"
require_relative "./lib/commons-lang-2.6.jar"
require_relative "./lib/commons-logging-1.1.1.jar"
require_relative "./lib/predict4java-1.1.jar"

configure :production do
    require 'rack/cache'

    use Rack::Cache,
        :metastore   => 'file:/tmp/cache/rack/meta',
        :entitystore => 'file:/tmp/cache/rack/body',
        :verbose     => true
end

configure :development do
    require "sinatra/reloader"
    require "better_errors"

    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
end

#===============================================================================

helpers do

    def uk
        Java::Uk
    end

    def normalise_endings(str)
        str.encode(str.encoding, :universal_newline => true)
    end

end

before '/api/json/*' do
    pass if request.body.class == Puma::NullIO
    pass if request.body.size <= 0

    request.body.rewind
    @request_json = JSON.parse(request.body.read)
end

get "/api/json/" do
    schema = {
        :TLE => ""
    }
end

post "/api/json/tle/extract" do
    TLEstr = normalise_endings(@request_json["TLE"])

    TLEdata = TLEstr.split("\n").first 3

    TLE = uk.me.g4dpz.satellite.TLE.new(TLEdata.to_java :String)

    rJSON = {}
    rJSON[:catnum] = TLE.getCatnum
    rJSON[:name] = TLE.getName
    rJSON[:setnum] = TLE.getSetnum
    rJSON[:year] = TLE.getYear
    rJSON[:refepoch] = TLE.getRefepoch
    rJSON[:inclination] = TLE.getIncl
    rJSON[:raan] = TLE.getRaan
    rJSON[:eccentricity] = TLE.getEccn
    rJSON[:argper] = TLE.getArgper
    rJSON[:mean_anomoly] = TLE.getMeanan
    rJSON[:mean_motion] = TLE.getMeanmo
    rJSON[:drag] = TLE.getDrag
    rJSON[:nddot6] = TLE.getNddot6
    rJSON[:bstar] = TLE.getBstar
    rJSON[:orbitnum] = TLE.getOrbitnum
    rJSON[:epoch] = TLE.getEpoch
    rJSON[:xndt2o] = TLE.getXndt2o
    rJSON[:xincl] = TLE.getXincl
    rJSON[:xnodeo] = TLE.getXnodeo
    rJSON[:eo] = TLE.getEo
    rJSON[:omegao] = TLE.getOmegao
    rJSON[:xmo] = TLE.getXmo
    rJSON[:xno] = TLE.getXno
    rJSON[:deepspace] = TLE.isDeepspace

    JSON.pretty_generate(rJSON) + "\n"
end
