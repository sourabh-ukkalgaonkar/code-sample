# frozen_string_literal: true

module Requests
  module JsonHelpers
    def response_json
      @response_json ||= JSON.parse(response.body, symbolize_names: true)
    end
  end
end
