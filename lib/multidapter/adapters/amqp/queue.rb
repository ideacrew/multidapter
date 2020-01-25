# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class Queue < Dry::Struct

        BUNNY_OPTION_DEFAULTS = {
          passive:      false,
          internal:     false,
          arguments:    nil,
          nowait:       false,
          no_declare:   true,
        }

        # The name of the  It MUST NOT exceed 255 characters long.
        attribute :name,        Types::Coercible::String

        # Whether the queue should survive broker restarts or not.
        attribute :durable,     Types::Bool

        # Whether the queue should be used only by one connection or not.
        attribute :exclusive,   Types::Bool

        # Whether the queue should be deleted when the last consumer unsubscribes.
        attribute :auto_delete, Types::Bool

        # The virtual host of the queue. Defaults to /.
        attribute :vhost,       Types::Coercible::String

      end
    end
  end
end
