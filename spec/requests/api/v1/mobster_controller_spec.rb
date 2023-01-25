# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::MobsterController', type: :request do
  include_context 'common data'

  let(:service) { ClassifierService.new }

  describe '#classify' do
    it 'should trained the data' do
      post '/api/v1/mobster/classify', params: { data: valid_data }
      expect(response).to have_http_status(:ok)
    end

    it 'should not trained the data' do
      post '/api/v1/mobster/classify', params: { data: nil }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe '#check' do
    before(:each) do
      service.train(data: valid_data)
    end

    it 'should return Good clasification' do
      get '/api/v1/mobster/check', params: { query: exercise }

      expect(response).to have_http_status(:ok)
      expect(response_json[:classification]).to eq(good)
    end

    it 'should return Bad clasification' do
      get '/api/v1/mobster/check', params: { query: leaving }

      expect(response).to have_http_status(:ok)
      expect(response_json[:classification]).to eq(bad)
    end

    it 'should not found the classification' do
      get '/api/v1/mobster/check', params: { query: are }

      expect(response).to have_http_status(:not_found)
    end
  end
end
