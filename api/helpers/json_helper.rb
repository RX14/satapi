module Satapi
    module JSONHelper
        def parse_json(request)
            return nil if request_null? request

            request.body.rewind
            begin
                JSON.parse(request.body.read)
            rescue JSON::ParserError
                nil
            end
        end

        def request_null?(req)
            if req.body.class == Puma::NullIO
                true
            elsif req.body.size <= 0
                true
            end
        end
    end
    class Api
        helpers JSONHelper
    end
end
