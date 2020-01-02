# frozen_string_literal: true

module Multidapter
  module Messages
    class RoutingSlip

      attr_accessor :name, :current_step, :step_name, :step_config
      attr_reader :correlation_id

      def initialize(params, &block)

        @correlation_id = Messages.generate_uuid
      end    


      def add_route(new_route)
      end


      private

      def generate_correlation_id
        SecureRandom.uuid
      end

    end
  end
end