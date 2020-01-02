# frozen_string_literal: true
require 'uri'
require 'dry-types'

module Types
  include Dry.Types()
  include Dry::Logic


  URI                 = String.constrained(format: /^(([^:\/?#]+):)?(\/\/([^\/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?/)
  URL                 = URI
  
  # URL                 = String.constrained(format: //)
  # URI   = String.constrained(format: /^#{URI::regexp}$/)
  # URL   = String.constrained(format: /^#{URI::regexp(%w(http https))}$/)

  Email               = String.constrained(format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
  # CallableDateTime    = DateTime.default { DateTime.now }
  # PatternedFieldName  = String.constrained(format: /^[A-Za-z0-9_\-]+$/)

  # ChannelType         = Coercible::Symbol.default(:routing_key).enum(:routing_key, :queue)
  # ExchangeType        = Coercible::Symbol.default(:default).enum(:topic, :fanout, :default, :direct)
  # MessageDeliveryMode = Strict::Integer #.constrained(included_in([1,2]))

  # HttpMethod          = String.enum(%w(GET POST PUT PATCH DELETE HEAD OPTIONS CONNECT TRACE))
  # HttpOperationType   = Coercible::Symbol.default(:request).enum(:request, :response)

  # PositiveInteger     = Coercible::Integer.constrained(gteq: 0)

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
