# frozen_string_literal: true

module Multidapter
  module Operations
    module Services

      # Create a {Service} instance
      class Create
        send(:include, Dry::Monads[:result, :do])

        def self.call(params)
          new(params)
        end

        # @param [Hash] service_hash Values to use to create the Service instance. Validated using {Validators::ServiceContract ServiceContract}
        # @example
        #  { asyncapi: "2.0", info: { title: "Notice Service", version: "0.1.0" }, channels: [{channel_id: :email_notices}] }
        # @return [Dry::Monads::Result::Success<Service>] if Service is created
        # @return [Dry::Monads::Result::Failure<Hash>] if Service creation fails
        def call(params)
          values = yield validate(params)
          entity = yield create(values)

          Success(entity)
        end

        private

        def validate(params)
          result = Multidapter::Validators::ServiceContract.new.call(params)
          result.success? ? Success(result) : Failure(result)
        end

        def create(values)
          result = Multidapter::Service.call(values.to_h)
          Success(result)
        end

      end

    end
  end
end
