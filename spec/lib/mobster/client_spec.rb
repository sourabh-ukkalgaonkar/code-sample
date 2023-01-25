# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mobster::Client' do
  include_context 'common data'

  let(:mobster_client) { ::Mobster::Client.new }

  it 'should train the data' do
    stub_request(:post, 'http://localhost:3000/api/v1/mobster/classify')
      .with(
        body: { 'data' => [{ 'category_name' => 'Good', 'values' => ['Make time for exercise.'] },
                           { 'values' => ['Drink at least eight glasses of water a day.'] }, { 'values' => ['Do bodywork.'] }, { 'values' => ['Assign priorities to your tasks.'] }, { 'values' => ['Celebrate small victories.'], 'category_name' => 'Bad' }, { 'values' => ['Being Too Hard on Yourself'] }, { 'values' => ['Leaving Things to the Last Minute'] }, { 'values' => ['Focusing on the Negatives'] }, { 'values' => ['Blaming'] }, { 'values' => ['Sour Grapes'] }] },
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Length' => '471',
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Host' => 'localhost:3000',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/2.7.5p203'
        }
      )
      .to_return(status: 200, body: {
        "success": true,
        "message": 'Data has been trained successfully'
      }.to_json, headers: {})

    response = mobster_client.classify({ data: valid_data })
    response_json(response)

    expect(response.code).to be(200)
  end

  it 'should return Good clasification' do
    stub_request(:get, 'http://localhost:3000/api/v1/mobster/check?query=exercise')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'localhost:3000',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/2.7.5p203'
        }
      )
      .to_return(status: 200, body: {
        "success": true,
        "message": 'Classification has been found',
        "classification": 'Good'
      }.to_json, headers: {})

    response = mobster_client.check('exercise')
    response_json(response)

    expect(response.code).to be(200)
    expect(@response_json[:classification]).to eq('Good')
  end

  it 'should return Bad clasification' do
    stub_request(:get, 'http://localhost:3000/api/v1/mobster/check?query=Leaving')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'localhost:3000',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/2.7.5p203'
        }
      )
      .to_return(status: 200, body: {
        "success": true,
        "message": 'Classification has been found',
        "classification": 'Bad'
      }.to_json, headers: {})

    response = mobster_client.check('Leaving')
    response_json(response)

    expect(response.code).to be(200)
    expect(@response_json[:classification]).to eq('Bad')
  end

  it 'should not found the classification' do
    stub_request(:get, 'http://localhost:3000/api/v1/mobster/check?query=are')
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'localhost:3000',
          'User-Agent' => 'rest-client/2.1.0 (linux x86_64) ruby/2.7.5p203'
        }
      )
      .to_return(status: 404, body: {
        "success": false,
        "message": 'Classification not found'
      }.to_json, headers: {})

    expect { mobster_client.check('are') }.to raise_error(Mobster::Error::NotFound)
  end
end

def response_json(response)
  @response_json ||= JSON.parse(response.body, symbolize_names: true)
end
