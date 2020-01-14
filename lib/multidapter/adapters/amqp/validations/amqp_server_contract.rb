# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      module Validations

        class AmqpServerContract
          extend Multidapter::AsyncApi::Validators::ServerContract

          # AsyncApi v2.0 Amqp Server Bindings must be nil
          params do 
            optional(:bindings).value(nil)
          end

        end
      end
    end
  end
end
