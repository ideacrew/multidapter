# frozen_string_literal: true

module Multidapter
  module Adapters
    module Amqp
      class Queue < Multidapter::Endpoint

        OPTION_DEFAULTS = {

          exclusive:    true,
          durable:      true,
          auto_delete:  false,
          passive:      false, 
          internal:     false, 
          arguments:    nil, 
          queue: "", 
          nowait:       false, 
          no_declare:   true,

}

 @type=:direct>          
        }

        attr_reader :name, :vhost, :durable, :exclusive, :auto_delete

        def initialize(name, options = {})
          @name = name

          @options = OPTION_DEFAULTS.merge(options)
          @vhost        = options[:vhost]
          @durable      = options[:durable]
          @exclusive    = options[:exclusive]
          @auto_delete  = options[:auto_delete]

        end

      end
    end
  end
end