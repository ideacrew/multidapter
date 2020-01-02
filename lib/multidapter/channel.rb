# frozen_string_literal: true
# “topics”, “routing keys”, “event types” or “paths”
module Multidapter
  module Adapters
    class Channel

      BINDING_DEFAULTS = {

      }

      attr_reader :connection, :bindings

      attr_accessor :description, :subscribe, :publish, 


      def initialize(uri, options = {})
        @scheduled_messages = []
        @name = name
        @id = generate_id


        @options = OPTION_DEFAULTS.merge(options)
        @description = options[:description]

        self
      end



      def post_message(message)
      end

      def retreive_message
      end

      def schedule_message(message, post_at = Time.now)
        scheduled_message_id = Multidapter.generate_id
      end

      def delete_scheduled_message(scheduled_message_id)
      end

      def scheduled_messages
        @scheduled_messages
      end





    end
  end
end
