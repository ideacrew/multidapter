# frozen_string_literal: true

module URI
  class AMQP < Generic
    DEFAULT_PORT = 5672
  end
  @@schemes['AMQP'] = AMQP
end
