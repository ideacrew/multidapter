# frozen_string_literal: true

module Multidapter
  module Operations
    module Servers

      class Create
        send(:include, Dry::Monads[:result, :do])

        def self.call(params)
          new.call(params)
        end

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
