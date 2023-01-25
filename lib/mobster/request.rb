# frozen_string_literal: true

# Module to seperate the client
module Mobster
  # defined the requests types get, post. we can add the put and the patch method here as well.
  class Request
    def get(url)
      RestClient.get(request_url(url))
    rescue StandardError => e
      Mobster::Error.on_complete(e)
    end

    def post(url, params = {})
      RestClient.post(request_url(url), params)
    rescue StandardError => e
      Mobster::Error.on_complete(e)
    end
  end
  Dir[Rails.root.join('lib', 'mobster', 'api', '*.rb')].each { |f| require_dependency f }
end
