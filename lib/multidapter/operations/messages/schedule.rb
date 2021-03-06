# frozen_string_literal: true

module Multidapter
  module Operations
    module Messages

      class Schedule
        send(:include, Dry::Monads[:result, :do])

        def call(params)
          result = yield verify(params)
          Success(result)
        end

        private

        def verify(params)
        end

      end

    end
  end
end
