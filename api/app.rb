module Satapi
    class Api < Padrino::Application
        register Padrino::Helpers

        use Committee::Middleware::RequestValidation,
            schema: JSON.parse(
                File.read("#{PADRINO_ROOT}/docs/schema/schema.json"))

        set :protect_from_csrf, false
    end
end
