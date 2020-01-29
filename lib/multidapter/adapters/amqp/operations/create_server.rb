# frozen_string_literal: true

# Construct an AMQP Server object

module Multidapter
  module Adapters
    module Amqp
      module Operations
        class CreateServer
          include Dry::Monads[:result, :do]

          def call(params)
            values = yield merge_defaults(params)
            @server = yield create_server(values)

            Success(server)
          end

          private

          def merge_defaults(params)
            server_defaults = {

            }.freeze

            server_defaults.merge(params)
          end

          def map_security(server)
            return unless server[:security] && server[:security][:type]

            security_scheme = server[:security]

            case security_scheme[:type]
            when :user_password
              { auth_mechanism: "PLAIN" }
            else
              # logger("encountered unsupported security scheme: #{security_scheme[:type]}")
              {}
            end
          end

          def fetch_server_variable(variable)
            @server[:variables].detect { |var| var[:key] == variable }
          end

          def map_host(server)
            # parse the URI and merge with host attributes
          end

          def server_defaults
            {
              url:              "amqp://127.0.0.1:5672",
              protocol:         :amqp,
              protocol_version: "1.9.1",
              description: 'RabbitMQ Server',
            }.freeze
          end

          def variables_defaults
            [
              { key: :user, value: { default: "guest", description: "Clear text user name" } },
              { key: :password, value: { default: "guest", description: "Clear text password" } },
              { key: :auth_mechanism, value: { default: "PLAIN", description: "Clear text password" } },
              { key: :ssl, value: { default: "false" } },
            ]
          end



          def security_defaults
            {
              type: :user_password,
              description: "Clear text user name and password.  Find values in Variables attribute."
            }.freeze
          end

          def create_server(values)
            Multidapter::AsyncApi::Operations::CreateServer.call(values)
          end
        end

      end
    end
  end
end
