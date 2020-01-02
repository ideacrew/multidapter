# frozen_string_literal: true

require 'securerandom'
require_relative 'messages/message'
# require_relative 'messages/routing_slip'

module Multidapter
  module Messages

    MESSAGE_KINDS = [:command, :event, :routing_slip]

    def self.formatters
      @formatters = {
        cloudevent: Messages::CloudeventFormatter,
        # bunny:      Messages::BunnyFormatter,
        # sneakers:   Messages::SneakersFormatter,
        # http:       Messages::HttpFormatter,
      }
    end

    def self.add_formatter(name, formatter)
      raise Multidapter::Error::DuplicateMessageFormater("Message formatter with name #{name} already exists") if formatters.include?(name)

      formatters.merge!(name.to_sym => formatter)
    end



  end
end
