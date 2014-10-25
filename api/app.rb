module Satapi
    class Api < Padrino::Application
        register Padrino::Helpers

        set :protect_from_csrf, false

        # :nocov:
        configure :development do
            use BetterErrors::Middleware
            BetterErrors.application_root = __dir__
        end
        # :nocov:
    end
end
