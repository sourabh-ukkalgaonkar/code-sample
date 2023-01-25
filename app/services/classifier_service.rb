# frozen_string_literal: true

require 'classifier-reborn'

# Service to train the data
class ClassifierService
  class ClassifierServiceError < StandardError; end
  class ClassifierNotFoundError < StandardError; end

  def train(data: [])
    data.each do |d|
      LSI.add_item d[:values], d[:category_name]
    end
  rescue StandardError
    raise ClassifierServiceError, 'Something went wrong while traning the data'
  end

  def check(query:)
    LSI.classify(query)
  rescue  Vector::ZeroVectorError
    raise ClassifierNotFoundError, 'Classification not found'
  rescue StandardError
    raise ClassifierServiceError, 'Something went wrong'
  end
end
