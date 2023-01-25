# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ClassifierService' do
  include_context 'common data'

  let(:subject) { ClassifierService.new }

  describe '#classify' do
    it 'should trained the data' do
      expect(subject.train(data: valid_data)).to eq(valid_data)
    end

    it 'should not trained the data' do
      expect { subject.train(data: nil) }.to raise_error(ClassifierService::ClassifierServiceError)
    end
  end

  describe '#check' do
    before(:each) do
      subject.train(data: valid_data)
    end

    it 'should return Good clasification' do
      expect(subject.check(query: exercise)).to eq(good)
    end

    it 'should return Bad clasification' do
      expect(subject.check(query: leaving)).to eq(bad)
    end

    it 'should raise ClassifierNotFoundError error' do
      expect { subject.check(query: test) }.to raise_error(ClassifierService::ClassifierNotFoundError)
    end
  end
end
