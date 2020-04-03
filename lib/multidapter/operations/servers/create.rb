# frozen_string_literal: true

module Multidapter
  module Operations
    module Servers

      # Create a {Server} instance
      class Create
        send(:include, Dry::Monads[:result, :do])

        def self.call(params)
          new.call(params)
        end

        # @param [Hash] params Values to use to create the Server instance. Validated using {Validators::ServerContract ServerContract}
        # @example
        #   { protocol:         :amqp,
        #     url:              "amqp://localhost",
        #     description:      "Primary AMQP host",
        #     security_scheme:  SecurityScheme }
        # @return [Dry::Monads::Result::Success<Server>] if Server is created
        # @return [Dry::Monads::Result::Failure<Hash>] if Server creation fails
        def call(params)
          values  = yield validate(params)
          server  = yield create_server(values)

          Success(server)
        end

        private

        def validate(params)
          # returns Success(values) or Failure(:invalid_data)
          contract = Multidapter::Validators::ServerContract.new
          Success(contract.call(params))
        end

        def create_server(values)
          # returns Success(server) or Failure(:server_not_created)
          server  = Multidapter::Server.new(values.to_h)
          Success(server)
        end

      end

    end
  end
end
