module Satapi
    class Api < Padrino::Application
        register Padrino::Helpers

        configure :development do
            use BetterErrors::Middleware
            BetterErrors.application_root = __dir__
        end

        before do
            pass if request.body.class == Puma::NullIO
            pass if request.body.size <= 0

            request.body.rewind
            @request_json = JSON.parse(request.body.read)
        end
    end
end
