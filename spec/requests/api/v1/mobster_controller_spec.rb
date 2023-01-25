# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::MobsterController', type: :request do
  let(:valid_data) do
    [
      {
        category_name: 'Good',
        values: ['Make time for exercise.', 'Drink at least eight glasses of water a day.', 'Do bodywork.',
                 'Assign priorities to your tasks.', 'Celebrate small victories.']
      },
      {
        category_name: 'Bad',
        values: ['Being Too Hard on Yourself', 'Leaving Things to the Last Minute', 'Focusing on the Negatives',
                 'Blaming', 'Sour Grapes']
      }
    ]
  end

  it 'should trained the data' do
    post '/api/v1/mobster/classify', params: { data: valid_data }
    expect(response).to have_http_status(:ok)
  end

  it 'should not trained the data' do
    post '/api/v1/mobster/classify', params: { data: nil }
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
