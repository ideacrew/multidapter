# frozen_string_literal: true

module Multidapter
  module Operations
    module Applications

      class Create
        send(:include, Dry::Monads[:result, :do])

        def self.call(params)
          new(params)
        end

        def call(params)
          values = yield validate(params)
          entity = yield create(values)

          Success(entity)
        end

        private

        def validate(params)
          result = Multidapter::Validators::ApplicationContract.new.call(params)
          result.success? ? Success(result) : Failure(result)
        end

        def create(values)
          result = Multidapter::Application.call(values.to_h)
          Success(result)
        end

      end

    end
  end
end
