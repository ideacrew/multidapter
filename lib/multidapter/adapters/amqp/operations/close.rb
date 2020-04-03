# frozen_string_literal: true

# Close connection to AMQP server if open.  If connection is in some other status,
# return the status in a Failure monad

module Multidapter
  module Adapters
    module Amqp
      module Operations
        class Close
          send(:include, Dry::Monads[:result, :do])

          def self.call(params)
            new.call(params)
          end

          def call(params)
            connection = params

            if Active.call(connection).value!
              Success(connection.close)
            else
              Failure(ConnectionStatus(connection))
            end
          end

        end
      end
    end
  end
end
