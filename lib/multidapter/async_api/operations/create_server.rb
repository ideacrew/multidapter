# frozen_string_literal: true

# Validate passed parameters and construct a Server object

module Multidapter
  module AsyncApi
    module Operations
      class CreateServer
        include Dry::Monads[:result, :do]

        def self.call(params)
          new.call(params)
        end

        def call(params)
          values  = yield validate(params)
          server  = yield create_server(values)

          Success([server, options_hash])
        end

        private

        def validate(params)
          # returns Success(values) or Failure(:invalid_data)
          contract = Multidapter::AsyncApi::Validators::ServerContract.new
          Success(contract.call(params))
        end

        def create_server(values)
          # returns Success(server) or Failure(:server_not_created)
          server  = Multidapter::AsyncApi::Server.new(values.to_h)
          Success(server)
        end

      end
    end
  end
end
