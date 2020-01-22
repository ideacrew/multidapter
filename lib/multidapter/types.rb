# frozen_string_literal: true
require 'uri'
require 'cgi'
require 'dry-types'

module Types
  include Dry.Types()
  include Dry::Logic

  # URI                 = Coercible::String.constrained(format: /^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/)
  # URI                 = Coercible::String.constructor(->(val){ ::URI::parse(val) })
  # URI                 = Types.Constructor(URI) { |value| ::URI::parse(value) }
  Uri                 = Types.Constructor(::URI) { |val| ::URI.parse(val) }
  Url                 = Uri

  # URL   = String.constrained(format: //)
  # URI   = String.constrained(format: /^#{URI::regexp}$/)
  # URL   = String.constrained(format: /^#{URI::regexp(%w(http https))}$/)

  Email               = Coercible::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  Emails              = Array.of(Email)
  CallableDateTime    = Types::DateTime.default { DateTime.now }

  PositiveInteger     = Coercible::Integer.constrained(gteq: 0)
  HashOrNil           = Types::Hash | Types::Nil
  StringOrNil         = Types::String | Types::Nil

  # ApiKeyLocation      = Coercible::Symbol.enum(:user, :password)
  # HttpApiKeyLocation  = Coercible::Symbol.enum(:query, :heder, :cookie)
  SecuritySchemeType  = Coercible::Symbol.enum(
    :user_password,
    :api_key,
    :x509,
    :symmetric_encryption,
    :asymmetric_encryption,
    :http_api_key,
    :http,
    :oauth2,
    :open_id_connect
  )
  
  ComponentTypes = Coercible::Symbol.enum(
    :schemas,
    :messages,
    :security_schemes,
    :parameters,
    :correlation_ids,
    :operation_traits,
    :messaage_traits,
    :server_bindings,
    :channel_bindings,
    :operation_bindings,
    :message_bindings,
  )
end
