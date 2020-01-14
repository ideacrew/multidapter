# frozen_string_literal: true
module Multidapter
  class ConnectionAdapter

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

    # Public
    def self.call(uri, options)
      new(uri, options).connection
    end


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

    # Enable passing of block that Release the connection re
    def self.connect
      server_connection = new
      server_connection.connect!

      begin
        if block.given?
          yield(server_connection)
        else
          server_connection
        end
      ensure
        if block.given?
          server_connection.close if server_connection
        end
      end
    end

    def connect!
    end

    def on_connect
    end


    def connection
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
