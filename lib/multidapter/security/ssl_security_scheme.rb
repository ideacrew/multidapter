module Multidapter
  module Security
    class SslSecurityScheme

      # See TLS/SSL CA default paths: http://rubybunny.info/articles/tls.html

      SSL_LISTENERS       = [ 5671 ]

      SSL_OPTION_DEFAULTS = {
        cacertfile:           "/path/to/testca/cacert.pem",
        certfile:             "/path/to/server/cert.pem",
        keyfile:              "/path/to/server/key.pem",
        verify:               :verify_peer,
        fail_if_no_peer_cert: true,
      }



      begin
        require "openssl"
      rescue LoadError
      end

      def self.default_cert_store
        @default_cert_store ||= OpenSSL::X509::Store.new.tap do |cert_store|
          cert_store.set_default_paths
        end
      end

      @ssl_params = nil

      # :call-seq:
      #    Multidapter::ConnectionAdapter.enable_ssl(params = {})
      #
      # Enable SSL for all new instances.
      # +params+ is passed to OpenSSL::SSLContext#set_params.
      def self.enable_ssl(*args)
        @ssl_params = create_ssl_params(*args)
      end

      # Constructs proper parameters from arguments
      def self.create_ssl_params(verify_or_params = {}, certs = nil)
        begin
          params = verify_or_params.to_hash
        rescue NoMethodError
          params = {}
          params[:verify_mode] = verify_or_params
          if certs
            if File.file?(certs)
              params[:ca_file] = certs
            elsif File.directory?(certs)
              params[:ca_path] = certs
            end
          end
        end
        return params
      end

      # Disable SSL for all new instances.
      def self.disable_ssl
        @ssl_params = nil
      end

      # returns the SSL Parameters
      #
      # see also self.enable_ssl
      def self.ssl_params
        return @ssl_params
      end

      # returns +true+ if self.ssl_params is set
      def self.use_ssl?
        return !@ssl_params.nil?
      end

      # returns whether verify_mode is enable from self.ssl_params
      def self.verify
        return @ssl_params[:verify_mode]
      end

      # returns the :ca_file or :ca_path from self.ssl_params
      def self.certs
        return @ssl_params[:ca_file] || @ssl_params[:ca_path]
      end

    end
  end
end
