module Satapi
    class Api
        module JavaHelper
            def uk
                Java::Uk
            end
        end

        helpers JavaHelper
    end
end
