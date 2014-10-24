module Satapi
    class Api
        module StringHelper
            def normalise_endings(str)
                str.encode(str.encoding, universal_newline: true)
            end
        end

        helpers StringHelper
    end
end
