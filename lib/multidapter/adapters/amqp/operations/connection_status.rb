# frozen_string_literal: true

# Report the state of the AMQP connection

module Multidapter
  module Adapters
    module Amqp
      module Operations
        class ConnectionStatus
          send(:include, Dry::Monads[:result, :do])

          def self.call(params)
            new.call(params)
          end

          def call(params)
            connection = params

            Success(connection.status)
          end

        end
      end
    end
  end
end
