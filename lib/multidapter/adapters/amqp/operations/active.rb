# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Operations
        class Active
          send(:include, Dry::Monads[:result, :do])

          def self.call(params)
            new.call(params)
          end

          def call(params)
            connection = params
            Success(connection.open?)
          end
        end
      end
    end
  end
end
