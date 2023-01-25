# frozen_string_literal: true

require 'classifier-reborn'

# Service to train the data
class ClassifierService
  class ClassifierServiceError < StandardError; end

  def train(data: [])
    data.each do |d|
      $lsi.add_item d[:values], d[:category_name]
    end
  rescue StandardError => e
    raise ClassifierServiceError, 'Something went wrong while traning the data'
  end
end
