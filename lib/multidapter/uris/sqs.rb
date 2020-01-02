# frozen_string_literal: true

module URI
  class SQS < Generic
  end
  @@schemes['SQS'] = SQS
end