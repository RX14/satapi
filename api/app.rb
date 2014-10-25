module Satapi
    class Api < Padrino::Application
        register Padrino::Helpers

        # :nocov:
        configure :development do
            use BetterErrors::Middleware
            BetterErrors.application_root = __dir__
        end
        # :nocov:

        before do
            if request.body.class == Puma::NullIO
                skip  = true
            elsif request.body.size <= 0
                skip = true
            end

            request.body.rewind
            @request_json = JSON.parse(request.body.read) unless skip
        end
    end
end
