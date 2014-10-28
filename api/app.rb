module Satapi
    class Api < Padrino::Application
        register Padrino::Helpers

        use Committee::Middleware::RequestValidation,
            schema: JSON.parse(
                File.read("#{PADRINO_ROOT}/docs/schema/api.json")),
            optimistic_json: true,
            prefix: "/api",
            raise: RACK_ENV == "test",
            strict: RACK_ENV == "test"

        set :protect_from_csrf, false
    end
end
