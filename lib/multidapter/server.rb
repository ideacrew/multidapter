# frozen_string_literal: true
module Multidapter
  class Server

    OPTION_DEFAULTS = {
      env:                  ENV['MULTIDAPTER_ENV'] || :production,  # Environment

      url:                  nil,
      protocol:             nil,
      protocol_version:     nil,
      description:          nil,
      security:             nil,
      bindings:             {},
      default_content_type: nil,
    }

    attr_reader :endpoint, :protocol, :channels

    def initialize(endpoint, options = {})
      @channels = []

      @options = OPTION_DEFAULTS.merge(options)

      @protocol             = options[:protocol]
      @protocol_version     = options[:protocol_version]
      @description          = options[:description]

      @security_scheme      = options[:security_scheme]
      @bindings             = options[:bindings]
    end

    def add_channel(new_channel)
      @channels << new_channel unless channel_names.include?(new_channel.name)
    end

    def channel_names
      @channels.map(&:name)
    end

    def channels
      @channels
    end

    def connection
    end

    def connect
    end

    def on_connect
    end

    def active?
    end

    def close
    end

    # Disconnects from server if already connected and establishes a new connection to server
    def reconnect
    end

    def test_connection
      return true if active?

      begin
        connect
        if @active
          logger "#{name} connection test succeeded"
          true
        end
      ensure
        close
      end
    end

  end
end
