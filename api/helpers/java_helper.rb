module Satapi
    module JavaHelper
        def uk
            Java::Uk
        end
    end

    class Api
        helpers JavaHelper
    end
end
