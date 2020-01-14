# frozen_string_literal: true
require 'uri'
require 'cgi'
require 'dry-types'

module Types
  include Dry.Types()
  include Dry::Logic

  # URI                 = Coercible::String.constrained(format: /^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/)
  # URI                 = Coercible::String.constructor(->(val){ ::URI::parse(val) })
  URI                 = Types.Constructor(URI) { |value| ::URI::parse(value) }
  URL                 = URI

  # URL   = String.constrained(format: //)
  # URI   = String.constrained(format: /^#{URI::regexp}$/)
  # URL   = String.constrained(format: /^#{URI::regexp(%w(http https))}$/)

  Email               = Coercible::String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  Emails              = Array.of(Email)
  # CallableDateTime    = DateTime.default { DateTime.now }
  # PatternedFieldName  = String.constrained(format: /^[A-Za-z0-9_\-]+$/)
  PositiveInteger         = Coercible::Integer.constrained(gteq: 0)

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

end
