# frozen_string_literal: true

module Api
  # Configure all the API calls of the client.
  module Classification
    def classify(data)
      post('mobster/classify', data)
    end

    def check(query)
      get("mobster/check?query=#{query}")
    end
  end
end
