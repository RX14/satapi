module Satapi
    module StringHelper
        def normalise_endings(str)
            str.encode(str.encoding, universal_newline: true)
        end

        def extract_request_body(req)
            return nil if request_body_empty? req

            if req.body.respond_to? :read
                req.body.rewind if req.body.respond_to? :rewind
                req.body.read
            else
                req.body
            end
        end

        def request_body_empty?(req)
            return true if req.nil?
            return true if req.body.nil?
            return true if req.body.class == Puma::NullIO
            return true if req.body.size <= 0

            false
        end
    end
    class Api
        helpers StringHelper
    end
end
