# frozen_string_literal: true
module URI
  class SFTP < FTP
    DEFAULT_PORT = 873
  end
  @@schemes['SFTP'] = SFTP
end
