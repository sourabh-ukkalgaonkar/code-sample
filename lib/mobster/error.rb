# frozen_string_literal: true

module Mobster
  # defined all the errors
  class Error < ::StandardError
    class << self
      def errors
        @errors ||= {
          400 => Mobster::Error::BadRequest,
          404 => Mobster::Error::NotFound,
          500 => Mobster::Error::InternalServerError
        }
      end

      def on_complete(response)
        klass = errors[response.try(:http_code)&.to_i] || Mobster::Error::Unknown
        raise klass.new(klass.new(response.inspect)) # rubocop:disable Style/RaiseArgs
      end
    end

    # Raised when Mobster returns a 4xx HTTP status code
    ClientError = Class.new(self)

    # Raised when Mobster returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when Mobster returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Mobster returns the HTTP status code 500
    InternalServerError = Class.new(ClientError)

    # Raised when Mobster returns unknown status code
    Unknown = Class.new(self)
  end
end
