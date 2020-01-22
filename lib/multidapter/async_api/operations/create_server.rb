module Multidapter
  module AsyncApi
    module Operations
      class CreateServer
        include Dry::Monads[:result, :do]

        def call(params)
          values  = yield validate(params)
          server = yield create_server(values.to_h)

          Success(server)
        end

        def validate(params)
          # returns Success(values) or Failure(:invalid_data)
          contract = Multidapter::AsyncApi::Validators::ServerContract.new
          Success(contract.call(params))
        end

        def create_server(server_values)
          # returns Success(server) or Failure(:server_not_created)
          server = Multidapter::AsyncApi::Server.new(server_values)
          Success(server)
        end
      end
    end
  end
end
