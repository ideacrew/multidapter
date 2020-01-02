# frozen_string_literal: true

module Multidapter
  module Messages
    class EventProducer

      attr_accessor :exchange, :kind, :payload

      def initialize(params, &block)

        @correlation_id = Messages.generate_uuid
      end    


    end
  end
end