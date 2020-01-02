# frozen_string_literal: true

module Multidapter
  module Messages
    class EventConsumer

      attr_accessor :queue_name, :payload

      def initialize(params, &block)

        @correlation_id = Messages.generate_uuid
      end    




      private

    end
  end
end