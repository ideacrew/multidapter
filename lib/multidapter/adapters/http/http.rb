module Multidapter
  module Adapters
    module Http

        def initialize(adapter)
          @adapter = adapter
        end

        def method_missing(name, *args)
          @adapter.send(name, *args)
        end

    end
  end
end