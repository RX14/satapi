module Satapi
    class Api < Padrino::Application
        register Padrino::Helpers

        set :protect_from_csrf, false
    end
end
