# frozen_string_literal: true

module Multidapter
  module Operations
    module SecuritySchemes

      # Create a user_password type {SecurityScheme} instance
      class CreateUserPasswordScheme
        send(:include, Dry::Monads[:result, :do])

        def self.call(params)
          new.call(params)
        end

        # @param [Hash] params Values to use to create the :user_password SecurityScheme instance. Validated using {Validators::SecuritySchemeContract SecuritySchemeContract}
        # @example
        #  {  }
        # @return [Dry::Monads::Result::Success<SecurityScheme>] if SecurityScheme is created
        # @return [Dry::Monads::Result::Failure<Hash>] if SecurityScheme creation fails
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
