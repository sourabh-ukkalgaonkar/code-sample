# frozen_string_literal: true

module Mobster
  # Client setup
  class Client < Request
    attr_accessor :base_url

    include ::Api::Classification

    def initialize
      @base_url = ENV['BASE_URL'] || 'http://localhost:3000/api/v1'
    end

    private

    def request_url(path)
      "#{base_url}/#{path}"
    end
  end
end
