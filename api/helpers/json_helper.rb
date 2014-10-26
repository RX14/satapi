require_relative "string_helper"

module Satapi
    module JSONHelper
        include StringHelper

        def parse_json(req)
            body = extract_request_body(req)

            begin
                JSON.parse(body)
            rescue JSON::ParserError
                nil
            end
        end
    end
    class Api
        helpers JSONHelper
    end
end
