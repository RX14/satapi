module Satapi
    module StringHelper
        def normalise_endings(str)
            str.encode(str.encoding, universal_newline: true)
        end
    end
    class Api
        helpers StringHelper
    end
end
